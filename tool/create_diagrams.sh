#!/bin/bash
# Requires dcdg
# Requires plantuml
# Requires 'open' command (tested on macOS Big Sur and Monterey)
mkdir -p build/doc/plantuml
mkdir -p doc/png

# This is huge ;-)
export PLANTUML_LIMIT_SIZE=100000
dart run ../dcdg.dart/bin/dcdg.dart --package="$(dirname "$0")/.." --exclude-private=all --exclude="^fhir" --exclude="^flutter" > build/doc/plantuml/classes-all.puml
plantuml -i build/doc/plantuml/classes-all.puml -o ../../../doc/png
open doc/png/classes-all.png
