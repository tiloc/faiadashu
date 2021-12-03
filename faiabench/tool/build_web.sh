#!/bin/bash

# Local production build for web.
flutter clean
flutter build web --no-tree-shake-icons --csp --source-maps
