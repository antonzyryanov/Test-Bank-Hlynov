#!/bin/sh

echo "SwiftFormat"

if [[ -z "${CI}" ]]; then
    "${SRCROOT}/bin/swiftformat" --swiftversion 5.3 --config "${SRCROOT}/.swiftformat" "${SRCROOT}"
fi
