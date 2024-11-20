import "package:version_repository_interface/src/interfaces/version_repository_interface.dart";
import "package:version_repository_interface/src/models/compatibiliy.dart";
import "package:version_repository_interface/src/models/version.dart";

/// A local version repository.
class LocalVersionRepository implements VersionRepositoryInterface {
  @override

  /// Get the current backend version.
  Future<String> getCurrentBackendVersion() async => "0.1.0";

  @override

  /// Update the backend version.
  Future<void> updateBackendVersion(
    VersionCompatibiliy compatibility,
    Version version,
  ) async {
    await Future.delayed(
      const Duration(seconds: 5),
    );

    return;
  }

  @override

  /// Get the required app version.
  Future<String> getRequiredAppVersion() async => "1.0.0";
}
