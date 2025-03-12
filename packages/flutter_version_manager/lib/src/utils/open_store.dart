import "package:url_launcher/url_launcher.dart";

/// Open Apple App Store with the given appId.
Future<void> openAppStore(String appId) async {
  await launchUrl(
    Uri.parse("https://itunes.apple.com/nl/app/beep-for-help/$appId"),
    mode: LaunchMode.externalNonBrowserApplication,
  );
}

/// Open Google Play Store with the given appId.
Future<void> openPlayStore(String appId) async {
  await launchUrl(
    Uri.parse("market://details?id=$appId"),
    mode: LaunchMode.externalApplication,
  );
}
