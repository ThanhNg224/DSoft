DSoft – Spa Management Application
📌 Overview

DSoft is a Flutter-based spa & wellness center management application designed to provide a comprehensive business management solution.
The system streamlines daily operations, from customer bookings to inventory management, ensuring spas can focus on delivering great services while running their business efficiently.

✨ Core Features
🔹 Business Management

Spa Management – Create, edit, and manage multiple spa branches/locations.

Staff Management – Add, edit, and assign staff to services or rooms.

Customer Management – Maintain detailed customer profiles, including booking history and preferences.

Service Management – Service catalog with add/edit options and flexible categorization.

Product Management – Manage inventory and product catalog for retail sales.

Booking System – Advanced room & treatment booking with scheduling support.

🔹 Financial Management

Order Management – Process and track orders in real time.

Warehouse Management – Inventory tracking with import/export history.

Debt Management – Track outstanding debts and settlements.

Prepaid Cards – Manage prepaid packages/cards for customers.

Statistical Reports – Detailed analytics for sales, bookings, and performance.

🔹 Specialized Features

Room & Bed Management – Visual layout of rooms and bed assignments.

Combo Treatments – Manage package deals and promotions.

Subscription Management – Recurring service subscriptions with automated handling.

Custom Categories – Flexible tagging and categorization system.

🛠 Technical Architecture
🔹 Framework & Architecture

Frontend: Flutter (Dart)

Architecture Pattern: BLoC (Business Logic Component) with custom base classes

Project Structure: Clean Architecture with separation of concerns

🔹 Base Framework

Custom base classes (base_controller.dart, base_view.dart, base_bloc.dart)

Centralized navigation system

API service layer with integrated error handling

Multi-language support

🔹 UI/UX Components

Reusable widget library (buttons, inputs, charts, etc.)

Custom theming system for branding consistency

Responsive design for different devices

Loading states & shimmer effects for smooth UX

🔹 Data & Storage

Repository Pattern for data access & API handling

Structured Request/Response models

Local storage & caching for performance optimization

Image handling & storage services

🔹 Authentication & Security

User authentication system (Login / Register)

Password management (Change / Forgot password flows)

Token-based API security integration

🚀 Tech Stack

Language: Dart

Framework: Flutter

Architecture: BLoC + Clean Architecture

Data Layer: Repository Pattern

State Management: Custom base BLoC classes

Storage: Local cache + API integration

📊 Highlights

Clean and scalable architecture for long-term maintainability

Strong separation of concerns (UI, business logic, data layer)

Highly reusable UI components and consistent theming

Full suite of spa management features (bookings → warehouse → reports)
