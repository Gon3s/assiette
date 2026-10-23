import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:assiette/features/cloud_backup/data/backup_archive_codec.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const codec = BackupArchiveCodec();
  final rejectsBackup = throwsA(isA<CloudBackupException>());

  Uint8List zip({List<ArchiveFile> photos = const [], String database = '{}'}) {
    final archive = Archive()
      ..addFile(ArchiveFile.string('database.json', database));
    photos.forEach(archive.addFile);
    return ZipEncoder().encodeBytes(archive);
  }

  int headerOffset(Uint8List bytes, int index) {
    final data = ByteData.sublistView(bytes);
    var offset = data.getUint32(bytes.length - 6, Endian.little);
    for (var current = 0; current < index; current++) {
      offset +=
          46 +
          data.getUint16(offset + 28, Endian.little) +
          data.getUint16(offset + 30, Endian.little) +
          data.getUint16(offset + 32, Endian.little);
    }
    return offset;
  }

  test('decodes a valid database and photo with verified content', () async {
    final backup = await codec.decode(
      zip(
        photos: [
          ArchiveFile.bytes('photos/a.jpg', [1, 2, 3]),
        ],
      ),
    );
    expect(backup.snapshot, isEmpty);
    expect(backup.photos, {
      'a.jpg': [1, 2, 3],
    });
  });

  for (final removedBytes in [1, 20, 25]) {
    test('rejects a ZIP truncated by $removedBytes bytes', () async {
      final bytes = zip();
      await expectLater(
        codec.decode(
          Uint8List.sublistView(bytes, 0, bytes.length - removedBytes),
        ),
        rejectsBackup,
      );
    });
  }

  test('rejects arbitrary bytes and a ZIP without a database', () async {
    await expectLater(
      codec.decode(Uint8List.fromList([1, 2, 3])),
      rejectsBackup,
    );
    final bytes = ZipEncoder().encodeBytes(
      Archive()..addFile(ArchiveFile.bytes('photos/a.jpg', [1])),
    );
    await expectLater(codec.decode(bytes), rejectsBackup);
  });

  for (final database in ['[]', 'null', '{invalid', '[1,2]']) {
    test('rejects a database that is not a JSON object: $database', () async {
      await expectLater(codec.decode(zip(database: database)), rejectsBackup);
    });
  }

  for (final name in [
    '/tmp/a.jpg',
    '../a.jpg',
    'photos/../a.jpg',
    'photos/./a.jpg',
    r'photos\a.jpg',
    'photos/sub/a.jpg',
    'photos/a.exe',
    'photos/CON.jpg',
    'C:/a.jpg',
    'photos/',
    'other.json',
    'photos/a.jpg\u0000',
  ]) {
    test('rejects unsafe or unexpected entry $name', () async {
      await expectLater(
        codec.decode(
          zip(
            photos: [
              ArchiveFile.bytes(name, [1]),
            ],
          ),
        ),
        rejectsBackup,
      );
    });
  }

  test('rejects symbolic links before reading their contents', () async {
    final bytes = zip(
      photos: [
        ArchiveFile.bytes('photos/a.jpg', [1]),
      ],
    );
    final offset = headerOffset(bytes, 1);
    ByteData.sublistView(
      bytes,
    ).setUint32(offset + 38, 0xa1ff << 16, Endian.little);
    await expectLater(codec.decode(bytes), rejectsBackup);
  });

  test('rejects duplicate names even with different letter casing', () async {
    final bytes = zip(
      photos: [
        ArchiveFile.bytes('photos/a.jpg', [1]),
        ArchiveFile.bytes('photos/A.jpg', [2]),
      ],
    );
    await expectLater(codec.decode(bytes), rejectsBackup);
  });

  test(
    'rejects exact duplicates even when an archive library would merge them',
    () async {
      final bytes = zip(
        photos: [
          ArchiveFile.bytes('photos/a.jpg', [1]),
          ArchiveFile.bytes('photos/b.jpg', [2]),
        ],
      );
      final offset = headerOffset(bytes, 2);
      final local = ByteData.sublistView(
        bytes,
      ).getUint32(offset + 42, Endian.little);
      bytes[offset + 46 + 7] = 'a'.codeUnitAt(0);
      bytes[local + 30 + 7] = 'a'.codeUnitAt(0);
      await expectLater(codec.decode(bytes), rejectsBackup);
    },
  );

  test('rejects mismatched local and central entry names', () async {
    final bytes = zip();
    bytes[30] = 'x'.codeUnitAt(0);
    await expectLater(codec.decode(bytes), rejectsBackup);
  });

  test('rejects encrypted entries and unknown compression methods', () async {
    for (final encrypted in [true, false]) {
      final bytes = zip();
      final offset = headerOffset(bytes, 0);
      final data = ByteData.sublistView(bytes);
      if (encrypted) {
        data
          ..setUint16(offset + 8, 1, Endian.little)
          ..setUint16(6, 1, Endian.little);
      } else {
        data
          ..setUint16(offset + 10, 99, Endian.little)
          ..setUint16(8, 99, Endian.little);
      }
      await expectLater(codec.decode(bytes), rejectsBackup);
    }
  });

  test('rejects corrupt content using the central directory CRC', () async {
    final bytes = zip(
      photos: [
        ArchiveFile.noCompress('photos/a.jpg', 3, [1, 2, 3]),
      ],
    );
    final offset = headerOffset(bytes, 1);
    final data = ByteData.sublistView(bytes);
    final local = data.getUint32(offset + 42, Endian.little);
    final start =
        local +
        30 +
        data.getUint16(local + 26, Endian.little) +
        data.getUint16(local + 28, Endian.little);
    bytes[start] ^= 0xff;
    await expectLater(codec.decode(bytes), rejectsBackup);
  });

  test('stops inflation when actual bytes exceed falsified metadata', () async {
    final bytes = zip(
      photos: [ArchiveFile.bytes('photos/a.jpg', Uint8List(100000))],
    );
    final offset = headerOffset(bytes, 1);
    final data = ByteData.sublistView(bytes);
    final local = data.getUint32(offset + 42, Endian.little);
    data
      ..setUint32(offset + 24, 1, Endian.little)
      ..setUint32(local + 22, 1, Endian.little);
    await expectLater(
      codec.decode(bytes),
      throwsA(
        isA<CloudBackupException>().having(
          (error) => error.message,
          'message',
          contains('declared size'),
        ),
      ),
    );
  });

  test('enforces every archive budget before inflating entries', () async {
    final bytes = zip(
      photos: [ArchiveFile.bytes('photos/a.jpg', List.filled(16, 1))],
    );
    final budgets = [
      BackupArchiveLimits(compressedBytes: bytes.length - 1),
      const BackupArchiveLimits(expandedBytes: 17),
      const BackupArchiveLimits(photoBytes: 15),
      const BackupArchiveLimits(databaseBytes: 1),
      const BackupArchiveLimits(entries: 1),
    ];
    for (final budget in budgets) {
      await expectLater(
        BackupArchiveCodec(limits: budget).decode(bytes),
        rejectsBackup,
      );
    }
  });

  test(
    'rejects inconsistent ZIP directory counts and overlapping entries',
    () async {
      final bytes = zip(
        photos: [
          ArchiveFile.bytes('photos/a.jpg', [1]),
        ],
      );
      ByteData.sublistView(bytes)
        ..setUint16(bytes.length - 12, 1, Endian.little)
        ..setUint16(bytes.length - 14, 1, Endian.little);
      await expectLater(codec.decode(bytes), rejectsBackup);
      final overlapping = zip(
        photos: [
          ArchiveFile.bytes('photos/a.jpg', [1]),
        ],
      );
      ByteData.sublistView(
        overlapping,
      ).setUint32(headerOffset(overlapping, 1) + 42, 0, Endian.little);
      await expectLater(codec.decode(overlapping), rejectsBackup);
    },
  );

  test(
    'bounds downloads and cancels the source after the first excess chunk',
    () async {
      var read = 0;
      var cancelled = false;
      Stream<List<int>> download() async* {
        try {
          for (var index = 0; index < 5; index++) {
            read++;
            yield [1, 2];
          }
        } finally {
          cancelled = true;
        }
      }

      const bounded = BackupArchiveCodec(
        limits: BackupArchiveLimits(compressedBytes: 3),
      );
      await expectLater(bounded.readDownload(download()), rejectsBackup);
      expect(read, 2);
      expect(cancelled, isTrue);
      expect(await bounded.readDownload(Stream.value([1, 2, 3])), [1, 2, 3]);
    },
  );

  test('preserves a JSON database exactly', () async {
    final snapshot = {'formatVersion': 5, 'tags': <Object>[]};
    expect(
      (await codec.decode(zip(database: jsonEncode(snapshot)))).snapshot,
      snapshot,
    );
  });
}
