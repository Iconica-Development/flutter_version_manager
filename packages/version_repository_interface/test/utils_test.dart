import "package:flutter_test/flutter_test.dart";
import "package:version_repository_interface/src/utils/version_string.dart";

void main() {
  test("Check semantic version, true", () {
    var version = "1.0.0";

    var isSemanticVersion = version.isSemanticVersion();

    expect(isSemanticVersion, true);
  });

  test("Check semantic version, false", () {
    var version = "1.0.0+23";

    var isSemanticVersion = version.isSemanticVersion();

    expect(isSemanticVersion, false);
  });
}
