// ignore_for_file: avoid_positional_boolean_parameters

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_version_manager/flutter_version_manager.dart";

/// A widget that checks for updates.
class FlutterVersionManager extends StatefulWidget {
  /// Creates a [FlutterVersionManager].
  const FlutterVersionManager({
    required this.child,
    this.service,
    this.config,
    this.backendLeading = true,
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

  /// If the backend is leading. Defaults to `true`.
  /// If `true`, the backend is leading.
  /// If `false`, the frontend is leading.
  final bool backendLeading;

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
  State<FlutterVersionManager> createState() => _FlutterVersionManagerState();
}

class _FlutterVersionManagerState extends State<FlutterVersionManager> {
  late VersionManagerTranslations translations;

  @override
  void initState() {
    super.initState();
    translations =
        widget.config?.translations ?? const VersionManagerTranslations.empty();
    Future.delayed(
      Duration.zero,
      () async => checkForUpdates(
        service: widget.service ?? VersionRepositoryService(),
        backendLeading: widget.backendLeading,
        onMandatoryUpdate: widget.onMandatoryUpdate ?? _defaultMandatoryUpdate,
        onOptionalUpdate: widget.onOptionalUpdate ?? _defaultOptionalUpdate,
        onUpdateEnd: widget.onUpdateEnd ?? _defaultOnUpdateEnd,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;

  Future<bool> _defaultMandatoryUpdate(
    VersionCompatibiliy compatibility,
    bool backendLeading,
  ) async {
    if (backendLeading) {
      unawaited(
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) =>
              widget.config?.mandatoryUpdateDialogBuilderBackendleading
                  ?.call(context) ??
              AlertDialog(
                title: Text(
                  translations.mandatoryUpdateTitle,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      translations.mandatoryUpdateBody,
                    ),
                  ],
                ),
              ),
        ),
      );
      return false;
    } else {
      unawaited(
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) =>
              widget.config?.mandatoryUpdateDialogBuilderFrontendleading
                  ?.call(context) ??
              AlertDialog(
                title: Text(
                  translations.mandatoryUpdateProgressTitle,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      translations.mandatoryUpdateProgressBody,
                    ),
                    const SizedBox(height: 16),
                    const LinearProgressIndicator(),
                  ],
                ),
              ),
        ),
      );
      return true;
    }
  }

  Future<bool> _defaultOptionalUpdate(
    VersionCompatibiliy compatibility,
    bool backendLeading,
  ) async {
    if (backendLeading) {
      ScaffoldMessenger.of(context).showSnackBar(
        widget.config?.optionalUpdateSnackBarBuilderBackendleading
                ?.call(context) ??
            SnackBar(
              content: Text(
                translations.optionalUpdateBackendLeadingTitle,
              ),
            ),
      );

      return false;
    } else {
      return await showDialog<bool>(
            context: context,
            builder: (context) =>
                widget.config?.optionalUpdateDialogBuilderFrontendleading
                    ?.call(context) ??
                AlertDialog(
                  title: Text(
                    translations.optionalUpdateFrontendLeadingTitle,
                  ),
                  content: Text(
                    translations.optionalUpdateFrontendLeadingBody,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        translations.optionalUpdateBackendLeadingYes,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        translations.optionalUpdateBackendLeadingNo,
                      ),
                    ),
                  ],
                ),
          ) ??
          false;
    }
  }

  void _defaultOnUpdateEnd() {
    if (!(ModalRoute.of(context)?.isCurrent ?? true)) {
      Navigator.of(context).pop();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      widget.config?.updateEndSnackbarBuilder?.call(context) ??
          SnackBar(
            content: Text(
              translations.updateCompleteTitle,
            ),
          ),
    );
  }
}
