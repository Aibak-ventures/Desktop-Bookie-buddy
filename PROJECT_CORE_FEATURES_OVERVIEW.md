# BookieBuddy Desktop - Core Features Overview

## 📋 PROJECT UNDERSTANDING

**BookieBuddy Desktop** is a comprehensive booking/rental management system that has been converted from a mobile application to a web/desktop application, with primary focus on Windows platform.

The application helps businesses manage:
- Product rentals (bookings with pickup/return dates)
- Direct sales transactions
- Inventory/stock management
- Client and staff management
- Payment processing and tracking

---

## 🎯 5 CORE FEATURES

### 1. New Booking / New Sales

**Screen:** `new_booking_screen.dart`  
**Location:** `lib/features/new_booking/view/`

**Features:**
- ✅ Create bookings (rental items with pickup/return dates)
- ✅ Create sales (direct purchases)
- ✅ Create custom work orders
- ✅ Product selection with stock validation
- ✅ Client assignment and search
- ✅ Staff assignment
- ✅ Payment details (advance, discount, security)
- ✅ Document uploads
- ✅ Cooling period configuration
- ✅ Service-based product filtering
- ✅ Dynamic field labels based on service type

**Key Components:**
- `ProductSelectedModel` - Selected products/variants
- `ClientCubit` - Client management
- `StaffSearchCubit` - Staff selection
- `SelectProductBloc` - Product search and filtering
- `ServiceBloc` - Service type management

---

### 2. Edit Booking / Edit Sales

**Screens:** 
- `edit_booking_screen.dart`
- `add_or_edit_sales_screen.dart`

**Location:** `lib/features/edit_booking/view/`

**Features:**
- ✅ Edit existing bookings/sales
- ✅ Same structure as new booking screen
- ✅ Uses `EditBookingFormStateController`
- ✅ Update products, dates, client details
- ✅ Modify payment information
- ✅ Update booking status
- ✅ Document management

**Key Components:**
- `EditBookingFormStateController` - State management for editing
- `BookingModel` - Booking data structure
- `SalesModel` - Sales data structure

---

### 3. Stock List / Inventory Management

**Screen:** `stock_management_screen.dart`  
**Location:** `lib/features/stock_management/`

**Features:**
- ✅ Full CRUD operations (Create, Read, Update, Delete)
- ✅ Filter by service type (Dress, Vehicle, Equipment, Gadgets, Material, Room, Costume, Jewellery)
- ✅ Search by name, category, price range
- ✅ Add/Edit products with variants (sizes, serial numbers, colors)
- ✅ Stock tracking (total stock, remaining stock, booked stock)
- ✅ Product details with monthly growth chart
- ✅ Bulk operations support
- ✅ Image upload and management

**Key Components:**
- `ProductModel` - Product data structure
- `ProductVariantModel` - Variant information
- `MainServiceType` enum - Service type classification
- `ProductRepository` - Data operations

**Service Types:**
- **Dress** - Multi-variant (Size, Color)
- **Vehicle** - Non-variant (Brand, Model)
- **Equipment** - Multi-variant (variants)
- **Gadgets** - Multi-variant (Serial Number)
- **Material** - Non-variant (Fabric Type)
- **Room** - Non-variant
- **Costume** - Multi-variant (Size, Color)
- **Jewellery** - Non-variant
- **Others** - Flexible

---

### 4. All Bookings Screen

**Screen:** `all_bookings_desktop_screen.dart`  
**Location:** `lib/features/all_bookings/view/`

**Features:**
- ✅ View all bookings/sales in a grid layout
- ✅ Filter by status (Upcoming, Ongoing, Past, Completed, Cancelled)
- ✅ Search by client name, booking ID, phone number
- ✅ Click to open booking details drawer (right side panel)
- ✅ Edit/Cancel/Delete bookings
- ✅ Status indicators with color coding
- ✅ Quick actions menu
- ✅ Pagination support

**Key Components:**
- `AllBookingsCubit` - Booking list management
- `BookingDetailsDrawer` - Right panel for details
- `BookingCardWidget` - Individual booking card

**Status Types:**
- **Upcoming** - Not yet started
- **Ongoing** - Currently active
- **Past** - Completed
- **Booked** - Confirmed
- **Cancelled** - Cancelled bookings

---

### 5. Dashboard (Home Screen)

**Screen:** `home_screen.dart`  
**Location:** `lib/features/home/view/`

**Features:**
- ✅ Overview cards displaying key metrics:
  - Upcoming bookings count
  - Completed bookings count
  - Expired bookings count
  - Revenue statistics
- ✅ Two-column layout:
  - **Left:** Upcoming bookings
  - **Right:** Ongoing bookings
- ✅ Quick booking cards with status indicators
- ✅ Carousel with booking statistics
- ✅ Quick action buttons
- ✅ Real-time data updates
- ✅ Date range filtering

**Key Components:**
- `DashboardCubit` - Dashboard data management
- `BookingSummaryWidget` - Metric cards
- `QuickBookingCard` - Individual booking preview

---

## 🔧 CURRENT STATUS

### ✅ Completed
- Mobile app built and functional
- UI conversion to web/desktop (Windows) completed
- Core architecture with Clean Architecture + BLoC pattern
- All 5 core features implemented with basic functionality
- Service type system with dynamic field labels
- Multi-variant product support
- Stock validation and management
- Payment tracking system

### ⚠️ In Progress
- Bug fixes and issue resolution in all 5 core features
- UI/UX refinements for desktop experience
- Performance optimizations
- Enhanced validation and error handling

### 📝 Focus Areas (4-5 Sessions)
1. **New Booking Screen** - Issue fixes (cooling period, search, filters, UI improvements)
2. **Edit Booking Screen** - Issue resolution
3. **Stock Management** - Bug fixes and enhancements
4. **All Bookings Screen** - Filter and search improvements
5. **Dashboard** - Data accuracy and UI polish

---

## 🏗️ Technical Architecture

### State Management
- **BLoC Pattern** - Business logic separation
- **Cubit** - Simple state management
- **ValueNotifier** - Local UI state

### Key Technologies
- **Flutter 3.24.5+** - Framework
- **Clean Architecture** - Code organization
- **GetIt** - Dependency injection
- **Freezed** - Immutable models
- **Dartz** - Functional programming

### API Integration
- RESTful API endpoints
- Token-based authentication
- User profile with shop settings
- Real-time stock updates

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── models/           # Data models (ProductModel, BookingModel, etc.)
│   ├── enums/            # Service types, status enums
│   └── repositories/     # Data access layer
├── features/
│   ├── new_booking/      # Feature 1: New Booking/Sales
│   ├── edit_booking/     # Feature 2: Edit Booking/Sales
│   ├── stock_management/ # Feature 3: Inventory Management
│   ├── all_bookings/     # Feature 4: All Bookings List
│   └── home/             # Feature 5: Dashboard
└── utils/                # Helper functions, extensions
```

---

## 🎨 Design System

### Colors
- **Primary:** `#6132E4` (Purple)
- **Success:** Green shades
- **Warning:** Orange/Yellow shades
- **Error:** Red shades
- **Background:** `#F8F9FA`

### Typography
- **Font Family:** Inter
- **Heading:** 20px, Bold (700)
- **Subheading:** 15px, Semi-bold (600)
- **Body:** 14px, Medium (500)

### Components
- Rounded corners (8-12px border radius)
- Subtle shadows for elevation
- Animated transitions (200ms duration)
- Color-coded status indicators

---

## 📊 Key Metrics Tracked

1. **Bookings:** Total, Upcoming, Ongoing, Completed, Cancelled
2. **Revenue:** Advances, Security deposits, Discounts
3. **Inventory:** Total stock, Available stock, Booked items
4. **Clients:** Total clients, New clients, Active clients
5. **Staff:** Staff assignments, Performance tracking

---

## 🔐 User Permissions

- **Admin:** Full access to all features
- **Staff:** Limited access based on role
- **Shop Settings:** Cooling period, payment methods, tax configuration

---

## 📞 Support & Documentation

- **Quick Start:** `QUICK_START.md`
- **Bug Tracking:** `BUG_FIXES_NEEDED.md`
- **Testing Checklist:** `TESTING_CHECKLIST.md`
- **Architecture Audit:** `ARCH_AUDIT.md`

---

**Last Updated:** February 14, 2026  
**Version:** Desktop Release Candidate  
**Platform:** Windows (Primary), Web (Secondary)
