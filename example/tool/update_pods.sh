#!/bin/zsh
# Update the iOS dependencies stored in Podfile.lock
# Requires the homebrew version of Cocoapods
pushd ios || exit
/opt/homebrew/bin/pod update
popd || exit
