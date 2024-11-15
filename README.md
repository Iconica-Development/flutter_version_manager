# Flutter version manager

Flutter version manager is a package you can use to easily make sure the user is using the correct version of your Flutter app in combination with the right backend.

## Setup

To use this package, add flutter_version_manager as a dependency in your pubspec.yaml file

Make sure to add the pubspec.yaml file to your assets list:
```
  assets:
    - pubspec.yaml
```

## How to use

Either wrap `FlutterVersionManager` in your widget tree where you want to check the version (Splashscreen for example), or call `checkForUpdates` immediately without having predefined default UI for handling a potential update.

The `VersionRepositoryService` can also be used directly to do calls like so, `service.getCurrentBackendVersion()`.

Available methods in the service:
- `getCurrentBackendVersion();`
- `updateBackendVersion(VersionCompatibiliy compatibility, Version version);`
- `getRequiredAppVersion();`

Make sure to correctly set if either `frontend` or `backend` is leading.

In case of `MAJOR` differences:
  - if `frontend` is leading, the application will try to update or downgrade the backend if the versions mismatch.
  - if `backend` is leading, the application will show a blocking window signalling the user to update the app.

In case of `MINOR` or `PATCH` differences:
  - if `frontend` is leading, the application will show a dialog letting the user decide if an backend upgrade or downgrade should be done or not.
  - if `backend` is leading, the application will snackbar letting the user know they should update their app.


NOTE: The update app hint (also blocking), `MAJOR`, `MINOR` & `PATCH`. Only shows if there is a newer application available. With get `getRequiredAppVersion`. If the current version is equal to the required version no notification will be shown.

### Semantic versioning
Possbily options for checking version compatibilites:
- Major upgrade
- Major downgrade
- Minor upgrade
- Minor downgrade
- Patch upgrade
- Patch downgrade
- Equivalent

Determining which of these compatibilties is relevant is done using the rules of semantic vesioning. Being x.y.z, where x is the major verions, y minor and z patch.

- 1.0.0 -> 1.1.0 would be a minor upgrade
- 2.0.0 -> 1.0.0 would be a major downgrade
- 2.2.1 -> 2.2.4 would be a patch upgrade

### Firebase

Make sure to set `backendLeading` to `true`

Use `FirebaseVersionRepository` and set the settings accordingly
 - `firestore`, is de firestore instance. Defaults to `FirebaseFirestore.instance`
 - `versionDoc` is the nullable document reference of the version document. Don't use this to get the version document
 - `backendVersionKey`, the key that represents the "backend" version. Defaults to `version`
 - `minimumAppVersionKey`, the key that represents the minimum app version. Defaults to `minimumAppVersion`
 `versionDocment` getter for retrieving the version document, get copied from `versionDoc`, if not provided defaults to `firestore.collection("version").doc("version")`

When trying to enfore app versions here, a "backend" conflict is necessary. So use `backendVersionKey` accordingly and act like Firebase is a custom backend with changing versions as well.

NOTE: Obviously updating the backend doesn't work here.

### Custom backend

Make your own implementation of `VersionRepositoryInterface`.
Here you are in full freedom of either having the `backend` leading or the `frontend`.

Make sure that when `frontend` is leading, you have implemented `updateBackendVersion` correctly for both frontend and backend.

For a small example on how to create such a backend look at [this](./backend/) code.

In general you want to have two instances running, one being the actual server with domain logic and the other being a server that manages the other one.

That management server can have control over the actual server itself, like start, stopping and proxying. But also update said server. 

The provided example is written in NodeJS. And offers these two servers. The main server to start is the management server, after starting this one up it automatically spawn another instance being the actual server.
When calling the `update` endpoint, a zipfile should be provided. It unzips the file. Places them in some temporary directories and moves the unzipped `server.js` into the `backend` folder. Afterwards it removes the temporary files and folders and the updated has succeeded.

payload.zip is a shipped version of a new "backend" which you can use to test this functionality. It only updates the version from `0.0.0` to `1.0.0`

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_version_manager/pulls) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_version_manager/pulls).

## Author

This `flutter_version_manager` for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>