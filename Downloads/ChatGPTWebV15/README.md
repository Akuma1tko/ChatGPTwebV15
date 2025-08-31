# ChatGPT iOS 15 Wrapper

This project is a lightweight WKWebView-based iOS app built for iOS 15 users to access ChatGPT. It bypasses the login error (400 route error) using a manual session cookie token and injects it via localStorage.

## 🔥 Features
- Login workaround using session token injection
- Modern, mobile-optimized ChatGPT wrapper
- Sidebar state fix (default: closed)
- Voice input fix (rebinds hold-to-speak icon)
- iOS 15+ support with custom user-agent override

## 🛠 Setup Instructions
1. Clone this repo:
    ```bash
    git clone https://github.com/Akuma1tko/chatgpt-ios15-wrapper.git
    ```

2. Open `ChatGPTWebV15.xcodeproj` in Xcode.

3. Paste your session token manually into the app at launch.

4. Relaunch the app. If the token is valid, you’ll skip the login screen.

## ⚠️ Warning
- This project does not use the OpenAI API. It mimics browser behavior only.
- Session tokens expire. You may need to refresh them every few days.

## 📦 Tech Stack
- Swift 5
- UIKit
- WKWebView
- LocalStorage injection

## ✅ Status
This is a working proof-of-concept for legacy devices. iOS 16 and newer are better served by the official ChatGPT app.

## 👤 Author
Created by **@Akuma1tko** – iOS tinker, wrapper architect, and jailbreak ecosystem explorer.

