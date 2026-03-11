# Al Saif Gallery

A professional Flutter application for Al Saif Gallery - A Saudi retail organization.

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   └── home_screen.dart      # Home page
├── widgets/
│   ├── top_bar.dart          # Top navigation bar
│   ├── navigation_bar.dart   # Main navigation
│   ├── hero_section.dart     # Hero banner
│   ├── stats_section.dart    # Statistics cards
│   ├── what_we_do_section.dart
│   ├── services_section.dart
│   └── footer_section.dart
└── utils/
    ├── app_theme.dart        # App theme configuration
    └── app_colors.dart       # Color constants

assets/
├── images/                   # Place images here
│   ├── logo.png
│   └── hero_tea_set.png
└── icons/                    # Place icons here
```

## How to Export Images from Figma

1. **Open your Figma design**
2. **Select the image/layer you want to export**
3. **In the right panel, scroll to "Export" section**
4. **Click the "+" button to add export settings**
5. **Choose format (PNG for images, SVG for icons)**
6. **Click "Export [layer name]"**
7. **Save to `assets/images/` folder**

### Images needed:
- `logo.png` - The Al Saif Gallery logo (from navigation bar)
- `hero_tea_set.png` - The tea set image in hero section

## Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

## Features

- ✅ Clean architecture with separated components
- ✅ Reusable widgets
- ✅ Centralized theme and colors
- ✅ Professional folder structure
- ✅ Easy to maintain and scale
