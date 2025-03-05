/// Translations for the VersionManager
class VersionManagerTranslations {
  /// Creates a [VersionManagerTranslations].
  const VersionManagerTranslations({
    required this.mandatoryUpdateTitle,
    required this.mandatoryUpdateBodyAndroid,
    required this.mandatoryUpdateBodyIos,
    required this.mandatoryUpdateBodyWeb,
    required this.mandatoryUpdateButtonAndroid,
    required this.mandatoryUpdateButtonIos,
    required this.mandatoryUpdateButtonWeb,
    required this.mandatoryUpdateProgressTitle,
    required this.mandatoryUpdateProgressBody,
    required this.optionalUpdateBackendLeadingTitle,
    required this.optionalUpdateFrontendLeadingTitle,
    required this.optionalUpdateFrontendLeadingBody,
    required this.optionalUpdateBackendLeadingYes,
    required this.optionalUpdateBackendLeadingNo,
    required this.updateCompleteTitle,
  });

  /// Creates a [VersionManagerTranslations] with default values.
  const VersionManagerTranslations.empty({
    this.mandatoryUpdateTitle = "Update required",
    this.mandatoryUpdateBodyAndroid =
        "Please update the app in the Play Store and restart "
            "the app to get the newest version.",
    this.mandatoryUpdateBodyIos =
        "Please update the app in the App Store and restart "
            "the app to get the newest version.",
    this.mandatoryUpdateBodyWeb =
        "Please reload the page to get the newest version.",
    this.mandatoryUpdateButtonAndroid = "Go to the Play Store",
    this.mandatoryUpdateButtonIos = "Go to the App Store",
    this.mandatoryUpdateButtonWeb = "Reload this page",
    this.mandatoryUpdateProgressTitle = "Update in progress",
    this.mandatoryUpdateProgressBody = "Please wait while the app updates",
    this.optionalUpdateBackendLeadingTitle =
        "Update available, please update from the store",
    this.optionalUpdateFrontendLeadingTitle = "Update available",
    this.optionalUpdateFrontendLeadingBody = "Would you like to update?",
    this.optionalUpdateBackendLeadingYes = "Yes",
    this.optionalUpdateBackendLeadingNo = "No",
    this.updateCompleteTitle = "Update complete",
  });

  /// The title for the mandatory update dialog
  final String mandatoryUpdateTitle;

  /// The body for the mandatory update dialog on Android
  final String mandatoryUpdateBodyAndroid;

  /// The body for the mandatory update dialog on iOS
  final String mandatoryUpdateBodyIos;

  /// The body for the mandatory update dialog on Web
  final String mandatoryUpdateBodyWeb;

  /// The text for the update button in the mandatory update dialog on Android
  final String mandatoryUpdateButtonAndroid;

  /// The text for the update button in the mandatory update dialog on iOS
  final String mandatoryUpdateButtonIos;

  /// The text for the update button in the mandatory update dialog on Web
  final String mandatoryUpdateButtonWeb;

  /// The title for the mandatory update progress dialog
  final String mandatoryUpdateProgressTitle;

  /// The body for the mandatory update progress dialog
  final String mandatoryUpdateProgressBody;

  /// The title for the optional update dialog
  final String optionalUpdateBackendLeadingTitle;

  /// The title for the optional update dialog
  final String optionalUpdateFrontendLeadingTitle;

  /// The body for the optional update dialog
  final String optionalUpdateFrontendLeadingBody;

  /// The text for the yes button in the optional update dialog
  final String optionalUpdateBackendLeadingYes;

  /// The text for the no button in the optional update dialog
  final String optionalUpdateBackendLeadingNo;

  /// The title for the update complete dialog
  final String updateCompleteTitle;

  /// Creates a copy of this [VersionManagerTranslations]
  /// but with the given fields
  VersionManagerTranslations copyWith({
    String? mandatoryUpdateTitle,
    String? mandatoryUpdateBodyAndroid,
    String? mandatoryUpdateBodyIos,
    String? mandatoryUpdateBodyWeb,
    String? mandatoryUpdateButtonAndroid,
    String? mandatoryUpdateButtonIos,
    String? mandatoryUpdateButtonWeb,
    String? mandatoryUpdateProgressTitle,
    String? mandatoryUpdateProgressBody,
    String? optionalUpdateBackendLeadingTitle,
    String? optionalUpdateFrontendLeadingTitle,
    String? optionalUpdateFrontendLeadingBody,
    String? optionalUpdateBackendLeadingYes,
    String? optionalUpdateBackendLeadingNo,
    String? updateCompleteTitle,
  }) =>
      VersionManagerTranslations(
        mandatoryUpdateTitle: mandatoryUpdateTitle ?? this.mandatoryUpdateTitle,
        mandatoryUpdateBodyAndroid:
            mandatoryUpdateBodyAndroid ?? this.mandatoryUpdateBodyAndroid,
        mandatoryUpdateBodyIos:
            mandatoryUpdateBodyIos ?? this.mandatoryUpdateBodyIos,
        mandatoryUpdateBodyWeb:
            mandatoryUpdateBodyWeb ?? this.mandatoryUpdateBodyWeb,
        mandatoryUpdateButtonAndroid:
            mandatoryUpdateButtonAndroid ?? this.mandatoryUpdateButtonAndroid,
        mandatoryUpdateButtonIos:
            mandatoryUpdateButtonIos ?? this.mandatoryUpdateButtonIos,
        mandatoryUpdateButtonWeb:
            mandatoryUpdateButtonWeb ?? this.mandatoryUpdateButtonWeb,
        mandatoryUpdateProgressTitle:
            mandatoryUpdateProgressTitle ?? this.mandatoryUpdateProgressTitle,
        mandatoryUpdateProgressBody:
            mandatoryUpdateProgressBody ?? this.mandatoryUpdateProgressBody,
        optionalUpdateBackendLeadingTitle: optionalUpdateBackendLeadingTitle ??
            this.optionalUpdateBackendLeadingTitle,
        optionalUpdateFrontendLeadingTitle:
            optionalUpdateFrontendLeadingTitle ??
                this.optionalUpdateFrontendLeadingTitle,
        optionalUpdateFrontendLeadingBody: optionalUpdateFrontendLeadingBody ??
            this.optionalUpdateFrontendLeadingBody,
        optionalUpdateBackendLeadingYes: optionalUpdateBackendLeadingYes ??
            this.optionalUpdateBackendLeadingYes,
        optionalUpdateBackendLeadingNo: optionalUpdateBackendLeadingNo ??
            this.optionalUpdateBackendLeadingNo,
        updateCompleteTitle: updateCompleteTitle ?? this.updateCompleteTitle,
      );
}
