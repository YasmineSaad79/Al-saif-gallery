#!/bin/bash
set -e

# Install Flutter 3.24.0 (compatible with google_fonts 4.x)
git clone https://github.com/flutter/flutter.git -b 3.24.0 --depth 1 /tmp/flutter
export PATH="$PATH:/tmp/flutter/bin"

# Build
flutter pub get
flutter build web --release
