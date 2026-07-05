# 📱 Flutter Product Catalog Manager

A clean and responsive Flutter application for managing products using a REST API.
Built with **Provider state management**, clean architecture, and Figma-based UI.

---

## 🚀 Features

* 📦 View all products
* ➕ Add new product
* ✏️ Edit existing product
* 🗑️ Delete product with confirmation
* 🔄 Pull-to-refresh support
* ⏳ Shimmer loading state

---

## 🧠 Architecture

The project follows a clean and scalable structure:

* **Model** → Product data structure
* **Service** → API calls (CRUD operations)
* **Provider** → State management using ChangeNotifier
* **Views** → UI screens and widgets
* **Core** → Theme and constants

---

## 🛠️ Tech Stack

* Flutter
* Dart
* Provider
* HTTP
* Shimmer
* flutter_dotenv

---

## 🌐 API Configuration

This app uses [crudcrud.com](https://crudcrud.com) for temporary REST APIs.

### Setup:

1. Visit https://crudcrud.com
2. Copy your unique API endpoint
3. Create a `.env` file in the root:

```env
BASE_URL=https://crudcrud.com/api/YOUR_API_ID
```

> ⚠️ Note: API expires after 24 hours

---

## ▶️ Running the App

```bash
flutter pub get
flutter run
```

---


## 📂 Folder Structure

```
product-catalog-manager/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   └── api_constants.dart
│   │   └── theme/
│   │       └── app_theme.dart
│   ├── models/
│   │   └── product.dart
│   ├── services/
│   │   └── product_service.dart
│   ├── providers/
│   │   └── product_provider.dart
│   ├── views/
│   │   ├── home/
│   │   │   ├── home_screen.dart
│   │   │   └── widgets/
│   │   │       ├── product_card.dart
│   │   │       ├── loading_state.dart
│   │   │       └── empty_state.dart
│   │   └── product_form/
│   │       └── product_form_screen.dart
│   └── main.dart
├── .env
├── pubspec.yaml
├── README.md
└── .gitignore
```
