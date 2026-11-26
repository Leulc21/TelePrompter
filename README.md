# Teleprompter 📺

> **Float your script. Read anywhere.** A neo-brutalist Flutter teleprompter that overlays your script on top of any app — camera, Zoom, Instagram, or whatever you're recording with.

---

## 📸 Preview

![Teleprompter Home](assets/images/screenshot.png)

---

## Overview

**Teleprompter** is a lightweight Flutter application that allows users to read scripts while recording videos using any app. Simply write or paste your script, customize the scrolling speed and font size, and tap **Show Overlay** to launch a floating teleprompter window.

The floating overlay stays on top of other applications, allowing you to read your script naturally while looking directly at the camera. Whether you're recording videos, creating social media content, attending online meetings, or delivering presentations, Teleprompter makes it easier to stay focused and confident.

Unlike traditional recording applications, Teleprompter does not record videos. Instead, it provides a convenient reading layer that works alongside your favorite recording applications.

The application also includes an optional **Mirror Mode** for users working with beam-splitter teleprompter glass setups, all wrapped in a custom **Neo-Brutalist UI** design.

---

## ✨ Features

- **🎬 Floating Overlay** — Display a draggable teleprompter window on top of any application.
- **📝 Script Editor** — Write or paste your scripts directly into the app.
- **💾 Automatic Saving** — Automatically saves scripts and settings locally.
- **🚀 Adjustable Scroll Speed** — Customize scrolling speed from 10 to 200 px/s.
- **🔠 Adjustable Font Size** — Change text size from 18 to 72 pt.
- **🪞 Mirror Mode** — Horizontally flip text for beam-splitter teleprompter setups.
- **⏯️ Playback Controls** — Start, pause, and restart scrolling directly from the floating overlay.
- **📍 Reading Guide** — A fixed pink reading line helps maintain a consistent reading position.
- **🎨 Neo-Brutalist Design** — A modern interface featuring bold borders, flat colors, and hard shadows.
- **📱 Cross-App Compatibility** — Read your scripts while using your camera, Instagram, Zoom, and other applications.
- **📴 Fully Offline** — Works without an internet connection, accounts, analytics, or network permissions.

---

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Programming Language**: Dart
- **Overlay Plugin**: flutter_overlay_window ^0.4.4
- **Local Storage**: shared_preferences ^2.2.0
- **Platform**: Android 5.0+ (API 21+)
- **UI Design**: Neo-Brutalist Design System
- **Architecture**: Flutter-based modular application

---

## 📁 Project Structure

```text
/
├── android/
│   └── app/
│       └── src/
│           └── main/
│               └── AndroidManifest.xml
│
├── lib/
│   ├── main.dart
│   ├── app/
│   ├── features/
│   ├── screens/
│   ├── widgets/
│   ├── services/
│   ├── theme/
│   └── ...
│
├── public/
│   └── images/
│       ├── homescreenshot.png
│       └── overlayscreenshot.png
│
├── assets/
├── test/
├── pubspec.yaml
├── analysis_options.yaml
├── .gitignore
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK installed
- Dart SDK (included with Flutter)
- Android Studio or VS Code
- Android device or emulator running Android 5.0+ (API 21+)

### Installation Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Leulc21/prompter.git
   ```

2. **Navigate to the project directory:**

   ```bash
   cd prompter
   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the application:**

   ```bash
   flutter run
   ```

5. **Build the Android APK:**

   ```bash
   flutter build apk --release
   ```

### Permissions

The application requires Android's **Display Over Other Apps** permission to show the floating teleprompter overlay.

Grant the permission when prompted or enable it manually through your device's Android settings.

---

## 📴 Privacy & Offline Support

Teleprompter is designed with privacy and simplicity in mind.

- No account registration required.
- No internet connection required.
- No analytics or tracking.
- Scripts and preferences are stored locally on the device.
- No video or audio recording is performed by the application.

Your scripts stay on your device.

---

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 📞 Contact

For questions, suggestions, or feedback, feel free to reach out:

- **Email**: leulchanie576@gmail.com
- **Instagram**: [@leulc21_type](https://www.instagram.com/leulch21?igsh=ejQ3OXRrMjE0NWxx)
- **LinkedIn**: [Leul Chanie](https://www.linkedin.com/in/leul-chanie-7b10ba260/)

---

Built with ❤️ by [Leul Chanie](https://github.com/Leulc21)
