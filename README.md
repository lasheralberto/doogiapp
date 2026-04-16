![Banner](.github/images/banner.png)

This is a comprehensive `README.md` designed for the **DoogiApp** repository. Given the file structure provided (Flutter framework, custom Fredoka fonts, and the package name `com.example.ebook`), this documentation assumes the project is a modern, cross-platform eBook reading application.

---

# README.md

# 📖 DoogiApp

[![Flutter Version](https://img.shields.io/badge/Flutter-%3E%3D3.0.0-blue.svg)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey.svg)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**DoogiApp** is a high-performance, cross-platform eBook application built with Flutter. It provides a seamless reading experience with a focus on clean typography, smooth transitions, and an intuitive user interface.

## 🌟 Features

-   **Premium Typography:** Integrated with the `Fredoka` font family for a friendly and highly readable interface.
-   **Cross-Platform:** Single codebase for both Android and iOS devices.
-   **Modern UI:** Follows Material Design principles with custom theme support.
-   **Local Storage:** Efficient book metadata management.
-   **Performance Optimized:** Compiled to native ARM code for high-frame-rate interactions.

---

## 🛠 Tech Stack

-   **Framework:** [Flutter](https://flutter.dev/)
-   **Language:** [Dart](https://dart.dev/)
-   **Design:** Material Design / Custom UI
-   **Typography:** Fredoka Font Family (Light, Regular, Medium, SemiBold, Bold)

---

## 📂 Project Structure

```text
doogiapp/
├── android/                # Android native configurations
├── ios/                    # iOS native configurations
├── fonts/                  # Custom typeface assets (Fredoka)
├── lib/                    # Core application logic (Dart)
├── analysis_options.yaml   # Linting rules for clean code
└── pubspec.yaml            # Project dependencies and assets
```

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Stable channel)
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/) (for iOS development)
- [VS Code](https://code.visualstudio.com/) (Recommended IDE)

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/doogiapp.git
    cd doogiapp
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the application:**
    ```bash
    # To run on a connected device or emulator
    flutter run
    ```

---

## 🎨 Customization

### Using the Custom Typography
The app uses the **Fredoka** font family. To apply it to a widget, you can use the standard `TextStyle`:

```dart
Text(
  'Welcome to DoogiApp',
  style: TextStyle(
    fontFamily: 'Fredoka',
    fontWeight: FontWeight.w600, // SemiBold
    fontSize: 24,
  ),
)
```

### Configuration in `pubspec.yaml`
The fonts are registered as follows:
```yaml
fonts:
  - family: Fredoka
    fonts:
      - asset: fonts/Fredoka-Light.ttf
        weight: 300
      - asset: fonts/Fredoka-Regular.ttf
        weight: 400
      - asset: fonts/Fredoka-Medium.ttf
        weight: 500
      - asset: fonts/Fredoka-SemiBold.ttf
        weight: 600
      - asset: fonts/Fredoka-Bold.ttf
        weight: 700
```

---

## 📱 Development & Debugging

-   **Analyze Code:** Run `flutter analyze` to check for linting issues based on the project's `analysis_options.yaml`.
-   **Build APK:** `flutter build apk --release`
-   **Build iOS:** `flutter build ios --release`
-   **VS Code Support:** This repo includes a `.vscode/launch.json` for easy debugging. Simply press `F5` in VS Code to start.

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## ✉️ Contact

Project Link: [https://github.com/yourusername/doogiapp](https://github.com/yourusername/doogiapp)