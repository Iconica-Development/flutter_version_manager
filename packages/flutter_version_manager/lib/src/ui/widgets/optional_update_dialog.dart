import "dart:async";
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_version_manager/src/config/version_manager_config.dart";
import "package:flutter_version_manager/src/utils/scope.dart";
import "package:version_repository_interface/version_repository_interface.dart";

/// Default optional update dialog for when the backend is leading and the
/// frontend could be updated but it is not required for the app to work.
class DefaultOptionalUpdateDialogBackendLeading {
  ///
  const DefaultOptionalUpdateDialogBackendLeading._();

  /// Pushes the optional update dialog to the screen and it can be dismissed
  static Future<bool> showOptionalUpdateDialog(
    BuildContext context,
    VersionCompatibiliy compatibility,
    Version? expectedAppVersion,
  ) async {
    var scope = VersionManagerScope.of(context);
    var config = scope.config;

    return await showDialog(
          context: context,
          builder: (ctx) => config
              .builders.optionalUpdateDialogBuilderFrontendleading
              .call(context, compatibility, expectedAppVersion),
        ) ??
        false;
  }

  /// Builder for the optional update dialog frontend leading
  /// This dialog will show an option to update the app and it can be dismissed.
  static Widget builder(
    BuildContext context,
    VersionCompatibiliy compatibility,
    Version? expectedAppVersion,
  ) {
    var scope = VersionManagerScope.of(context);

    return _OptionalUpdateDialog(
      config: scope.config,
      service: scope.service,
      expectedAppVersion: expectedAppVersion,
      compatibility: compatibility,
    );
  }
}

/// The optional update dialog that updates state when clicking "Yes"
class _OptionalUpdateDialog extends StatefulWidget {
  const _OptionalUpdateDialog({
    required this.config,
    required this.service,
    required this.expectedAppVersion,
    required this.compatibility,
  });

  final VersionManagerConfig config;
  final VersionRepositoryService service;
  final Version? expectedAppVersion;
  final VersionCompatibiliy compatibility;

  @override
  State<_OptionalUpdateDialog> createState() => _OptionalUpdateDialogState();
}

class _OptionalUpdateDialogState extends State<_OptionalUpdateDialog> {
  bool _showAppStoreButton = false;

  @override
  Widget build(BuildContext context) {
    var config = widget.config;
    var service = widget.service;
    var translations = config.translations;
    var dialogStyling = config.dialogStyling;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    Future<void> onClickYes() async {
      setState(() {
        _showAppStoreButton = true;
      });
      await service.interactWithOptionalUpdate(
        widget.expectedAppVersion,
        widget.compatibility,
      );
    }

    Future<void> onClickNo() async {
      Navigator.of(context).pop(false);
      await service.interactWithOptionalUpdate(
        widget.expectedAppVersion,
        widget.compatibility,
      );
    }

    var buttonText = translations.mandatoryUpdateButtonAndroid;
    var updateInfoText = _showAppStoreButton
        ? translations.mandatoryUpdateBodyAndroid
        : translations.optionalUpdateQuestionAndroid;
    var platform = "android";
    if (kIsWeb) {
      platform = "web";
      buttonText = translations.mandatoryUpdateButtonWeb;
      updateInfoText = _showAppStoreButton
          ? translations.mandatoryUpdateBodyWeb
          : translations.optionalUpdateQuestionWeb;
    } else if (Platform.isIOS || Platform.isMacOS) {
      platform = "ios";
      buttonText = translations.mandatoryUpdateButtonIos;
      updateInfoText = _showAppStoreButton
          ? translations.mandatoryUpdateBodyIos
          : translations.optionalUpdateQuestionIos;
    }

    FutureOr<void>? onButtonClick() async {
      await config.onUpdatePress?.call(mandatory: false, platform: platform);
    }

    return AlertDialog(
      titlePadding: dialogStyling.titlePadding,
      contentPadding: dialogStyling.contentPadding,
      actionsPadding: dialogStyling.actionsPadding,
      shape: dialogStyling.shape,
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
                    onButtonClick,
                    Text(buttonText),
                  ),
                ]
              : [
                  config.builders.declineButtonBuilder(
                    context,
                    onClickNo,
                    Text(translations.optionalUpdateBackendLeadingNo),
                  ),
                  SizedBox(width: dialogStyling.spaceBetweenButtons),
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
