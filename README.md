# ChatGPTWebV15

A standalone iOS 15 wrapper for ChatGPT, featuring a manual cookie-injection login fix and a modern multi-account floating button UI.

---

## 🚀 Features

- **Manual login** via `__Secure-next-auth.session-token`  
- **Multi-account support** (add, rename, delete)  
- **Floating draggable button** (44×44, white background, subtle shadow)  
- **Modern bottom-sheet account manager** (inset-grouped style)  
- **“No account”** option to log out and start fresh  
- **Idle fade**: button fades to 30% after 5 s of inactivity  
- **Full-screen WebView**, portrait & landscape support  

---

## 📦 Installation
  
**Sideload** via AltStore, TrollStore, Cydia Impactor, etc.  

---


## 🔑 First-Time Login

1. On your desktop Chrome, go to **https://chatgpt.com** (or `https://chat.openai.com`) and sign in.  
2. Click the **⋮** menu in the top-right → **More tools** → **Developer tools**  
   *(or press **Ctrl + Shift + I** on Windows/Linux, **⌘ + Option + I** on Mac)*  
3. In DevTools, switch to the **Application** tab → **Storage** → **Cookies** → **chatgpt.com**  
4. Find **`__Secure-next-auth.session-token`**, double-click its **Value**, press **⌘ +A** (Select All) then **⌘ +C** (Copy).  
5. On your iOS 15 device, open **ChatGPTWebV15**, tap the floating button → **Add new…**, paste the token → **Save**.  

Your session will load immediately in the WebView.  


---

## 🔄 Switching & Managing Accounts

- **Tap** the floating app-icon button to open the account sheet.  
- **No account** → wipes cookies and shows the logged-out page.  
- **Add new…** → name + paste a new token.  
- **Tap an existing account** → instantly reloads with that session.  
- **Swipe left** on any account in the sheet to **Rename** or **Delete**.  

Changes are saved in Keychain; your **last selected** account is loaded automatically on app launch.

---

## 🙏 Shout-Outs

Huge thanks to the community members who helped shape this:

- **WhatTheOnEarth**  
- **colorzpe**  
- **No_Count2837**  

Your feedback and testing made this for everyone on iOS 15. Enjoy!  
