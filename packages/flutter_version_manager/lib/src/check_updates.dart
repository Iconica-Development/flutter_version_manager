// ignore_for_file: avoid_positional_boolean_parameters

import "package:flutter/material.dart";
import "package:version_repository_interface/version_repository_interface.dart";

/// Check for updates, and update if necessary.
/// [service] The service to use.
/// [onMandatoryUpdate] The function to call when
/// a mandatory update is required.
/// [onOptionalUpdate] The function to call when
/// an optional update is available.
/// [onUpdateEnd] The function to call when the update is complete.
/// [backendLeading] If the backend is leading. Defaults to `true`.
/// If `true`, the backend is leading.
/// If `false`, the frontend is leading.
/// Returns a [Future] that completes when the update is complete.
Future<void> checkForUpdates({
  required VersionRepositoryService service,
  Future<bool> Function(VersionCompatibiliy compatibility, bool backendLeading)?
      onMandatoryUpdate,
  Future<bool> Function(VersionCompatibiliy compatibility, bool backendLeading)?
      onOptionalUpdate,
  VoidCallback? onUpdateEnd,
  bool backendLeading = true,
}) async {
  var expectedBackendVersion = await service.getExpectedBackendVersion();
  var currentBackendVersion = await service.getCurrentBackendVersion();

  if (expectedBackendVersion == null) {
    debugPrint(
      "Could not get backend versions - \nExpected: $expectedBackendVersion "
      "\nCurrent: $currentBackendVersion",
    );
  }

  debugPrint(
    "EXPECTED: $expectedBackendVersion\nCURRENT: $currentBackendVersion",
  );

  var updateCheck = await service.checkForUpdates(
    expected: expectedBackendVersion!,
    current: currentBackendVersion,
    backendLeading: backendLeading,
  );

  var leading = updateCheck.leading;
  var updateMethod = updateCheck.update;
  var updateType = updateCheck.compatibility;

  if (updateType == VersionCompatibiliy.equivalent) {
    return;
  }

  if (leading == "backend") {
    debugPrint("CHECKING APP AVAILABILITY");

    var requiredAppVersion = await service.getRequiredAppVersion();
    var currentAppVersion = await service.getCurrentAppVersion();

    if (currentAppVersion != null) {
      debugPrint(
        "REQUIRED APP: $requiredAppVersion\nCURRENT APP: $currentAppVersion",
      );
      var result = requiredAppVersion.compare(currentAppVersion);

      if (!result.isUpgrade) {
        return;
      }
    }
  }

  if (updateType.isMandatory) {
    var shouldUpdate = await onMandatoryUpdate?.call(
          updateType,
          leading == "backend",
        ) ??
        true;

    if (!shouldUpdate) {
      return;
    }

    await updateMethod?.call(updateType, expectedBackendVersion);
  } else {
    var shouldUpdate = await onOptionalUpdate?.call(
          updateType,
          leading == "backend",
        ) ??
        true;

    if (!shouldUpdate) {
      return;
    }

    await updateMethod?.call(updateType, expectedBackendVersion);
  }

  onUpdateEnd?.call();
}
