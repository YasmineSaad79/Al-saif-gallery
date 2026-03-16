#!/bin/bash
set -e

# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable --depth 1 /tmp/flutter
export PATH="$PATH:/tmp/flutter/bin"

# Build
flutter pub get
flutter build web --web-renderer html --release
