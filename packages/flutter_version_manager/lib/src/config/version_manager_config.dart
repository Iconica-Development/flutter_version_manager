import "package:flutter/material.dart";
import "package:flutter_version_manager/src/config/translations.dart";
import "package:flutter_version_manager/src/ui/widgets/mandatory_update_dialog.dart";
import "package:flutter_version_manager/src/ui/widgets/optional_update_dialog.dart";

/// A class that holds the translations for the version manager.
/// And the custom builder widgets, for the dialogs and snackbars.
class VersionManagerConfig {
  /// Creates a [VersionManagerConfig].
  const VersionManagerConfig({
    this.translations = const VersionManagerTranslations.empty(),
    this.mandatoryUpdateDialogBuilderBackendleading =
        DefaultMandatoryUpdateDialogBackendLeading.builder,
    this.mandatoryUpdateDialogBuilderFrontendleading =
        DefaultMandatoryUpdateDialogFrontendLeading.builder,
    this.optionalUpdateSnackBarBuilderBackendleading =
        DefaultOptionalUpdateDialogFrontendLeading.builder,
    this.optionalUpdateDialogBuilderFrontendleading =
        DefaultOptionalUpdateDialogBackendLeading.builder,
    this.updateEndSnackbarBuilder,
    this.onMandatoryUpdateClickAndroid,
    this.onMandatoryUpdateClickIos,
    this.onMandatoryUpdateClickWeb,
    this.onOptionalUpdateClickAndroid,
    this.onOptionalUpdateClickIos,
    this.onOptionalUpdateClickWeb,
  });

  /// The translations for the version manager.
  final VersionManagerTranslations translations;

  /// The builder for the mandatory update dialog backend leading.
  final Widget Function(BuildContext context)
      mandatoryUpdateDialogBuilderBackendleading;

  /// The builder for the mandatory update dialog frontend leading.
  final Widget Function(BuildContext context)
      mandatoryUpdateDialogBuilderFrontendleading;

  /// The function to call when the user clicks the mandatory update for android
  /// This function should open the play store page for the app.
  final VoidCallback? onMandatoryUpdateClickAndroid;

  /// The function to call when the user clicks the mandatory update for ios
  /// This function should open the app store page for the app.
  final VoidCallback? onMandatoryUpdateClickIos;

  /// The function to call when the user clicks the mandatory update for web
  /// This function should reload the page.
  final VoidCallback? onMandatoryUpdateClickWeb;

  /// The function to call when the user clicks the optional update for android
  /// This function should open the play store page for the app.
  final VoidCallback? onOptionalUpdateClickAndroid;

  /// The function to call when the user clicks the optional update for ios
  /// This function should open the app store page for the app.
  final VoidCallback? onOptionalUpdateClickIos;

  /// The function to call when the user clicks the optional update for web
  /// This function should reload the page.
  final VoidCallback? onOptionalUpdateClickWeb;

  /// The builder for the optional update snackbar backend leading.
  final SnackBar Function(BuildContext context)
      optionalUpdateSnackBarBuilderBackendleading;

  /// The builder for the optional update dialog frontend leading.
  /// Should return a [Widget] that is a dialog.
  /// The dialog should call `Navigator.of(context).pop(true/false)` when the user
  /// accepts or declines the update.
  /// If the user accepts, the update function will be called.
  /// If the user declines, the dialog will be dismissed.
  final Widget Function(BuildContext context)
      optionalUpdateDialogBuilderFrontendleading;

  /// The builder for the update end snackbar.
  final SnackBar Function(BuildContext context)? updateEndSnackbarBuilder;
}
