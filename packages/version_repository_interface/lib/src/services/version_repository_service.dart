import "package:version_repository_interface/src/interfaces/version_repository_interface.dart";
import "package:version_repository_interface/src/local/local_version_repository.dart";
import "package:version_repository_interface/src/models/compatibiliy.dart";
import "package:version_repository_interface/src/models/update_check_result.dart";
import "package:version_repository_interface/src/models/version.dart";

/// Service to interact with the version repository.
class VersionRepositoryService {
  /// Create a new [VersionRepositoryService].
  VersionRepositoryService({
    VersionRepositoryInterface? versionRepositoryInterface,
  }) : versionRepositoryInterface =
            versionRepositoryInterface ?? LocalVersionRepository();

  /// The repository to interact with. Defaults to [LocalVersionRepository].
  final VersionRepositoryInterface versionRepositoryInterface;

  /// Get the current backend version.
  /// Returns the current backend version.
  Future<Version> getCurrentBackendVersion() async => Version.parse(
        version: await versionRepositoryInterface.getCurrentBackendVersion(),
      );

  /// Update the backend version.
  /// [compatibility] The compatibility of the new version.
  /// [version] The new version.
  Future<void> updateBackendVersion(
    VersionCompatibiliy compatibility,
    Version version,
  ) async =>
      versionRepositoryInterface.updateBackendVersion(
        compatibility,
        version,
      );

  /// Get the required app version.
  /// Returns the required app version.
  Future<Version> getRequiredAppVersion() async => Version.parse(
        version: await versionRepositoryInterface.getRequiredAppVersion(),
      );

  /// Check for updates.
  /// [expected] The expected version.
  /// [current] The current version.
  /// [backendLeading] If the backend is leading. Defaults to `true`.
  /// Returns the result of the update check.
  Future<UpdateCheckResult> checkForUpdates({
    required String expected,
    required String current,
    bool backendLeading = true,
  }) async {
    var expectedVersion = Version.parse(version: expected);
    var currentVersion = Version.parse(version: current);

    var compatibiliy = expectedVersion.compare(currentVersion);

    if (compatibiliy == VersionCompatibiliy.majorUpgrade ||
        compatibiliy == VersionCompatibiliy.majorDowngrade) {
      return (
        leading: backendLeading ? "backend" : "frontend",
        compatibility: compatibiliy,
        update: backendLeading ? null : updateBackendVersion,
      );
    } else if (compatibiliy == VersionCompatibiliy.minorUpgrade ||
        compatibiliy == VersionCompatibiliy.minorDowngrade) {
      return (
        leading: backendLeading ? "backend" : "frontend",
        compatibility: compatibiliy,
        update: backendLeading ? null : updateBackendVersion,
      );
    } else if (compatibiliy == VersionCompatibiliy.patchUpgrade ||
        compatibiliy == VersionCompatibiliy.patchDowngrade) {
      return (
        leading: backendLeading ? "backend" : "frontend",
        compatibility: compatibiliy,
        update: backendLeading ? null : updateBackendVersion,
      );
    }

    return (
      leading: "none",
      compatibility: VersionCompatibiliy.equivalent,
      update: null,
    );
  }
}
