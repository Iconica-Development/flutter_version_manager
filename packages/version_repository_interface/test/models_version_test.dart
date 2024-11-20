import "package:flutter_test/flutter_test.dart";
import "package:version_repository_interface/src/models/compatibiliy.dart";
import "package:version_repository_interface/src/models/version.dart";

void main() {
  test("Check parsing version, true", () {
    var versionString = "1.0.0";

    var version = Version.parse(version: versionString);

    expect(version.major, "1");
    expect(version.minor, "0");
    expect(version.patch, "0");
  });

  test("Check parsing version, false", () {
    var versionString = "1.0.0+23";

    expect(() => Version.parse(version: versionString), throwsException);
  });

  test("Check comparing version, major downgrade", () {
    var versionStringOne = "1.0.0";
    var versionStringTwo = "2.0.0";

    var versionOne = Version.parse(version: versionStringOne);
    var versionTwo = Version.parse(version: versionStringTwo);

    var compatibility = versionOne.compare(versionTwo);

    expect(compatibility, VersionCompatibiliy.majorDowngrade);
  });

  test("Check comparing version, major upgrade", () {
    var versionStringOne = "2.0.0";
    var versionStringTwo = "1.0.0";

    var versionOne = Version.parse(version: versionStringOne);
    var versionTwo = Version.parse(version: versionStringTwo);

    var compatibility = versionOne.compare(versionTwo);

    expect(compatibility, VersionCompatibiliy.majorUpgrade);
  });

  test("Check comparing version, minor upgrade", () {
    var versionStringOne = "0.2.0";
    var versionStringTwo = "0.1.0";

    var versionOne = Version.parse(version: versionStringOne);
    var versionTwo = Version.parse(version: versionStringTwo);

    var compatibility = versionOne.compare(versionTwo);

    expect(compatibility, VersionCompatibiliy.minorUpgrade);
  });

  test("Check comparing version, minor downgrade", () {
    var versionStringOne = "0.1.0";
    var versionStringTwo = "0.2.0";

    var versionOne = Version.parse(version: versionStringOne);
    var versionTwo = Version.parse(version: versionStringTwo);

    var compatibility = versionOne.compare(versionTwo);

    expect(compatibility, VersionCompatibiliy.minorDowngrade);
  });

  test("Check comparing version, patch upgrade", () {
    var versionStringOne = "0.0.2";
    var versionStringTwo = "0.0.1";

    var versionOne = Version.parse(version: versionStringOne);
    var versionTwo = Version.parse(version: versionStringTwo);

    var compatibility = versionOne.compare(versionTwo);

    expect(compatibility, VersionCompatibiliy.patchUpgrade);
  });

  test("Check comparing version, patch downgrade", () {
    var versionStringOne = "0.0.1";
    var versionStringTwo = "0.0.2";

    var versionOne = Version.parse(version: versionStringOne);
    var versionTwo = Version.parse(version: versionStringTwo);

    var compatibility = versionOne.compare(versionTwo);

    expect(compatibility, VersionCompatibiliy.patchDowngrade);
  });

  test("Check comparing version, equivalent", () {
    var versionStringOne = "1.0.0";
    var versionStringTwo = "1.0.0";

    var versionOne = Version.parse(version: versionStringOne);
    var versionTwo = Version.parse(version: versionStringTwo);

    var compatibility = versionOne.compare(versionTwo);

    expect(compatibility, VersionCompatibiliy.equivalent);
  });
}
