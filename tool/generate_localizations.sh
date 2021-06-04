#!/usr/bin/env bash
flutter gen-l10n
sed -i -e 's/_lookup/lookup/g' lib/l10n/src/fdash_localizations.g.dart
rm lib/l10n/src/fdash_localizations.g.dart-e
