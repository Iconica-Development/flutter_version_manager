import "package:version_repository_interface/version_repository_interface.dart";

/// Version repository interface.
abstract class VersionRepositoryInterface {
  /// Get the current backend version.
  /// Returns the current backend version.
  Future<String> getCurrentBackendVersion();

  /// Update the backend version.
  /// [compatibility] The compatibility of the new version.
  /// [version] The new version.
  Future<void> updateBackendVersion(
    VersionCompatibiliy compatibility,
    Version version,
  );

  /// Get the required app version.
  /// Returns the required app version.
  Future<String> getRequiredAppVersion();
}
