import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_version_manager/src/config/version_manager_config.dart";
import "package:flutter_version_manager/src/utils/scope.dart";

/// Default optional update dialog for when the backend is leading and the
/// frontend could be updated but it is not required for the app to work.
class DefaultOptionalUpdateDialogBackendLeading {
  ///
  const DefaultOptionalUpdateDialogBackendLeading._();

  /// Pushes the optional update dialog to the screen and it can be dismissed
  static Future<bool> showOptionalUpdateDialog(BuildContext context) async {
    var scope = VersionManagerScope.of(context);
    var config = scope.config;

    return await showDialog(
          context: context,
          builder: (ctx) => config
              .builders.optionalUpdateDialogBuilderFrontendleading
              .call(context),
        ) ??
        false;
  }

  /// Builder for the optional update dialog frontend leading
  /// This dialog will show an option to update the app and it can be dismissed.
  static Widget builder(BuildContext context) {
    var scope = VersionManagerScope.of(context);

    return _OptionalUpdateDialog(
      config: scope.config,
    );
  }
}

/// The optional update dialog that updates state when clicking "Yes"
class _OptionalUpdateDialog extends StatefulWidget {
  const _OptionalUpdateDialog({required this.config});
  final VersionManagerConfig config;
  @override
  State<_OptionalUpdateDialog> createState() => _OptionalUpdateDialogState();
}

class _OptionalUpdateDialogState extends State<_OptionalUpdateDialog> {
  bool _showAppStoreButton = false;

  @override
  Widget build(BuildContext context) {
    var config = widget.config;
    var translations = config.translations;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    void onClickYes() {
      setState(() {
        _showAppStoreButton = true;
      });
    }

    void onClickNo() {
      Navigator.of(context).pop(false);
    }

    var buttonAction = config.onMandatoryUpdateClickAndroid;
    var buttonText = translations.mandatoryUpdateButtonAndroid;
    var updateInfoText = _showAppStoreButton
        ? translations.mandatoryUpdateBodyAndroid
        : translations.optionalUpdateQuestionAndroid;
    if (kIsWeb) {
      buttonAction = config.onMandatoryUpdateClickWeb;
      buttonText = translations.mandatoryUpdateButtonWeb;
      updateInfoText = _showAppStoreButton
          ? translations.mandatoryUpdateBodyWeb
          : translations.optionalUpdateQuestionWeb;
    } else if (Platform.isIOS || Platform.isMacOS) {
      buttonAction = config.onMandatoryUpdateClickIos;
      buttonText = translations.mandatoryUpdateButtonIos;
      updateInfoText = _showAppStoreButton
          ? translations.mandatoryUpdateBodyIos
          : translations.optionalUpdateQuestionIos;
    }

    return AlertDialog(
      title: Text(
        translations.optionalUpdateFrontendLeadingTitle,
        style: textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      content: Text(
        updateInfoText,
        style: textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _showAppStoreButton
              ? [
                  config.builders.updateButtonBuilder(
                    context,
                    buttonAction,
                    Text(buttonText),
                  ),
                ]
              : [
                  config.builders.declineButtonBuilder(
                    context,
                    onClickNo,
                    Text(translations.optionalUpdateBackendLeadingNo),
                  ),
                  const SizedBox(width: 22),
                  config.builders.acceptButtonBuilder(
                    context,
                    onClickYes,
                    Text(translations.optionalUpdateBackendLeadingYes),
                  ),
                ],
        ),
      ],
    );
  }
}

/// Default optional update dialog for when the frontend is leading and the
/// backend could be updated but it is not required for the app to work.
class DefaultOptionalUpdateDialogFrontendLeading {
  ///
  const DefaultOptionalUpdateDialogFrontendLeading._();

  ///
  static Future<bool> showOptionalUpdateDialog(BuildContext context) async {
    var scope = VersionManagerScope.of(context);
    var config = scope.config;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        config.builders.optionalUpdateSnackBarBuilderBackendleading
            .call(context),
      );
    });

    return false;
  }

  ///
  static SnackBar builder(BuildContext context) {
    var scope = VersionManagerScope.of(context);
    var translations = scope.config.translations;

    return SnackBar(
      content: Text(
        translations.optionalUpdateBackendLeadingTitle,
      ),
    );
  }
}
