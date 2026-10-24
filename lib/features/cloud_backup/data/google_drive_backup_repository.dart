import 'dart:io';
import 'dart:typed_data';

import 'package:assiette/data/db/app_database.dart';
import 'package:assiette/features/cloud_backup/data/backup_archive_codec.dart';
import 'package:assiette/features/cloud_backup/data/backup_restorer.dart';
import 'package:assiette/features/cloud_backup/data/database_snapshot_codec.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_exception.dart';
import 'package:assiette/features/cloud_backup/domain/cloud_backup_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// [CloudBackupRepository] backed by Google Drive's hidden `appDataFolder`
/// (US-26): a single zip (`database.json` + referenced photos) that fully
/// overwrites, and is fully overwritten by, the local state on every
/// backup/restore.
class GoogleDriveBackupRepository implements CloudBackupRepository {
  /// Creates a [GoogleDriveBackupRepository] backed by [_db].
  GoogleDriveBackupRepository({
    required this._db,
    DatabaseSnapshotCodec? codec,
  }) : _codec = codec ?? const DatabaseSnapshotCodec();

  final AppDatabase _db;
  final DatabaseSnapshotCodec _codec;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static const List<String> _scopes = [drive.DriveApi.driveAppdataScope];
  static const _backupFileName = 'assiette_backup.zip';
  static const _photosDirName = 'meal_photos';

  // Android's Credential Manager (used by google_sign_in v7) always
  // requires a "Web application" OAuth client ID here, even for an
  // Android-only, client-side flow — it has nothing to do with a backend.
  // Passed at build time: --dart-define=GOOGLE_SERVER_CLIENT_ID=xxx.
  static const _serverClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );

  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    if (_serverClientId.isEmpty) {
      throw CloudBackupException(
        'Missing --dart-define=GOOGLE_SERVER_CLIENT_ID at build time',
      );
    }
    await _googleSignIn.initialize(serverClientId: _serverClientId);
    _initialized = true;
  }

  Future<GoogleSignInAccount?> _silentAccount() async {
    await _ensureInitialized();
    final future = _googleSignIn.attemptLightweightAuthentication();
    if (future == null) return null;
    return future;
  }

  @override
  Future<String?> signInSilently() async {
    final account = await _wrapErrors(_silentAccount);
    return account?.email;
  }

  @override
  Future<String> signIn() async {
    await _ensureInitialized();
    final account = await _wrapErrors(
      () => _googleSignIn.authenticate(scopeHint: _scopes),
    );
    return account.email;
  }

  @override
  Future<void> signOut() async {
    await _ensureInitialized();
    await _wrapErrors(_googleSignIn.signOut);
  }

  @override
  Future<bool> hasRemoteBackup() async {
    final account = await _requireAccount();
    final file = await _wrapErrors(
      () => _withDriveApi(account, _findBackupFile),
    );
    return file != null;
  }

  @override
  Future<void> backupNow() async {
    final account = await _requireAccount();
    final snapshot = await _codec.export(_db);
    final zipBytes = await const BackupArchiveCodec().encode(snapshot);

    await _wrapErrors(
      () => _withDriveApi(account, (api) => _upload(api, zipBytes)),
    );
    await _db.cloudBackupStateDao.setLastBackupAt(DateTime.now().toUtc());
  }

  @override
  Future<void> restoreLatest() async {
    final account = await _requireAccount();
    final zipBytes = await _wrapErrors(
      () => _withDriveApi(account, _download),
    );

    final photosDir = await _photosDir();
    await BackupRestorer(
      snapshotCodec: _codec,
    ).restore(_db, zipBytes, photosDir);
  }

  Future<GoogleSignInAccount> _requireAccount() async {
    final account = await _wrapErrors(_silentAccount);
    if (account == null) {
      throw CloudBackupException('Not signed in to Google');
    }
    return account;
  }

  Future<Directory> _photosDir() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    return Directory(p.join(documentsDir.path, _photosDirName));
  }

  Future<drive.File?> _findBackupFile(drive.DriveApi api) async {
    final result = await api.files.list(
      spaces: 'appDataFolder',
      q: "name = '$_backupFileName' and trashed = false",
      $fields: 'files(id, name)',
    );
    final files = result.files;
    if (files == null || files.isEmpty) return null;
    return files.first;
  }

  Future<void> _upload(drive.DriveApi api, Uint8List zipBytes) async {
    final media = drive.Media(Stream.value(zipBytes), zipBytes.length);
    final existing = await _findBackupFile(api);
    if (existing == null) {
      await api.files.create(
        drive.File(name: _backupFileName, parents: ['appDataFolder']),
        uploadMedia: media,
      );
    } else {
      await api.files.update(drive.File(), existing.id!, uploadMedia: media);
    }
  }

  Future<Uint8List> _download(drive.DriveApi api) async {
    final existing = await _findBackupFile(api);
    if (existing == null) {
      throw CloudBackupException('No backup found', isNotFound: true);
    }
    final media = await api.files.get(
      existing.id!,
      downloadOptions: drive.DownloadOptions.fullMedia,
    ) as drive.Media;
    return const BackupArchiveCodec().readDownload(media.stream);
  }

  Future<T> _withDriveApi<T>(
    GoogleSignInAccount account,
    Future<T> Function(drive.DriveApi api) action,
  ) async {
    final authorization =
        await account.authorizationClient.authorizationForScopes(_scopes) ??
        await account.authorizationClient.authorizeScopes(_scopes);
    final httpClient = _BearerHttpClient(authorization.accessToken);
    try {
      return await action(drive.DriveApi(httpClient));
    } finally {
      httpClient.close();
    }
  }

  Future<T> _wrapErrors<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on CloudBackupException {
      rethrow;
    } on GoogleSignInException catch (e) {
      throw CloudBackupException(e.description ?? e.code.toString());
    } on drive.DetailedApiRequestError catch (e) {
      throw CloudBackupException(e.message ?? 'Drive API error');
    } on SocketException catch (e) {
      throw CloudBackupException(e.message);
    } on HttpException catch (e) {
      throw CloudBackupException(e.message);
    }
  }
}

/// An [http.Client] that attaches a Google OAuth bearer token to every
/// request, for use with [drive.DriveApi].
class _BearerHttpClient extends http.BaseClient {
  _BearerHttpClient(this._accessToken);

  final String _accessToken;
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'Bearer $_accessToken';
    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
