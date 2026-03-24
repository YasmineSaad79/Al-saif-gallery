#!/bin/bash
set -e

# Install Flutter 3.22.3 (matches .fvmrc)
git clone https://github.com/flutter/flutter.git -b 3.22.3 --depth 1 /tmp/flutter
export PATH="$PATH:/tmp/flutter/bin"

flutter pub get
flutter build web --release \
  --dart-define=IR_PAGE_URL="${IR_PAGE_URL:-http://localhost:3001/ir}"
