import "package:version_repository_interface/src/models/compatibiliy.dart";
import "package:version_repository_interface/src/utils/version_string.dart";

/// A version.
class Version {
  /// Parse a version from a string.
  factory Version.parse({required String version}) {
    if (!version.isSemanticVersion()) {
      throw Exception("Invalid version format");
    }

    var versionParts = version.versionParts;

    return Version._(
      major: versionParts[0],
      minor: versionParts[1],
      patch: versionParts[2],
    );
  }

  /// Create a new version.
  const Version._({
    required this.major,
    required this.minor,
    required this.patch,
  });

  /// The major version.
  final String major;

  /// The minor version.
  final String minor;

  /// The patch version.
  final String patch;

  @override
  String toString() => "$major.$minor.$patch";

  /// Compare this version to another version.
  /// Returns the compatibility of the versions.
  VersionCompatibiliy compare(Version otherVersion) {
    if (major != otherVersion.major) {
      return major.compareTo(otherVersion.major) > 0
          ? VersionCompatibiliy.majorUpgrade
          : VersionCompatibiliy.majorDowngrade;
    }

    if (minor != otherVersion.minor) {
      return minor.compareTo(otherVersion.minor) > 0
          ? VersionCompatibiliy.minorUpgrade
          : VersionCompatibiliy.minorDowngrade;
    }

    if (patch != otherVersion.patch) {
      return patch.compareTo(otherVersion.patch) > 0
          ? VersionCompatibiliy.patchUpgrade
          : VersionCompatibiliy.patchDowngrade;
    }

    return VersionCompatibiliy.equivalent;
  }
}
