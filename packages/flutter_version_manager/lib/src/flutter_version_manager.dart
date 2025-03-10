// ignore_for_file: avoid_positional_boolean_parameters

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_version_manager/src/check_updates.dart";
import "package:flutter_version_manager/src/config/version_manager_config.dart";
import "package:flutter_version_manager/src/ui/widgets/mandatory_update_dialog.dart";
import "package:flutter_version_manager/src/ui/widgets/optional_update_dialog.dart";
import "package:flutter_version_manager/src/utils/scope.dart";
import "package:version_repository_interface/version_repository_interface.dart";

/// A widget that checks for updates.
class FlutterVersionManager extends StatelessWidget {
  /// Creates a [FlutterVersionManager].
  const FlutterVersionManager({
    required this.child,
    this.service,
    this.config,
    this.onMandatoryUpdate,
    this.onOptionalUpdate,
    this.onUpdateEnd,
    super.key,
  }) : assert(
          // ignore: avoid_bool_literals_in_conditional_expressions
          onMandatoryUpdate != null || onOptionalUpdate != null
              ? onUpdateEnd != null
              : true,
          "onUpdateEnd must be provided if onMandatoryUpdate or "
          "onOptionalUpdate is provided",
        );

  /// The child widget.
  final Widget child;

  /// The function to call when a mandatory update is required.
  /// When this function is not null, the default mandatory
  /// update dialog will not be shown.
  /// If either this or [onOptionalUpdate] is provided,
  /// [onUpdateEnd] must be provided.
  final Future<bool> Function(
    VersionCompatibiliy compatibility,
    bool backendLeading,
  )? onMandatoryUpdate;

  /// The function to call when an optional update is available.
  /// When this function is not null, the default optional
  /// update dialog will not be shown.
  /// If either this or [onMandatoryUpdate] is provided,
  /// [onUpdateEnd] must be provided.
  final Future<bool> Function(
    VersionCompatibiliy compatibility,
    bool backendLeading,
  )? onOptionalUpdate;

  /// The function to call when the update is complete.
  final VoidCallback? onUpdateEnd;

  /// The service to use. Defaults to [VersionRepositoryService].
  final VersionRepositoryService? service;

  /// The configuration for the version manager.
  final VersionManagerConfig? config;

  @override
  Widget build(BuildContext context) => VersionManagerScope(
        config: config ?? const VersionManagerConfig(),
        service: service ?? VersionRepositoryService(),
        child: _VersionManagerInitializer(
          onMandatoryUpdate: onMandatoryUpdate,
          onOptionalUpdate: onOptionalUpdate,
          onUpdateEnd: onUpdateEnd,
          child: child,
        ),
      );
}

class _VersionManagerInitializer extends StatefulWidget {
  const _VersionManagerInitializer({
    required this.child,
    required this.onMandatoryUpdate,
    required this.onOptionalUpdate,
    required this.onUpdateEnd,
  });

  final Widget child;
  final Future<bool> Function(VersionCompatibiliy, bool)? onMandatoryUpdate;
  final Future<bool> Function(VersionCompatibiliy, bool)? onOptionalUpdate;
  final VoidCallback? onUpdateEnd;

  @override
  State<_VersionManagerInitializer> createState() =>
      _VersionManagerInitializerState();
}

class _VersionManagerInitializerState
    extends State<_VersionManagerInitializer> {
  @override
  void initState() {
    super.initState();
    unawaited(_checkForUpdates());
  }

  Future<void> _checkForUpdates() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      var scope = VersionManagerScope.of(context);
      var service = scope.service;
      var config = scope.config;

      await checkForUpdates(
        service: service,
        backendLeading: config.backendLeading,
        compareAppVersionOnly: config.compareAppVersionOnly,
        onMandatoryUpdate: (compatibility, backendLeading) =>
            widget.onMandatoryUpdate?.call(compatibility, backendLeading) ??
            _defaultMandatoryUpdate(
              context,
              compatibility,
              backendLeading,
            ),
        onOptionalUpdate: (compatibility, backendLeading, expectedAppVersion) =>
            widget.onOptionalUpdate?.call(compatibility, backendLeading) ??
            _defaultOptionalUpdate(
              context,
              compatibility: compatibility,
              backendLeading: backendLeading,
              expectedAppVersion: expectedAppVersion,
            ),
        onUpdateEnd: widget.onUpdateEnd ?? _defaultOnUpdateEnd,
      );
    });
  }

  Future<bool> _defaultMandatoryUpdate(
    BuildContext context,
    VersionCompatibiliy compatibility,
    bool backendLeading,
  ) async {
    if (backendLeading) {
      return DefaultMandatoryUpdateDialogBackendLeading
          .showMandatoryUpdateDialog(
        context,
      );
    } else {
      return DefaultMandatoryUpdateDialogFrontendLeading
          .showMandatoryUpdateDialog(
        context,
      );
    }
  }

  Future<bool> _defaultOptionalUpdate(
    BuildContext context, {
    required VersionCompatibiliy compatibility,
    required bool backendLeading,
    required Version? expectedAppVersion,
  }) async {
    if (backendLeading) {
      return DefaultOptionalUpdateDialogBackendLeading.showOptionalUpdateDialog(
        context,
        compatibility,
        expectedAppVersion,
      );
    } else {
      return DefaultOptionalUpdateDialogFrontendLeading
          .showOptionalUpdateDialog(
        context,
      );
    }
  }

  void _defaultOnUpdateEnd() {
    if (!(ModalRoute.of(context)?.isCurrent ?? true)) {
      Navigator.of(context).pop();
    }

    var config = VersionManagerScope.of(context).config;
    var translations = config.translations;

    ScaffoldMessenger.of(context).showSnackBar(
      config.builders.updateEndSnackbarBuilder?.call(context) ??
          SnackBar(
            content: Text(
              translations.updateCompleteTitle,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
