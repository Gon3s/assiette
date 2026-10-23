import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:assiette/features/cloud_backup/data/database_snapshot_codec.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';

/// Limits apply to downloaded bytes, ZIP metadata and actual inflated bytes.
class BackupArchiveLimits {
  const BackupArchiveLimits({
    this.compressedBytes = 64 * 1024 * 1024,
    this.expandedBytes = 128 * 1024 * 1024,
    this.databaseBytes = 8 * 1024 * 1024,
    this.photoBytes = 16 * 1024 * 1024,
    this.entries = 2048,
  });

  final int compressedBytes;
  final int expandedBytes;
  final int databaseBytes;
  final int photoBytes;
  final int entries;
}

class DecodedBackup {
  const DecodedBackup({required this.snapshot, required this.photos});

  final Map<String, dynamic> snapshot;
  final Map<String, Uint8List> photos;
}

class BackupArchiveCodec {
  const BackupArchiveCodec({this.limits = const BackupArchiveLimits()});

  final BackupArchiveLimits limits;

  Future<Uint8List> encode(Map<String, dynamic> snapshot) async {
    try {
      await const DatabaseSnapshotCodec().validate(snapshot);
      final paths = const DatabaseSnapshotCodec().photoPathsIn(snapshot);
      final database = utf8.encode(jsonEncode(snapshot));
      var expanded = database.length;
      if (paths.length + 1 > limits.entries ||
          database.length > limits.databaseBytes) {
        throw CloudBackupException('Backup database exceeds the size limit');
      }
      final archive = Archive()
        ..addFile(ArchiveFile.bytes('database.json', database));
      for (final entry in paths.entries) {
        final file = File(entry.value);
        final size = await file.length();
        if (size < 1 ||
            size > limits.photoBytes ||
            expanded + size > limits.expandedBytes) {
          throw CloudBackupException('Backup photo exceeds the size limit');
        }
        final content = await _readBounded(file.openRead(), limits.photoBytes);
        if (content.isEmpty) {
          throw CloudBackupException('Backup photo is empty');
        }
        expanded += content.length;
        if (expanded > limits.expandedBytes) {
          throw CloudBackupException('Backup expanded size exceeds the limit');
        }
        archive.addFile(ArchiveFile.bytes('photos/${entry.key}', content));
      }
      if (expanded > limits.expandedBytes) {
        throw CloudBackupException('Backup expanded size exceeds the limit');
      }
      final bytes = ZipEncoder().encodeBytes(archive);
      if (bytes.length > limits.compressedBytes) {
        throw CloudBackupException('Backup archive exceeds the size limit');
      }
      return bytes;
    } on CloudBackupException {
      rethrow;
    } on Object {
      throw CloudBackupException('Backup could not be created');
    }
  }

  Future<Uint8List> readDownload(Stream<List<int>> stream) =>
      _readBounded(stream, limits.compressedBytes);

  Future<Uint8List> _readBounded(Stream<List<int>> stream, int limit) async {
    final builder = BytesBuilder(copy: false);
    await for (final chunk in stream) {
      if (builder.length + chunk.length > limit) {
        throw CloudBackupException('Backup download exceeds the size limit');
      }
      builder.add(chunk);
    }
    return builder.takeBytes();
  }

  Future<DecodedBackup> decode(Uint8List bytes) async {
    try {
      final headers = _readHeaders(bytes);
      final contents = <String, Uint8List>{};
      for (final header in headers) {
        final raw = header.file!.getRawContent();
        final builder = BytesBuilder(copy: false);
        final chunks = Stream<List<int>>.fromIterable([
          for (var offset = 0; offset < raw.length; offset += 1024)
            Uint8List.sublistView(
              raw,
              offset,
              math.min(offset + 1024, raw.length),
            ),
        ]);
        // archive's platform decoder buffers the whole inflated file before
        // writing to OutputStream. This stream checks each chunk immediately.
        final stream = header.compressionMethod == 8
            ? ZLibCodec(raw: true).decoder.bind(chunks)
            : chunks;
        await for (final chunk in stream) {
          if (builder.length + chunk.length > header.uncompressedSize) {
            throw CloudBackupException(
              'Backup entry exceeds its declared size',
            );
          }
          builder.add(chunk);
        }
        final content = builder.takeBytes();
        if (content.length != header.uncompressedSize ||
            getCrc32(content) != header.crc32) {
          throw CloudBackupException('Backup entry is corrupt');
        }
        contents[header.filename] = content;
      }
      final database = contents.remove('database.json');
      if (database == null) {
        throw CloudBackupException('Backup archive has no database.json');
      }
      final snapshot = jsonDecode(utf8.decode(database));
      if (snapshot is! Map<String, dynamic>) {
        throw CloudBackupException('Backup database must be an object');
      }
      return DecodedBackup(
        snapshot: snapshot,
        photos: {
          for (final entry in contents.entries)
            entry.key.substring(7): entry.value,
        },
      );
    } on CloudBackupException {
      rethrow;
    } on Object {
      throw CloudBackupException('Backup archive is invalid');
    }
  }

  List<ZipFileHeader> _readHeaders(Uint8List bytes) {
    if (bytes.length > limits.compressedBytes || bytes.length < 22) {
      throw CloudBackupException('Backup archive has an invalid size');
    }
    final data = ByteData.sublistView(bytes);
    int uint16(int offset) => data.getUint16(offset, Endian.little);
    int uint32(int offset) => data.getUint32(offset, Endian.little);
    var end = bytes.length - 22;
    final first = math.max(0, end - 65535);
    while (end >= first &&
        (uint32(end) != 0x06054b50 ||
            end + 22 + uint16(end + 20) != bytes.length)) {
      end--;
    }
    if (end < first) {
      throw CloudBackupException(
        'Backup ZIP directory is missing or truncated',
      );
    }
    final count = uint16(end + 10);
    final directorySize = uint32(end + 12);
    final directoryOffset = uint32(end + 16);
    // Backups are small single-disk ZIPs. ZIP64 and split archives are rejected.
    if (uint16(end + 4) != 0 ||
        uint16(end + 6) != 0 ||
        uint16(end + 8) != count ||
        count < 1 ||
        count > limits.entries ||
        directoryOffset + directorySize != end) {
      throw CloudBackupException('Unsupported backup ZIP directory');
    }
    final headers = <ZipFileHeader>[];
    final names = <String>{};
    final ranges = <({int start, int end})>[];
    var offset = directoryOffset;
    var expandedSize = 0;
    for (var index = 0; index < count; index++) {
      if (offset + 46 > end || uint32(offset) != 0x02014b50) {
        throw CloudBackupException('Backup ZIP header is truncated');
      }
      final next =
          offset +
          46 +
          uint16(offset + 28) +
          uint16(offset + 30) +
          uint16(offset + 32);
      final local = uint32(offset + 42);
      final compressed = uint32(offset + 20);
      final expanded = uint32(offset + 24);
      if (next > end ||
          local + 30 > directoryOffset ||
          uint32(local) != 0x04034b50) {
        throw CloudBackupException('Invalid backup ZIP entry');
      }
      final flags = uint16(offset + 8);
      final method = uint16(offset + 10);
      final contentEnd =
          local + 30 + uint16(local + 26) + uint16(local + 28) + compressed;
      final descriptorSize = flags & 8 == 0
          ? 0
          : contentEnd + 4 <= directoryOffset &&
                uint32(contentEnd) == 0x08074b50
          ? 16
          : 12;
      if (contentEnd + descriptorSize > directoryOffset ||
          uint16(offset + 34) != 0 ||
          flags & ~0x808 != 0 ||
          uint16(local + 6) != flags ||
          uint16(local + 8) != method ||
          (method != 0 && method != 8)) {
        throw CloudBackupException('Unsupported backup ZIP entry');
      }
      final input = InputMemoryStream(bytes)..setPosition(offset + 4);
      final header = ZipFileHeader()
        ..read(input, fileBytes: InputMemoryStream(bytes));
      final name = header.filename;
      final file = header.file!;
      final mode = (header.externalFileAttributes >> 16) & 0xf000;
      if (name != 'database.json' &&
          (!name.startsWith('photos/') ||
              !DatabaseSnapshotCodec.isPhotoFileName(name.substring(7)))) {
        throw CloudBackupException('Unexpected backup entry name');
      }
      if (!names.add(name.toLowerCase()) ||
          file.filename != name ||
          file.crc32 != header.crc32 ||
          file.compressedSize != compressed ||
          file.uncompressedSize != expanded ||
          (mode != 0 && mode != 0x8000) ||
          header.externalFileAttributes & 0x10 != 0) {
        throw CloudBackupException('Duplicate or invalid backup ZIP entry');
      }
      final sizeLimit = name == 'database.json'
          ? limits.databaseBytes
          : limits.photoBytes;
      expandedSize += expanded;
      if (expanded < 1 ||
          expanded > sizeLimit ||
          expandedSize > limits.expandedBytes) {
        throw CloudBackupException('Backup expanded size exceeds the limit');
      }
      ranges.add((start: local, end: contentEnd + descriptorSize));
      headers.add(header);
      offset = next;
    }
    if (offset != end) {
      throw CloudBackupException('Backup ZIP entry count is inconsistent');
    }
    ranges.sort((a, b) => a.start.compareTo(b.start));
    for (var index = 1; index < ranges.length; index++) {
      if (ranges[index].start < ranges[index - 1].end) {
        throw CloudBackupException('Backup ZIP entries overlap');
      }
    }
    return headers;
  }
}
