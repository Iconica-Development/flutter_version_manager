import "package:cloud_firestore/cloud_firestore.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:version_repository_interface/version_repository_interface.dart";

/// Firebase implementation of [VersionRepository].
class FirebaseVersionRepository implements VersionRepositoryInterface {
  /// Creates a new [FirebaseVersionRepository] instance.
  FirebaseVersionRepository({
    FirebaseFirestore? firestore,
    this.versionDoc,
    this.backendVersionKey = "version",
    this.minimumAppVersionKey = "minimumAppVersion",
  }) : firestore = firestore ?? FirebaseFirestore.instance;

  /// The Firestore instance.
  final FirebaseFirestore firestore;

  /// The document reference for the version.
  /// If not provided, it will default to the `version` document
  /// in the `version` collection.
  final DocumentReference? versionDoc;

  /// The key for the backend version.
  final String backendVersionKey;

  /// The key for the minimum app version.
  final String minimumAppVersionKey;

  /// The document reference for the version.
  /// Use this getter and not the `versionDoc` field directly.
  DocumentReference get versionDocment =>
      versionDoc ?? firestore.collection("version").doc("version");

  /// The shared preferences key for the string of the last version for which
  /// the optional update was interacted with.
  static const String sharedPrefsKey = "interacted_with_version";

  @override
  Future<String> getCurrentBackendVersion() async {
    var data = await versionDocment.get();
    var map = data.data() as Map<String, dynamic>?;

    return map?[backendVersionKey] as String;
  }

  @override
  Future<String?> getExpectedBackendVersion() async =>
      getKeyFromPubspecOrNull("backend-version");

  @override
  Future<String> getRequiredAppVersion() async {
    var data = await versionDocment.get();
    var map = data.data() as Map<String, dynamic>?;

    return map?[minimumAppVersionKey] as String;
  }

  @override
  Future<String?> getCurrentAppVersion() => getKeyFromPubspecOrNull("version");

  @override
  Future<void> updateBackendVersion(
    VersionCompatibiliy compatibility,
    Version version,
  ) {
    throw UnsupportedError(
      "This method is not supported by the Firebase version repository.",
    );
  }

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
