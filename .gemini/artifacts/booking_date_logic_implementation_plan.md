# Booking Date Selection Logic - Implementation Plan

**Date**: February 10, 2026  
**Module**: Add Booking (Date Selection Screen)  
**File**: `lib/features/add_booking/view/add_booking_date_selecting_screen.dart`

## Overview
This document outlines the implementation plan for comprehensive date selection logic that ensures business rules are enforced for booking creation.

## Core Business Rules

### 1. Date Constraints
- **Pickup Date**: Can be past (up to 1 year back) or future (up to 1 year ahead)
- **Return Date**: MUST be Today or Future. Never in the past, even if Pickup is in the past
- **Cooling Period**: 
  - Mode "After": Maintenance period after return
  - Mode "Before": Preparation period before pickup

### 2. The Ripple Effect
When dates change, dependent dates must auto-update:

```
IF Pickup Changes:
  IF new_pickup > current_return:
    return_date = pickup_date + 1_day
  IF cooling_mode == "before":
    cooling_date = pickup_date - cooling_duration

IF Return Changes:
  IF cooling_mode == "after":
    cooling_date = return_date + cooling_duration
```

### 3. Time Validation
- Same day bookings: Return time MUST be after Pickup time
- New bookings: Times cannot be in the past
- Ongoing bookings (past pickup): Past times are allowed

## Implementation Steps

### Phase 1: Date Picker Constraints ✓
Update `showDatePicker` calls with correct `firstDate` and `lastDate`:

**Pickup Date Picker:**
```dart
firstDate: DateTime.now().subtract(Duration(days: 365))
lastDate: DateTime.now().add(Duration(days: 365))
initialDate: pickupDateNotifier.value
```

**Return Date Picker:**
```dart
firstDate: max(DateTime.now(), pickupDateNotifier.value)
lastDate: DateTime.now().add(Duration(days: 365))
initialDate: max(DateTime.now(), pickupDateNotifier.value.add(Duration(days: 1)))
```

**Cooling Date Picker (After Mode):**
```dart
firstDate: returnDate
lastDate: DateTime.now().add(Duration(days: 365))
initialDate: returnDate.add(Duration(days: coolingDuration))
```

**Cooling Date Picker (Before Mode):**
```dart
firstDate: DateTime.now().subtract(Duration(days: 365))
lastDate: pickupDate
initialDate: pickupDate.subtract(Duration(days: coolingDuration))
```

### Phase 2: Ripple Effect Logic ✓
Implement cascading updates when dates change.

**When Pickup Date Changes:**
1. Check if new pickup > current return
2. If yes, set return = pickup + 1 day
3. If cooling mode is "before", recalculate cooling date
4. Update all controllers
5. Validate state

**When Return Date Changes:**
1. If cooling mode is "after", recalculate cooling date
2. Update controllers
3. Validate state

### Phase 3: Time Validation ✓
Add comprehensive time validation:

**Same Day Validation:**
```dart
if (pickupDate.isSameDay(returnDate)) {
  if (returnTime != null && pickupTime != null) {
    if (!isReturnTimeAfterPickupTime()) {
      showError("Return time must be after pickup time");
      clearReturnTime();
    }
  }
}
```

**Past Time Validation (New Bookings):**
```dart
if (pickupDate.isToday && !isOngoingBooking) {
  if (pickupTime != null && isInPast(pickupTime)) {
    showError("Pickup time cannot be in the past");
    return;
  }
}
```

### Phase 4: Default Values ✓
Set intelligent defaults based on shop settings:

**Standard Flow:**
- Pickup: Today
- Return: Tomorrow
- Cooling: Auto-calculated based on mode

**Ongoing Booking (Past Pickup):**
- Pickup: User selected past date
- Return: Today (minimum)
- Cooling: Calculated appropriately

### Phase 5: Validation & Error Messages ✓
Add comprehensive validation:

1. Date validations
2. Time validations
3. Cooling period validations
4. Clear, user-friendly error messages

### Phase 6: UI Enhancements ✓
1. Disable invalid dates in pickers (grayed out)
2. Show helpful hints/tooltips
3. Visual feedback for auto-updates
4. Loading states during calculations

## Test Cases Coverage

### Critical Test Cases to Implement:
- [x] TC-04: Future booking
- [x] TC-05: Ongoing booking (past start)
- [x] TC-06: Push logic (Pickup > Return)
- [x] TC-07: Pull logic (Pickup < Return)
- [x] TC-20: Same day valid times
- [x] TC-21: Same day invalid times
- [x] TC-24: Past time validation (today)
- [x] TC-10: Auto-calc on return change (After mode)
- [x] TC-15: Auto-calc on pickup change (Before mode)

## Known Edge Cases

1. **Year Transition**: Test Dec 31 → Jan 1
2. **Leap Year**: Test Feb 28/29
3. **Time Zones**: Assume device local time
4. **Rapid Mode Switch**: Before ↔ After mode changes
5. **Manual Cooling Period**: User override validation

## Dependencies

### Required Models/Enums:
- `CoolingPeriodMode` enum (before/after)
- Shop settings with cooling period configuration

### Required Helper Functions:
```dart
DateTime max(DateTime a, DateTime b)
DateTime min(DateTime a, DateTime b)
bool isReturnTimeAfterPickupTime()
bool isInPast(TimeOfDay time)
void showError(String message)
void updateDependentDates()
```

## Success Criteria

✓ All date pickers have correct constraints  
✓ Ripple effect works in all scenarios  
✓ Time validation prevents invalid states  
✓ Error messages are clear and helpful  
✓ UI provides good feedback  
✓ Critical test cases pass  
✓ Edge cases handled gracefully  

## Out of Scope

- Creating fully past bookings (Return < Today)
- Time zone conversions
- Historical booking edits
- Multi-day time calculations across time zones
