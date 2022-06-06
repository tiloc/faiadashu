#!/bin/bash

# https://docs.flutter.dev/perf/rendering/shader#how-to-use-sksl-warmup
flutter build apk --bundle-sksl-path ../shaders/flutter_01.sksl.json

# shellcheck disable=SC2034
read  -r -n 1 -p "Press Enter to continue with installation to Android device:" waitcontinueinput

adb install build/app/outputs/flutter-apk/app-release.apk
