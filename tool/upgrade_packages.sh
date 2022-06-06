#!/usr/bin/env bash
# Upgrades and fetches packages for faiadashu and all related projects
flutter pub upgrade
flutter pub get

pushd faiadashu_online || exit
flutter pub upgrade
flutter pub get
popd || exit

pushd faiabench || exit
flutter pub upgrade
flutter pub get
popd || exit

pushd example || exit
flutter pub upgrade
flutter pub get
popd || exit
