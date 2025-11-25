# CROPIC Mobile Application Blueprint

## Overview

CROPIC Mobile is a comprehensive Flutter application designed to connect farmers and government agricultural departments. It leverages technology to provide real-time crop monitoring, complaint submission, access to government schemes, and community support, thereby increasing efficiency and transparency in the agricultural sector.

## Style, Design, and Features (v1)

### Core Architecture
- **State Management:** Provider
- **Routing:** go_router
- **Theming:** Centralized `AppTheme` with light and dark modes based on Material 3.
- **Typography:** `google_fonts` (Oswald, Roboto, Open Sans) for a clean, modern look.
- **Structure:** Feature-based folder structure (e.g., `screens`, `providers`).

### Implemented Features
- **Login Screen:** A clean, modern UI for user authentication with distinct paths for "Farmer" and "Admin" roles.
- **Navigation:** Router setup for `/`, `/farmer_dashboard`, and `/admin_dashboard`.
- **Theming:** App-wide theme provider to toggle between light and dark modes.
- **Dashboards:** Basic placeholder dashboards for both farmer and admin users with logout functionality.
- **Farmer Dashboard:** A grid-based UI with feature cards for intuitive navigation.

## Current Plan: Implement "Submit Complaint" Feature

**Objective:** To build a fully functional complaint submission system for farmers.

**Steps:**
1.  **Create Complaint Screen UI:** Design and build a new screen (`lib/screens/complaint_screen.dart`) with a form for submitting complaints. The form will include fields for a title, description, and complaint category.
2.  **Add Navigation Route:** Integrate the new screen into the `go_router` configuration with the path `/complaint`.
3.  **Enable Dashboard Navigation:** Update the `onTap` action for the "Submit Complaint" card on the Farmer Dashboard to navigate to the new screen.
4.  **Implement Firebase Logic:** On form submission, the application will save the complaint data to a `complaints` collection in the Firestore database.
5.  **Provide User Feedback:** Display a confirmation dialog to the user upon successful submission and navigate back to the dashboard.
