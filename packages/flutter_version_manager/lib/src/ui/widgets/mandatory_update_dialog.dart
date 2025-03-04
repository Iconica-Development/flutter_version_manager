import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_version_manager/src/utils/scope.dart";

///
class DefaultMandatoryUpdateDialogBackendLeading {
  ///
  const DefaultMandatoryUpdateDialogBackendLeading._();

  ///
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

  ///
  static Widget builder(BuildContext context) {
    var scope = VersionManagerScope.of(context);
    var config = scope.config;
    var translations = config.translations;
    return AlertDialog(
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
    );
  }
}

///
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
    );
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
