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
/// [compareAppVersionOnly] If `true`, ignore backend checks and compare the
/// required and current app versions only.
/// Returns a [Future] that completes when the update is complete.
Future<void> checkForUpdates({
  required VersionRepositoryService service,
  Future<bool> Function(VersionCompatibiliy compatibility, bool backendLeading)?
      onMandatoryUpdate,
  Future<bool> Function(
    VersionCompatibiliy compatibility,
    bool backendLeading,
    Version? expectedAppVersion,
  )? onOptionalUpdate,
  VoidCallback? onUpdateEnd,
  bool backendLeading = true,
  bool compareAppVersionOnly = false,
}) async {
  if (compareAppVersionOnly) {
    var requiredAppVersion = await service.getRequiredAppVersion();
    var currentAppVersion = await service.getCurrentAppVersion();
    if (currentAppVersion == null) return;

    var updateType = requiredAppVersion.compare(currentAppVersion);
    if (updateType == VersionCompatibiliy.equivalent) return;

    if (updateType.isMandatory) {
      var shouldUpdate =
          await onMandatoryUpdate?.call(updateType, backendLeading) ?? true;
      if (!shouldUpdate) return;
    } else {
      var dismissed = await service.checkIfOptionalUpdateIsInteractedWith(
        requiredAppVersion,
        updateType,
      );
      if (dismissed) return;

      var shouldUpdate = await onOptionalUpdate?.call(
            updateType,
            backendLeading,
            requiredAppVersion,
          ) ??
          true;
      if (!shouldUpdate) return;
    }

    onUpdateEnd?.call();
    return;
  }

  var expectedBackend = await service.getExpectedBackendVersion();
  var currentBackend = await service.getCurrentBackendVersion();

  if (expectedBackend == null) return;

  var updateCheck = await service.checkForUpdates(
    expected: expectedBackend,
    current: currentBackend,
    backendLeading: backendLeading,
  );

  if (updateCheck.compatibility == VersionCompatibiliy.equivalent) {
    return; // No version difference
  }

  Version? requiredAppVersion;
  Version? currentAppVersion;

  if (updateCheck.leading == "backend") {
    requiredAppVersion = await service.getRequiredAppVersion();
    currentAppVersion = await service.getCurrentAppVersion();

    if (currentAppVersion != null) {
      var appDiff = requiredAppVersion.compare(currentAppVersion);

      if (!appDiff.isUpgrade) {
        return;
      }
    }
  }

  if (updateCheck.compatibility.isMandatory) {
    var shouldUpdate = await onMandatoryUpdate?.call(
          updateCheck.compatibility,
          updateCheck.leading == "backend",
        ) ??
        true;
    if (!shouldUpdate) return;

    await updateCheck.update?.call(
      updateCheck.compatibility,
      expectedBackend,
    );
  } else {
    currentAppVersion ??= await service.getCurrentAppVersion();
    var dismissed = await service.checkIfOptionalUpdateIsInteractedWith(
      requiredAppVersion,
      updateCheck.compatibility,
    );
    if (dismissed) return;

    var shouldUpdate = await onOptionalUpdate?.call(
          updateCheck.compatibility,
          updateCheck.leading == "backend",
          requiredAppVersion,
        ) ??
        true;
    if (!shouldUpdate) return;

    await updateCheck.update?.call(
      updateCheck.compatibility,
      expectedBackend,
    );
  }

  onUpdateEnd?.call();
}
