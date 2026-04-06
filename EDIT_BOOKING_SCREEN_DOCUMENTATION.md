# Edit Booking/Sale Screen Documentation

## Overview
The **Edit New Booking Screen** (`edit_new_booking_screen.dart`) provides a comprehensive editing interface for bookings and sales with the exact same structure and layout as the new booking screen.

## Location
```
lib/features/edit_booking/view/
├── edit_new_booking_screen.dart
└── widgets/
    └── edit_booking_app_bar.dart
```

## Features

### ✅ Same Structure as New Booking Screen
- **Identical Layout**: The editing screen mirrors the new booking screen's layout exactly
- **Consistent UI/UX**: Users experience the same interface for both creating and editing
- **Reusable Widgets**: Uses the same widgets from the new booking screen (BookingCalendarWidget, ProductCustomizationWidget, etc.)

### 🎯 Key Components

#### 1. Edit Booking App Bar
- **Title**: Shows "Edit Booking" or "Edit Sale" with booking/sale ID
- **Back Button**: Handles unsaved changes with confirmation dialog
- **Save Button**: Saves changes and returns to previous screen
- **Cancel Button**: Alternative way to discard and go back

#### 2. Date Selection Section
- Uses `BookingCalendarWidget` from new booking screen
- Supports pickup date, return date, and cooling period
- Time selection for all dates
- Sales mode (single date) vs Booking mode (date range)

#### 3. Product Selection Section
- **Product List**: Displays currently selected products
- **Add Products**: Button to add more products
- **Product Cards**: Shows product details with image, name, variant, and price
- **Remove Option**: Can remove products from selection
- **Customization**: Access to product customization screen

#### 4. Right Side Panel
Contains all additional details:
- **Client Details**: Name, phone, address (with search functionality)
- **Staff Details**: Staff assignment with search
- **Payment Details**: Advance, discount, security amounts
- **Documents**: Upload and manage documents
- **Description**: Additional notes

### 📋 Usage

#### Initialize for Booking Edit
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => EditNewBookingScreen(
      bookingDetails: bookingDetailsModel,
    ),
  ),
);
```

#### Initialize for Sale Edit
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => EditNewBookingScreen(
      saleDetails: saleDetailsModel,
    ),
  ),
);
```

### 🔄 Data Flow

1. **Initialization**:
   - Receives either `BookingDetailsModel` or `SaleDetailsModel`
   - Populates all fields from the model
   - Saves initial state for change detection

2. **Editing**:
   - User modifies any field
   - Change detection tracks modifications
   - Unsaved changes trigger confirmation on exit

3. **Saving**:
   - Validates form data
   - Creates update request
   - Calls appropriate repository method
   - Returns to previous screen with success/error message

### 🎨 UI Structure

```
┌─────────────────────────────────────────────────────┐
│  Edit Booking App Bar                               │
│  [Back] Edit Booking #123        [Cancel] [Save]   │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌─────────────────────┐  ┌───────────────────┐   │
│  │                     │  │                   │   │
│  │  Date Selection     │  │  Client Details   │   │
│  │  - Calendar         │  │  - Name           │   │
│  │  - Pickup Date/Time │  │  - Phone          │   │
│  │  - Return Date/Time │  │  - Address        │   │
│  │                     │  │                   │   │
│  ├─────────────────────┤  ├───────────────────┤   │
│  │                     │  │  Staff Details    │   │
│  │  Product Selection  │  │  - Staff Name     │   │
│  │  - Product List     │  │                   │   │
│  │  - [Add Products]   │  ├───────────────────┤   │
│  │  - Customization    │  │  Payment Details  │   │
│  │                     │  │  - Advance        │   │
│  │                     │  │  - Discount       │   │
│  │                     │  │  - Security       │   │
│  │                     │  │                   │   │
│  │                     │  ├───────────────────┤   │
│  │                     │  │  Documents        │   │
│  │                     │  │  - Upload         │   │
│  │                     │  │  - List           │   │
│  │                     │  │                   │   │
│  │                     │  ├───────────────────┤   │
│  │                     │  │  Description      │   │
│  │                     │  │  - Notes          │   │
│  └─────────────────────┘  └───────────────────┘   │
│                                                     │
└─────────────────────────────────────────────────────┘
```

### 🔧 Implementation Details

#### Change Detection
The screen tracks unsaved changes by:
- Saving initial state on load
- Comparing current state with initial state
- Triggering confirmation dialog on back navigation if changes exist

```dart
bool get hasUnsavedChanges => _checkForChanges();
```

#### Tab Switching Disabled
Unlike new booking screen, tab switching between Booking/Sales is disabled in edit mode:
```dart
void _handleTabSwitch(EditBookingType newType) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Cannot switch type while editing'),
    ),
  );
}
```

#### Validation
- Form validation using `_formKey`
- Client name validation
- Phone number validation
- Required fields checking before save

### 🎯 Key Differences from Old Edit Screen

| Feature | Old Edit Screen | New Edit Screen |
|---------|----------------|-----------------|
| Layout | Simple form | Full-featured with calendar |
| Product Selection | Basic list | Interactive with customization |
| Date Selection | Text fields | Visual calendar widget |
| Client/Staff | Text fields only | Search with autocomplete |
| Documents | Not supported | Full upload/manage UI |
| Change Detection | Basic | Comprehensive tracking |
| UI Consistency | Different from new | Matches new booking exactly |

### 📝 TODO Items

The following features need to be implemented:

1. **Product Conversion** (Line 228-229):
   ```dart
   // TODO: Convert booking.products to ProductSelectedModel list
   ```

2. **Additional Charges Conversion** (Line 232):
   ```dart
   // TODO: Convert booking additional charges if available
   ```

3. **Sale Products Conversion** (Line 267):
   ```dart
   // TODO: Convert sale.products to ProductSelectedModel list
   ```

4. **Update Booking Logic** (Line 1197-1200):
   ```dart
   Future<void> _updateBooking() async {
     // TODO: Implement booking update logic
   }
   ```

5. **Update Sale Logic** (Line 1202-1205):
   ```dart
   Future<void> _updateSale() async {
     // TODO: Implement sale update logic
   }
   ```

6. **Product Selection Dialog**:
   - Connect to SelectProductDialog
   - Handle product addition
   - Update selected products list

### 🚀 Future Enhancements

1. **Undo/Redo**: Add undo/redo functionality for edits
2. **Auto-save**: Implement auto-save drafts
3. **Version History**: Track changes with timestamps
4. **Bulk Edit**: Support editing multiple bookings/sales
5. **Advanced Validation**: More comprehensive validation rules
6. **Offline Support**: Cache edits for offline mode

### 🐛 Known Issues

- Product conversion from booking/sale models not yet implemented
- Additional charges conversion pending
- Update API calls need to be implemented
- Document upload functionality needs integration

### 📞 Support

For questions or issues with the editing screen:
1. Check the new booking screen implementation
2. Review the BookingCalendarWidget documentation
3. Consult the booking/sale models for data structure

---

**Created**: February 2026  
**Last Updated**: February 4, 2026  
**Version**: 1.0.0
