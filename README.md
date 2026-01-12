# the_lions_eye

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## CI, Tests and Artifacts

- Run the unit tests locally via the included script:

```powershell
.\scripts\run_tests.ps1
```

- CI (GitHub Actions) runs `flutter analyze` and `flutter test`, and also builds artifacts for Android, iOS (unsigned), and macOS on push/PR. Artifacts are uploaded to the workflow run and can be downloaded from the Actions UI (look for `the_lions_eye_apk`, `the_lions_eye_ios_ipa`, or `the_lions_eye_macos`).

- To re-run tests or reset consent locally during development, the app includes a developer button on the login screen labelled `Reset Consent (dev)` which clears stored acceptance and signature values.
