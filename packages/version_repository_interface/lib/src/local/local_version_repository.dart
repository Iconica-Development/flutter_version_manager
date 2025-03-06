import "package:shared_preferences/shared_preferences.dart";
import "package:version_repository_interface/src/interfaces/version_repository_interface.dart";
import "package:version_repository_interface/src/models/compatibiliy.dart";
import "package:version_repository_interface/src/models/version.dart";
import "package:version_repository_interface/src/utils/get_version.dart";

/// A local version repository.
class LocalVersionRepository implements VersionRepositoryInterface {
  /// The shared preferences key for the string of the last version for which
  /// the optional update was interacted with.
  static const String sharedPrefsKey = "interacted_with_version";

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

  @override
  Future<bool> checkIfOptionalUpdateIsInteractedWith(
    Version? version,
    VersionCompatibiliy type,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    var storedVersion = prefs.getString(sharedPrefsKey);
    if (storedVersion == version?.toString()) {
      return true;
    }
    return false;
  }

  @override
  Future<void> interactWithOptionalUpdate(
    Version? version,
    VersionCompatibiliy type,
  ) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharedPrefsKey, version.toString());
  }
}
