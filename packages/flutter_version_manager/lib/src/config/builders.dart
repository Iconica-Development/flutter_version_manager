import "package:flutter/material.dart";
import "package:flutter_version_manager/src/ui/widgets/mandatory_update_dialog.dart";
import "package:flutter_version_manager/src/ui/widgets/optional_update_dialog.dart";

/// A class that holds the custom builder widgets
class VersionManagerBuilders {
  /// Creates a new instance of [VersionManagerBuilders].
  const VersionManagerBuilders({
    this.mandatoryUpdateDialogBuilderBackendleading =
        DefaultMandatoryUpdateDialogBackendLeading.builder,
    this.mandatoryUpdateDialogBuilderFrontendleading =
        DefaultMandatoryUpdateDialogFrontendLeading.builder,
    this.optionalUpdateSnackBarBuilderBackendleading =
        DefaultOptionalUpdateDialogFrontendLeading.builder,
    this.optionalUpdateDialogBuilderFrontendleading =
        DefaultOptionalUpdateDialogBackendLeading.builder,
    this.updateEndSnackbarBuilder,
  });

  /// The builder for the mandatory update dialog backend leading.
  final WidgetBuilder mandatoryUpdateDialogBuilderBackendleading;

  /// The builder for the mandatory update dialog frontend leading.
  final WidgetBuilder mandatoryUpdateDialogBuilderFrontendleading;

  /// The builder for the optional update snackbar backend leading.
  final SnackBar Function(BuildContext context)
      optionalUpdateSnackBarBuilderBackendleading;

  /// The builder for the optional update dialog frontend leading.
  /// Should return a [Widget] that is a dialog.
  /// The dialog should call `Navigator.of(context).pop(true/false)` when the user
  /// accepts or declines the update.
  /// If the user accepts, the update function will be called.
  /// If the user declines, the dialog will be dismissed.
  final WidgetBuilder optionalUpdateDialogBuilderFrontendleading;

  /// The builder for the update end snackbar.
  final SnackBar Function(BuildContext context)? updateEndSnackbarBuilder;
}
