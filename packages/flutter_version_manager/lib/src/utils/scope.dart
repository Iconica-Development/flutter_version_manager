import "package:flutter/widgets.dart";

import "package:flutter_version_manager/src/config/version_manager_config.dart";
import "package:version_repository_interface/version_repository_interface.dart";

/// A widget that provides the [VersionManagerConfig] and
/// [VersionRepositoryService]. To all
class VersionManagerScope extends InheritedWidget {
  /// Creates a [VersionManagerScope].
  const VersionManagerScope({
    required this.config,
    required this.service,
    required super.child,
    super.key,
  });

  /// The configuration for the version manager userstory
  final VersionManagerConfig config;

  /// The service to use.
  final VersionRepositoryService service;

  @override
  bool updateShouldNotify(VersionManagerScope oldWidget) =>
      config != oldWidget.config || service != oldWidget.service;

  /// Gets the [VersionManagerScope] from the [BuildContext].
  static VersionManagerScope of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<VersionManagerScope>()!;
}
