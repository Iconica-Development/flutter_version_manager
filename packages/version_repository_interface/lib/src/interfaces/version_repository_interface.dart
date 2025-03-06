import "package:version_repository_interface/version_repository_interface.dart";

/// Version repository interface.
abstract class VersionRepositoryInterface {
  /// Get the current backend version.
  /// Returns the current backend version.
  Future<String> getCurrentBackendVersion();

  /// Get the expected backend version.
  /// Returns the expected backend version.
  Future<String?> getExpectedBackendVersion();

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

  /// Get the current app version.
  /// Returns the current app version.
  Future<String?> getCurrentAppVersion();

  /// Called when yes or no is pressed on the optional update dialog to indicate
  /// that the user has interacted with the dialog.
  Future<void> interactWithOptionalUpdate(
    Version? version,
    VersionCompatibiliy type,
  );

  /// Check if the optional update dialog has been interacted with. If true the
  /// dialog will not be shown again.
  Future<bool> checkIfOptionalUpdateIsInteractedWith(
    Version? version,
    VersionCompatibiliy type,
  );
}
