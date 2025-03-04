import "package:flutter/material.dart";
import "package:flutter_version_manager/src/utils/scope.dart";
import "package:version_repository_interface/version_repository_interface.dart";

///
Future<bool> defaultOptionalUpdate(
  BuildContext context, {
  required VersionCompatibiliy compatibility,
  required bool backendLeading,
}) async {
  if (backendLeading) {
    var config = VersionManagerScope.of(context).config;
    var translations = config.translations;
    ScaffoldMessenger.of(context).showSnackBar(
      config.optionalUpdateSnackBarBuilderBackendleading?.call(context) ??
          SnackBar(
            content: Text(
              translations.optionalUpdateBackendLeadingTitle,
            ),
          ),
    );

    return false;
  } else {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) {
            var config = VersionManagerScope.of(context).config;
            var translations = config.translations;
            return config.optionalUpdateDialogBuilderFrontendleading
                    ?.call(ctx) ??
                AlertDialog(
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
          },
        ) ??
        false;
  }
}
