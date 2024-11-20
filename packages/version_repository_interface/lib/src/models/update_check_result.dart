import "package:version_repository_interface/version_repository_interface.dart";

/// The result of an update check.
/// [leading] The leading part of the update. Either "backend" or "frontend".
/// [compatibility] The compatibility of the versions.
/// [update] The update function.
typedef UpdateCheckResult = ({
  String leading,
  VersionCompatibiliy compatibility,
  Future<void> Function(
    VersionCompatibiliy versionCompatibiliy,
    Version newVersion,
  )? update,
});
