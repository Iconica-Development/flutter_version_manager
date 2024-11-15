/// Enum for version compatibility
enum VersionCompatibiliy {
  /// Major upgrade
  majorUpgrade,

  /// Major downgrade
  majorDowngrade,

  /// Minor upgrade
  minorUpgrade,

  /// Minor downgrade
  minorDowngrade,

  /// Patch upgrade
  patchUpgrade,

  /// Patch downgrade
  patchDowngrade,

  /// Equivalent
  equivalent,
}

/// Extension for version compatibility
extension Mandatory on VersionCompatibiliy {
  /// Check if the version compatibility is mandatory,
  /// meaning that the version must be updated.
  /// Only major upgrades and downgrades are mandatory.
  bool get isMandatory => [
        VersionCompatibiliy.majorUpgrade,
        VersionCompatibiliy.majorDowngrade,
      ].contains(this);
}

/// Extension for version compatibility
extension IsUp on VersionCompatibiliy {
  /// Check if the version compatibility is an upgrade.
  bool get isUpgrade => [
        VersionCompatibiliy.majorUpgrade,
        VersionCompatibiliy.minorUpgrade,
        VersionCompatibiliy.patchUpgrade,
      ].contains(this);
}

/// Extension for version compatibility
extension IsDown on VersionCompatibiliy {
  /// Check if the version compatibility is a downgrade.
  bool get isDowngrade => [
        VersionCompatibiliy.majorDowngrade,
        VersionCompatibiliy.minorDowngrade,
        VersionCompatibiliy.patchDowngrade,
      ].contains(this);
}
