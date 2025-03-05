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
    this.onMandatoryUpdateClickAndroid,
    this.onMandatoryUpdateClickIos,
    this.onMandatoryUpdateClickWeb,
    this.onOptionalUpdateClickAndroid,
    this.onOptionalUpdateClickIos,
    this.onOptionalUpdateClickWeb,
  });

  /// The translations for the version manager.
  final VersionManagerTranslations translations;

  /// The builders for the version manager.
  final VersionManagerBuilders builders;

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
}
