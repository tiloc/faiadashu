#!/bin/bash
# Requires dcdg
# Requires nomnoml-cli
# Requires 'open' command (tested on macOS Big Sur)
#mkdir -p build/doc/nomnoml
mkdir -p build/doc/plantuml
mkdir -p doc/png

#dart run ../dcdg.dart/bin/dcdg.dart --builder=nomnoml --package=`pwd` --verbose --exclude-private=all --exclude="^fhir" --exclude="^flutter" > doc/nomnoml/classes-all.noml
#nomnoml -i doc/nomnoml/classes-all.noml -o doc/png/classes-all.png
#open doc/png/classes-all.png

dart run ../dcdg.dart/bin/dcdg.dart --package="$(dirname "$0")/.." --verbose --exclude-private=all --exclude="^fhir" --exclude="^flutter" > build/doc/plantuml/classes-all.puml
plantuml -i build/doc/plantuml/classes-all.puml -o ../../../doc/png/classes-all.png
open doc/png/classes-all.png
