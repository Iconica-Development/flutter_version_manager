import "package:flutter/material.dart";
import "package:flutter_version_manager/src/utils/scope.dart";

/// Backend Leading Optional Update Dialog
class DefaultOptionalUpdateDialogBackendLeading {
  ///
  const DefaultOptionalUpdateDialogBackendLeading._();

  ///
  static Future<bool> showOptionalUpdateDialog(BuildContext context) async {
    var scope = VersionManagerScope.of(context);
    var config = scope.config;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        config.optionalUpdateSnackBarBuilderBackendleading.call(context),
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

/// Frontend Leading Optional Update Dialog
class DefaultOptionalUpdateDialogFrontendLeading {
  ///
  const DefaultOptionalUpdateDialogFrontendLeading._();

  ///
  static Future<bool> showOptionalUpdateDialog(BuildContext context) async {
    var scope = VersionManagerScope.of(context);
    var config = scope.config;

    return await showDialog(
      context: context,
      builder: (ctx) =>
          config.optionalUpdateDialogBuilderFrontendleading.call(context),
    );
  }

  ///
  static Widget builder(BuildContext context) {
    var scope = VersionManagerScope.of(context);
    var translations = scope.config.translations;

    return AlertDialog(
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
    );
  }
}
