#!/usr/bin/env bash
flutter gen-l10n
rm lib/l10n/src/fdash_localizations.g.dart-e
dart format --fix lib
