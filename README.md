Project Overview
DSoft is a Flutter-based spa management application that provides comprehensive business management capabilities for spa and wellness centers.


Architecture & Framework
Frontend: Flutter (Dart)
Architecture Pattern: BLoC (Business Logic Component) pattern with custom base classes
Project Structure: Clean architecture with separation of concerns
Core Features
Business Management
Spa Management: Create, edit, and manage spa locations
Staff Management: Add, edit, and manage staff members
Customer Management: Customer profiles and reservation handling
Service Management: Service catalog with add/edit capabilities
Product Management: Product inventory and catalog
Booking System: Room and treatment booking functionality
Financial Management
Order Management: Order processing and tracking
Warehouse Management: Inventory tracking with import/export history
Debt Management: Customer debt tracking
Prepaid Cards: Prepaid card system management
Statistical Reports: Business analytics and reporting
Specialized Features
Room & Bed Management: Spa room layout and bed assignment
Combo Treatments: Package deal management
Subscription Management: Recurring service subscriptions
Custom Categories: Flexible categorization system
Technical Architecture
Base Framework
Custom base classes (base_controller.dart, base_view.dart, base_bloc.dart)
Centralized navigation system
API service layer with error handling
Multi-language support
UI Components
Reusable widget library (buttons, inputs, charts, etc.)
Custom theming system
Responsive design components
Loading and shimmer effects
Data Management
Repository pattern for data access
Request/Response model structure
Local storage and caching
Image handling and storage services
Authentication
Login/Register system
Password change functionality
Forgot password recovery