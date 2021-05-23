#!/usr/bin/env bash

set -e

dart format --fix --set-exit-if-changed lib
flutter pub publish
