import "dart:async";

import "package:flutter_version_manager/src/config/builders.dart";
import "package:flutter_version_manager/src/config/translations.dart";

/// A class that holds the translations for the version manager.
/// And the custom builder widgets, for the dialogs and snackbars.
class VersionManagerConfig {
  /// Creates a [VersionManagerConfig].
  const VersionManagerConfig({
    this.translations = const VersionManagerTranslations.empty(),
    this.builders = const VersionManagerBuilders(),
    this.onUpdatePress,
  });

  /// The translations for the version manager.
  final VersionManagerTranslations translations;

  /// The builders for the version manager.
  final VersionManagerBuilders builders;

  /// The function to call when the user clicks the update button.
  /// The update can be mandatory or optional.
  /// This function should open the store page or reload the page.
  final UpdatePressCallback? onUpdatePress;
}

/// Typedef for the update press callback
typedef UpdatePressCallback = FutureOr<void>? Function({
  required bool mandatory,
  required String platform,
});
