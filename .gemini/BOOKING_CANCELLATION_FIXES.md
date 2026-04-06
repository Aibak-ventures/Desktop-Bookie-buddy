# Booking Cancellation Fixes

## Summary
Fixed multiple issues with the booking cancellation flow to improve security, UX, and consistency.

## Changes Made

### 1. Security Password Check for Cancellation ✅
**File:** `booking_details_drawer.dart`

**What Changed:**
- Added `performSecureActionDialog` wrapper around the cancel booking dialog
- Uses `SecretPasswordLocations.bookingDelete` to check if user needs to enter security password
- Only shows the cancel dialog after successful password verification (if required)

**Location:** Lines 335-360 (in `_buildBookingHeaderSection` method)

**Before:**
```dart
if (newStatus == DeliveryStatus.cancelled) {
  showDialog(
    context: context,
    builder: (dialogContext) => CancelBookingDialog(...),
  );
  return;
}
```

**After:**
```dart
if (newStatus == DeliveryStatus.cancelled) {
  performSecureActionDialog(
    context,
    SecretPasswordLocations.bookingDelete,
    onSuccess: () {
      showDialog(
        context: context,
        builder: (dialogContext) => CancelBookingDialog(...),
      );
    },
  );
  return;
}
```

### 2. Use Context Snackbar Extension ✅
**Files:** 
- `booking_details_drawer.dart` (lines 113-148)
- `cancel_booking_dialog.dart` (lines 1, 47-52)

**What Changed:**
- Replaced `ScaffoldMessenger.of(context).showSnackBar(...)` with `context.showSnackBar(...)`
- Uses the app's custom snackbar context extension for consistency
- Supports `isError` parameter for error styling

**Before:**
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
  ),
);
```

**After:**
```dart
context.showSnackBar(message);
// or for errors:
context.showSnackBar(error, isError: true);
```

### 3. Disable UI Elements When Booking is Cancelled ✅
**File:** `booking_details_drawer.dart`

#### 3a. Delivery Status Dropdown (lines 225-231, 306-328)
**What Changed:**
- Fixed the check to use `booking.deliveryStatus` instead of `booking.bookingStatus`
- When `deliveryStatus == DeliveryStatus.cancelled`, show a non-interactive status badge instead of dropdown
- User cannot change delivery status of a cancelled booking

**Before:**
```dart
final isCancelled = booking.bookingStatus == BookingStatus.cancelled;
final isBookingFinalized = isCompleted || isCancelled;

if (isBookingFinalized)
  Container(...) // non-interactive badge
else
  PopupMenuButton<DeliveryStatus>(...) // interactive dropdown
```

**After:**
```dart
final isCancelled = status == DeliveryStatus.cancelled; // Using deliveryStatus
final isBookingFinalized = isCompleted || isCancelled;

if (isBookingFinalized)
  Container(...) // non-interactive badge
else
  PopupMenuButton<DeliveryStatus>(...) // interactive dropdown
```

#### 3b. Add Payment Button (lines 1301-1417)
**What Changed:**
- When booking is cancelled, show a disabled-style button with:
  - **White background** (instead of red.shade50)
  - **Red border** (red.shade400, width: 2)
  - **Red text** showing "Booking Cancelled" (red.shade700)
  - **Red cancel icon**
- Button is not clickable (it's a Container, not a button)

**UI Appearance:**
```
┌─────────────────────────┐
│  ❌  Booking Cancelled  │  ← White background, red border & text
└─────────────────────────┘
```

**Code:**
```dart
if (isCancelled)
  // Disabled button style for cancelled bookings
  Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,  // White background
      border: Border.all(color: Colors.red.shade400, width: 2),  // Red border
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.cancel, color: Colors.red.shade700, size: 16),
        const SizedBox(width: 6),
        Text(
          'Booking Cancelled',  // Updated text
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.red.shade700,  // Red text
          ),
        ),
      ],
    ),
  )
```

### 4. Prevent List Refresh After Cancellation ✅
**File:** `booking_details_drawer.dart` (lines 126-136)

**What Changed:**
- Removed automatic list reload (`context.read<AllBookingBloc>().add(const AllBookingEvent.loadBookings())`)
- Only refreshes the drawer data by fetching updated booking details
- Prevents tab switching/jumping when user is on a specific tab (e.g., "upcoming bookings")
- List will be refreshed when:
  - User manually refreshes
  - User closes the drawer and reopens
  - User performs other actions that trigger a refresh

**Before:**
```dart
if (needRefresh && drawerState.selectedBookingId != null) {
  // Refresh drawer data
  context.read<BookingDetailsBloc>().add(...);
  
  // Also refresh the main booking list in background
  context.read<AllBookingBloc>().add(
    const AllBookingEvent.loadBookings(),
  );
}
```

**After:**
```dart
if (needRefresh && drawerState.selectedBookingId != null) {
  // Refresh drawer data
  context.read<BookingDetailsBloc>().add(...);
  
  // Only refresh the main booking list if not a cancellation
  // (to prevent tab switching)
  // The list will be refreshed when drawer is closed or user manually refreshes
}
```

### 5. Dialog Closure Fix ✅
**File:** `cancel_booking_dialog.dart` (lines 45-65)

**What Changed:**
- Removed dialog self-closure (`Navigator.of(context).pop()`)
- The calling code now handles dialog closure in the `onConfirm` callback
- Prevents double-closure issues

**Before:**
```dart
void _handleConfirm() {
  ...
  // Close dialog first to prevent black screen
  Navigator.of(context).pop();
  
  // Then call the callback
  widget.onConfirm(refundAmount, _selectedPaymentMethod);
}
```

**After:**
```dart
void _handleConfirm() {
  ...
  // Call the callback - the calling code will handle dialog closure
  widget.onConfirm(refundAmount, _selectedPaymentMethod);
}
```

**Calling code:**
```dart
onConfirm: (refundAmount, paymentMethod) {
  Navigator.of(dialogContext).pop();  // Close dialog here
  context.read<BookingDetailsBloc>().add(...);
}
```

## Testing Checklist

- [ ] Click cancel from delivery status dropdown
- [ ] Verify security password dialog appears (if user has restriction)
- [ ] Enter correct password and verify cancel dialog shows
- [ ] Cancel a booking with refund
- [ ] Verify success message shows using custom snackbar
- [ ] Verify drawer updates to show "Booking Cancelled" button
- [ ] Verify "Booking Cancelled" button has white background, red border, red text
- [ ] Verify delivery status dropdown is disabled and shows static "cancelled" badge
- [ ] Verify user stays on the same tab (doesn't switch to different tab)
- [ ] Verify "Add Payment" button is disabled and styled correctly
- [ ] Click other bookings and verify drawer updates correctly
- [ ] Close drawer and verify list eventually updates (on next drawer open or manual refresh)

## Files Modified

1. `lib/features/all_booking/view/widgets/booking_details_drawer.dart`
   - Added security check before cancellation
   - Updated snackbar usage
   - Fixed cancelled status checks
   - Updated "Add Payment" button UI for cancelled bookings
   - Removed automatic list refresh

2. `lib/features/booking_details/view/widgets/dialogs/cancel_booking_dialog.dart`
   - Updated snackbar usage
   - Removed self-closure
   - Added context_extensions import

## Related Enums/Constants Used

- `SecretPasswordLocations.bookingDelete` - For security password check
- `DeliveryStatus.cancelled` - To check if booking is cancelled
- `BookingStatus.completed` - To check if booking is completed
- `context.showSnackBar(message, isError: bool)` - Custom snackbar extension
