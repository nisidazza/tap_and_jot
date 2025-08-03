## Tap & Jot

Tap & Jot is a simple and elegant mobile application designed to provide you with a daily dose of inspiration through random quotes. Whether you're starting your day, taking a break, or winding down, Tap & Jot delivers uplifting and motivational quotes with just a tap.

Now available on [Google Play Store](https://play.google.com/store/apps/details?id=com.nisiazza.tap_and_jot)

## ✨ Features

### 🕒 Personalized Greeting

Tap & Jot welcomes you with a personalized greeting based on the time of day. Whether it’s morning, afternoon, evening, or night, the app greets you accordingly to make each interaction feel personal and friendly.

### 💬 Inspirational Quotes

Discover a new inspirational quote each time you tap the screen. The quotes appear gradually, creating a moment of anticipation and reflection. If you need more inspiration, simply tap again to reveal another quote.

### 📸 Save and Share Screenshots

Capture a screenshot and easily save it into your Photo library or share it with your friends and family on social media or through messaging apps.

### 🧭 Simple and Intuitive Interface

Tap & Jot features a clean and minimalist design that is easy to navigate. The home screen provides clear instructions, and a tap or a single button takes you directly to the quotes.

### 🔁 Serendipitous Moments

Run into the same quote more than once? It could be a sign! Let these moments of serendipity guide and inspire you, adding a layer of meaning to your experience.

<table>
  <tr>
    <td><img src=https://github.com/nisidazza/tap_and_jot/assets/13388161/e23965c6-68d3-42d8-b394-9e91556c01cb width=150 height=300/></td>
    <td><img src=https://github.com/nisidazza/tap_and_jot/assets/13388161/20a5d462-2dbd-4039-8d05-eac71c3727e2 width=150 height=300/></td>
  </tr>
</table>

## 🛠️ Development

## Getting Started

This project is built with [Flutter](https://flutter.dev/). If you're new to Flutter development, you can get started with these resources:

- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)

## 📲 Updating Android Target SDK Version in Flutter

Google Play requires all apps to target a recent Android API level. Follow the steps below to update your Flutter app's target SDK to any desired version (e.g., API 35 for Android 15).

---

### ✅ 1. Install the Target Android SDK

- Open **Android Studio**
- Go to **Preferences > Appearance & Behavior > System Settings > Android SDK**
- In the **SDK Platforms** tab, check the desired API level (e.g., Android 15 - API 35)
- Click **Apply** to download and install


### 🛠️ 2. Update `local.properties`

Open the `android/local.properties` file and ensure these lines reflect your intended target:

flutter.compileSdkVersion=35
flutter.targetSdkVersion=35
flutter.minSdkVersion=21

### 📝 3. Update App Version in pubspec.yaml
Open your pubspec.yaml file and edit the version:

version: 1.1.0+15

- The version before the + is the version name (for users)
- The number after the + is the version code (must be incremented each release)

📌 Make sure this code is higher than your last Play Store release.

### 🔁 4. Clean and rebuild the project
From the root of your Flutter project, run the following in your terminal:

`flutter clean`
`flutter pub get`
`flutter build appbundle`

### 📤 5. Upload to Google Play

- Open the Google Play Console
- Navigate to your app
- Upload the .aab file
- Submit for review

---


