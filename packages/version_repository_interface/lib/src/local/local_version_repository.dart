import "package:version_repository_interface/src/interfaces/version_repository_interface.dart";
import "package:version_repository_interface/src/models/compatibiliy.dart";
import "package:version_repository_interface/src/models/version.dart";
import "package:version_repository_interface/src/utils/get_version.dart";

/// A local version repository.
class LocalVersionRepository implements VersionRepositoryInterface {
  /// Get the current backend version.
  @override
  Future<String> getCurrentBackendVersion() async => "0.1.0";

  /// Get the expected backend version.
  @override
  Future<String?> getExpectedBackendVersion() async =>
      getKeyFromPubspecOrNull("backend-version");

  /// Update the backend version.
  @override
  Future<void> updateBackendVersion(
    VersionCompatibiliy compatibility,
    Version version,
  ) async {
    await Future.delayed(
      const Duration(seconds: 5),
    );

    return;
  }

  /// Get the required app version.
  @override
  Future<String> getRequiredAppVersion() async => "1.0.0";

  /// Get the current app version.
  @override
  Future<String?> getCurrentAppVersion() async =>
      getKeyFromPubspecOrNull("version");
}
