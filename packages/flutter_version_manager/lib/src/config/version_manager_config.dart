import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_version_manager/src/config/builders.dart";
import "package:flutter_version_manager/src/config/translations.dart";

/// A class that holds the translations for the version manager.
/// And the custom builder widgets, for the dialogs and snackbars.
class VersionManagerConfig {
  /// Creates a [VersionManagerConfig].
  const VersionManagerConfig({
    this.translations = const VersionManagerTranslations.empty(),
    this.builders = const VersionManagerBuilders(),
    this.dialogStyling = const VersionManagerDialogStyling(),
    this.compareAppVersionOnly = false,
    this.backendLeading = true,
    this.onUpdatePress,
  });

  /// The translations for the version manager.
  final VersionManagerTranslations translations;

  /// The builders for the version manager.
  final VersionManagerBuilders builders;

  /// The styling configuration for the update dialogs.
  final VersionManagerDialogStyling dialogStyling;

  /// The function to call when the user clicks the update button.
  /// The update can be mandatory or optional.
  /// This function should open the store page or reload the page.
  final UpdatePressCallback? onUpdatePress;

  /// Whether to only compare the app version and ignore the current and
  /// expected backend versions.
  /// Defaults to `false`.
  final bool compareAppVersionOnly;

  /// If the backend is leading. Defaults to `true`.
  /// If `true`, the backend is leading.
  /// If `false`, the frontend is leading.
  final bool backendLeading;
}

/// Typedef for the update press callback
typedef UpdatePressCallback = FutureOr<void>? Function({
  required bool mandatory,
  required String platform,
});

/// The styling for the version manager dialog.
/// If not set the default values of an AlertDialog will be used.
class VersionManagerDialogStyling {
  /// Creates a [VersionManagerDialogStyling].
  const VersionManagerDialogStyling({
    this.titlePadding,
    this.contentPadding,
    this.actionsPadding,
    this.shape,
    this.spaceBetweenButtons = 22.0,
  });

  /// Padding around the title in the dialog.
  final EdgeInsetsGeometry? titlePadding;

  /// Padding around the content in the dialog.
  final EdgeInsetsGeometry? contentPadding;

  /// Padding around the buttons in the dialog.
  final EdgeInsetsGeometry? actionsPadding;

  /// The shape of the dialog.
  /// This can be used to change the border radius of the dialog.
  final ShapeBorder? shape;

  /// The padding between the buttons in the dialog. For confirming an optional
  /// update.
  final double spaceBetweenButtons;
}
