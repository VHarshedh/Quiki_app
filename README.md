# Quiki 🍔🍰

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Provider](https://img.shields.io/badge/Provider-State_Management-blue?style=for-the-badge)

**Quiki** is a comprehensive, production-ready Food & Dessert Delivery application built using Flutter. It aims to provide a seamless ordering experience from browsing delicious items to secure checkout and order management.

---

## 📱 Screenshots

> *Note to recruiter: Add screenshots of your app here to showcase the UI/UX.*
>
> | Home Screen | Product Details | Cart & Checkout | Profile |
> | :---: | :---: | :---: | :---: |
> | <img src="assets/screenshots/home.png" width="200"/> | <img src="assets/screenshots/details.png" width="200"/> | <img src="assets/screenshots/cart.png" width="200"/> | <img src="assets/screenshots/profile.png" width="200"/> |

---

## ✨ Key Features

- **Authentication:** Secure user onboarding, sign-up, and login flows using Firebase Authentication.
- **Product Catalog:** Browse a rich variety of foods and desserts with detailed descriptions and pricing.
- **Cart & Checkout:** Add items to cart, adjust quantities, and proceed through a smooth checkout process.
- **Order Management:** View order history and track the status of current orders.
- **Address Book:** Manage multiple delivery addresses for quick selection during checkout.
- **Digital Wallet:** Built-in wallet functionality for quick and seamless payments.
- **Search:** Powerful search capabilities to quickly find desired meals and items.
- **User Profile:** Manage personal information, settings, and preferences.

## 🛠 Tech Stack & Architecture

Quiki follows clean coding practices and is structured using a **Feature-First Domain-Driven Design (DDD)** architecture. This ensures that the codebase is scalable, maintainable, and highly testable.

### Technologies Used
- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Provider
- **Backend as a Service (BaaS):** Firebase (Auth, Cloud Firestore)
- **Code Generation:** Freezed, Json Serializable

### Architectural Layers
Each feature module (`lib/features/`) is separated into clear layers:
- `domain`: Contains core business logic, entities, and repository interfaces.
- `infrastructure`: Handles data retrieval from remote sources (Firebase) and implements the repository interfaces.
- `presentation`: Contains the UI components (Widgets, Screens) and state managers (Providers).

## 📂 Folder Structure

```text
lib/
├── auth/                   # Authentication logic & screens
├── core/                   # Core shared logic, network facades, error handling
├── features/               # Feature modules
│   ├── address/            # Address management
│   ├── cart/               # Shopping cart
│   ├── home/               # Products and main feed
│   ├── orders/             # Order history & tracking
│   ├── profile/            # User profile management
│   ├── search/             # Product search functionality
│   └── wallet/             # Digital wallet
├── screens/                # UI Screens (coordinated with features)
├── utils/                  # App theme, routes, constants, helpers
├── widgets/                # Reusable global UI widgets (e.g., PrimaryButton)
└── main.dart               # Application entry point & provider setup
```

## 🚀 Getting Started

### Prerequisites
- Install [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version 3.11.0 or higher)
- Set up an IDE (VS Code, Android Studio, or IntelliJ)
- Set up a Firebase project and configure it for Flutter.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/quiki.git
   cd quiki
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run Code Generation (Freezed & JSON Serializable):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Connect to Firebase:**
   Ensure you have configured `firebase_options.dart` and provided the necessary `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files in their respective directories.

5. **Run the App:**
   ```bash
   flutter run
   ```

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/yourusername/quiki/issues).

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
