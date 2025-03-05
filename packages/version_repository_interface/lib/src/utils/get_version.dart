import "package:flutter/services.dart";

/// Get the value from the pubspec.yaml file.
/// [key] The key to search for. Must match exactly at the start of a line.
/// If the key is not found, `null` is returned. There should be a space before
/// the value.
Future<String?> getKeyFromPubspecOrNull(String key) async {
  var content = await rootBundle.loadString("pubspec.yaml");
  var lines = content.split("\n");
  for (var line in lines) {
    if (line.trimLeft().startsWith(key)) {
      return line.split(" ").last;
    }
  }

  return null;
}
