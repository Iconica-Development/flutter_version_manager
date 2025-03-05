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

  /// Get the expected backend version.
  /// Returns the expected backend version.
  Future<Version?> getExpectedBackendVersion() async {
    var expected = await versionRepositoryInterface.getExpectedBackendVersion();
    if (expected == null) {
      return null;
    }
    return Version.parse(version: expected);
  }

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

  /// Get the current app version.
  /// Returns the current app version.
  Future<Version?> getCurrentAppVersion() async {
    var current = await versionRepositoryInterface.getCurrentAppVersion();
    if (current == null) {
      return null;
    }
    return Version.parse(
      version: current.split("+").first,
    );
  }

  /// Check for updates.
  /// [expected] The expected version.
  /// [current] The current version.
  /// [backendLeading] If the backend is leading. Defaults to `true`.
  /// Returns the result of the update check.
  Future<UpdateCheckResult> checkForUpdates({
    required Version expected,
    required Version current,
    bool backendLeading = true,
  }) async {
    var compatibiliy = expected.compare(current);

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
