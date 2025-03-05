import "dart:async";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_version_manager/src/utils/scope.dart";

/// Default mandatory update dialog for when the backend is leading and the
/// frontend needs to be updated to work with the backend.
class DefaultMandatoryUpdateDialogBackendLeading {
  ///
  const DefaultMandatoryUpdateDialogBackendLeading._();

  /// Pushes the mandatory update dialog to the screen and it can't be dismissed
  static Future<bool> showMandatoryUpdateDialog(BuildContext context) async {
    var scope = VersionManagerScope.of(context);
    var config = scope.config;
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) =>
          config.mandatoryUpdateDialogBuilderBackendleading(context),
    );
  }

  /// Builder for the mandatory update dialog backend leading
  /// This dialog will show an option to update the app and it cannot be
  /// dismissed.
  static Widget builder(BuildContext context) {
    var scope = VersionManagerScope.of(context);
    var config = scope.config;
    var translations = config.translations;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    var bodyText = translations.mandatoryUpdateBodyAndroid;
    var buttonText = translations.mandatoryUpdateButtonAndroid;
    var buttonAction = config.onMandatoryUpdateClickAndroid;
    if (kIsWeb) {
      bodyText = translations.mandatoryUpdateBodyWeb;
      buttonText = translations.mandatoryUpdateButtonWeb;
      buttonAction = config.onMandatoryUpdateClickWeb;
    } else if (Platform.isIOS || Platform.isMacOS) {
      bodyText = translations.mandatoryUpdateBodyIos;
      buttonText = translations.mandatoryUpdateButtonIos;
      buttonAction = config.onMandatoryUpdateClickIos;
    }

    return AlertDialog(
      title: Text(
        translations.mandatoryUpdateTitle,
        style: textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      content: Text(
        bodyText,
        style: textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: buttonAction,
          child: Text(buttonText),
        ),
      ],
    );
  }
}

/// Default mandatory update dialog for when the frontend is leading and the
/// backend needs to be updated to work with the frontend.
class DefaultMandatoryUpdateDialogFrontendLeading {
  ///
  const DefaultMandatoryUpdateDialogFrontendLeading._();

  ///
  static Future<bool> showMandatoryUpdateDialog(BuildContext context) async {
    var scope = VersionManagerScope.of(context);
    var config = scope.config;
    return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) =>
              config.mandatoryUpdateDialogBuilderFrontendleading.call(context),
        ) ??
        false;
  }

  ///
  static Widget builder(BuildContext context) {
    var scope = VersionManagerScope.of(context);
    var config = scope.config;
    var translations = config.translations;

    return AlertDialog(
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
    );
  }
}
