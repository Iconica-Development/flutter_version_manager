/// Extension for [String] to check if it is a semantic version.
extension VersionString on String {
  /// Check if the string is a semantic version.
  bool isSemanticVersion() {
    var versionParts = split(".");

    if (versionParts.length != 3) {
      return false;
    }

    var major = int.tryParse(versionParts[0]);
    var minor = int.tryParse(versionParts[1]);
    var patch = int.tryParse(versionParts[2]);

    if (major == null || minor == null || patch == null) {
      return false;
    }

    return true;
  }

  /// Get the version parts of the string.
  List<String> get versionParts => split(".");
}
