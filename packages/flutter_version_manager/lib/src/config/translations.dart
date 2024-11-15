/// Translations for the VersionManager
class VersionManagerTranslations {
  /// Creates a [VersionManagerTranslations].
  const VersionManagerTranslations({
    required this.mandatoryUpdateTitle,
    required this.mandatoryUpdateBody,
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
    this.mandatoryUpdateBody =
        "Please update the app from the store and restart",
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

  /// The body for the mandatory update dialog
  final String mandatoryUpdateBody;

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
    String? mandatoryUpdateBody,
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
        mandatoryUpdateBody: mandatoryUpdateBody ?? this.mandatoryUpdateBody,
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
