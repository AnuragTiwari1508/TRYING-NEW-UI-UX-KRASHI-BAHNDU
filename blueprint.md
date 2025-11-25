# Blueprint: CROPIC Mobile App

## 1. Overview

**Purpose:** To build a unified, production-ready Flutter mobile application called "CROPIC Mobile". This app will serve the Pradhan Mantri Fasal Bima Yojana (PMFBY) by merging functionalities from existing systems like CROPIC and YESTECH.

**Goal:** The application will provide a seamless, end-to-end workflow for farmers and field officials to capture, validate, and analyze real-time, geotagged crop images. This will automate crop growth tracking, enable objective loss assessment, and streamline insurance claim processing, enhancing transparency and trust in the PMFBY scheme.

## 2. Core Features & User Roles

The application will be designed with two primary user roles:

### a. User/Public (Farmer)
- **Onboarding:** Simple, minimal registration (Phone, Name).
- **Capture Flow:** An intuitive, guided interface to capture high-quality, geotagged crop photos at various growth stages.
- **AI-Powered Analysis:** On-device pre-validation of images (blur, lighting) and backend analysis for crop health, damage, and stage.
- **Offline First:** Full functionality to capture and save data offline. All captured images and metadata will be cached locally and synced automatically when connectivity is restored.
- **Community & Support:** A feed for information exchange and an integrated chatbot for assistance.
- **Dashboard:** View the status of submitted images, analysis results, and relevant insurance policies.

### b. Admin/Department (Field Official)
- **Secure Login:** Authorized access with credentials.
- **Dashboard:** A real-time, map-based dashboard to monitor all submitted crop data.
- **Data-driven Insights:** Filter and visualize data by region, crop type, damage alerts, etc.
- **Claim Management:** Review image analysis, accept/reject claims, and flag cases for physical inspection.
- **Reporting:** Generate and export reports for internal use and record-keeping.

## 3. Design and UI/UX

- **Aesthetic:** Modern, clean, and visually balanced, inspired by the official PMFBY portal. The UI will be intuitive and accessible to a diverse user base.
- **Color Palette:** A professional palette of blues, greens, and oranges will be used to evoke trust, growth, and action.
- **Typography:** Expressive and readable fonts using `google_fonts`. A clear hierarchy (Headlines, Body, etc.) will be established for easy comprehension.
- **Iconography:** Modern and meaningful icons to guide users and enhance navigation.
- **Interactivity:** Polished, interactive components with subtle effects like shadows and glows to create a premium feel.
- **Accessibility:** High-contrast design, large tap targets, and multi-language support (English & Hindi) to ensure the app is usable by everyone.

## 4. Technical Architecture

- **Platform:** Flutter (Dart) with null-safety.
- **State Management:** `provider` for robust and scalable state management and dependency injection.
- **Navigation:** `go_router` for a declarative, URL-based routing strategy that supports deep linking.
- **Local Storage:** `hive` for efficient offline caching of all data.
- **Networking:** `dio` for reliable network requests with retry logic.
- **Theming:** Centralized theme management with support for both Light and Dark modes.
- **Code Generation:** `build_runner` will be used for generating necessary code for models and routing.

## 5. Current Plan: Foundation Setup

The immediate next steps are to establish the foundational structure of the application.

1.  **Add Dependencies:** Integrate `provider`, `google_fonts`, and `go_router` into the `pubspec.yaml` file.
2.  **Establish Theme:** Create a comprehensive theme file (`lib/theme.dart`) that defines the color scheme, typography, and component styles for both light and dark modes, using `ColorScheme.fromSeed` for a modern Material 3 look.
3.  **Implement Theme Provider:** Create a `ThemeProvider` class to manage and toggle between light, dark, and system themes.
4.  **Structure `main.dart`:** Update the main entry point to initialize the `ThemeProvider` and configure the `MaterialApp` with the newly defined themes.
5.  **Set Up Routing:** Initialize `go_router` with basic routes for a splash/loading screen, a login screen, and the main dashboard shells for both farmer and admin roles.
6.  **Create Placeholder Screens:** Develop the basic file structure for the initial screens (`login`, `farmer_dashboard`, `admin_dashboard`) to serve as placeholders for future feature development.
