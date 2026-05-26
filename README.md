# Mini Store App

A Flutter e-commerce app built with Provider state management, fetching real product data from the [Fake Store API](https://fakestoreapi.com).

## Features

- Browse products in a responsive 2-column grid
- Search products by name in real time
- Filter products by category
- Sort products by price (ascending / descending)
- Add products to cart with a live badge counter
- Save products to favorites
- View full product details (image, description, price)
- Add to cart from the product detail screen

## Tech Stack

- **Flutter** 3.x / **Dart** 3.x
- **Provider** — state management
- **HTTP** — REST API calls to Fake Store API
- **Shared Preferences** — local data persistence

## Getting Started

### Prerequisites

- Flutter SDK installed — [Install Flutter](https://docs.flutter.dev/get-started/install)
- An emulator or physical device

### Run the app

```bash
git clone https://github.com/shaheer-dotcom/Mini_Store_App.git
cd Mini_Store_App
flutter pub get
flutter run

