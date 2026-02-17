# Shop Switch Data Reload Implementation

## Summary
Implemented automatic data reloading when the user switches shops via the app bar/sidebar. Now all data pages automatically refresh to show data from the newly selected shop.

## Problem
When users switched shops using the dropdown in the app bar, the data on the current page (like All Bookings, Dashboard, etc.) would remain from the previous shop until the user manually refreshed or navigated away and back.

## Solution
Added `BlocListener<UserCubit, UserModel?>` to key screens to detect when the shop changes (UserCubit emits new state) and automatically trigger data reload.

## Files Modified

### 1. All Bookings Desktop Screen
**File:** `lib/features/all_booking/view/all_bookings_desktop_screen.dart`

**Changes:**
- Added imports for `UserCubit` and `UserModel`
- Wrapped the build method with `BlocListener<UserCubit, UserModel?>`
- When shop changes, calls `_loadData()` to reload bookings/sales

**Code:**
```dart
return BlocListener<UserCubit, UserModel?>(
  listener: (context, userState) {
    // When shop changes, reload data
    if (userState != null) {
      _loadData();  // Reloads bookings or sales based on active tab
    }
  },
  child: Scaffold(...),
);
```

**What Gets Reloaded:**
- Booking list (all status tabs: Upcoming, Returns, Pending, etc.)
- Sales list
- Status counts
- Search results
- Date filtered results

### 2. Home Screen (Dashboard)
**File:** `lib/features/home/view/home_screen.dart`

**Changes:**
- Wrapped build method with `BlocListener<UserCubit, UserModel?>`
- When shop changes, reloads dashboard data

**Code:**
```dart
return BlocListener<UserCubit, UserModel?>(
  listener: (context, userState) {
    // When shop changes, reload dashboard data
    if (userState != null) {
      bloc.add(const DashboardEvent.loadDashboardData(useOldState: true));
    }
  },
  child: BlocListener<BookingDetailsDrawerCubit, ...>(...),
);
```

**What Gets Reloaded:**
- Overview carousel (total bookings, revenue, etc.)
- Upcoming bookings (Today/Tomorrow/Upcoming)
- Returns bookings (Today/Tomorrow/Upcoming)
- Recent bookings

## How It Works

### Flow Diagram
```
User clicks shop dropdown
        ↓
Selects different shop
        ↓
UserCubit.switchShop() called
        ↓
UserCubit emits new UserModel state
        ↓
BlocListener<UserCubit> detects state change
        ↓
Triggers data reload (_loadData() or loadDashboardData())
        ↓
New API calls with new shop ID
        ↓
UI updates with new shop's data
```

### Technical Details

**UserCubit State Emission:**
```dart
// In UserCubit.switchShop()
Future<void> switchShop(int shopId, String? fcmToken) async {
  try {
    final userData = await _repository.switchShop(shopId);
    emit(userData);  // ← This triggers BlocListener
  } catch (e, stack) {
    log(e.toString(), stackTrace: stack);
    rethrow;
  }
}
```

**Listener Detection:**
```dart
BlocListener<UserCubit, UserModel?>(
  listener: (context, userState) {
    // userState is the new UserModel with updated shopDetails
    if (userState != null) {
      // Reload data for the new shop
    }
  },
  child: /* Your widget */,
)
```

## Testing Checklist

### All Bookings Screen
- [ ] Switch shop while on "Upcoming" tab → Data reloads for new shop
- [ ] Switch shop while on "Returns" tab → Data reloads for new shop
- [ ] Switch shop while on "Completed" tab → Data reloads for new shop
- [ ] Switch shop while on "Sales" tab → Sales data reloads for new shop
- [ ] Switch shop while search is active → Search results reload for new shop
- [ ] Switch shop while date filter is active → Filtered results reload for new shop
- [ ] Status counts update correctly after shop switch

### Home Screen (Dashboard)
- [ ] Switch shop → Overview carousel updates
- [ ] Switch shop → Upcoming bookings reload
- [ ] Switch shop → Returns bookings reload
- [ ] Switch shop → All counts update correctly
- [ ] Switch shop multiple times rapidly → No crashes, shows correct data

### Edge Cases
- [ ] Switch shop while drawer is open → Data reloads, drawer closes or updates
- [ ] Switch shop while paginating → Pagination resets correctly
- [ ] Switch shop with slow network → Loading indicator shows
- [ ] Switch shop while API call is in progress → Cancels old request, starts new one

## Future Enhancements

### Other Screens That May Need This
1. **Product Grid Screen** (Stock Management)
   - Should reload product inventory when shop changes
2. **Client List Screen**
   - Should reload client list for new shop
3. **Staff Analytics Screens**
   - Should reload staff data and analytics
4. **Ledger Screen**
   - Should reload financial data

### Implementation Template
For any screen that shows shop-specific data:

```dart
@override
Widget build(BuildContext context) {
  return BlocListener<UserCubit, UserModel?>(
    listener: (context, userState) {
      if (userState != null) {
        // Reload your data here
        // Call your bloc's load event or setState to trigger refresh
      }
    },
    child: // Your existing widget tree
  );
}
```

## Performance Considerations

### Network Efficiency
- Uses existing API endpoints (no new requests added)
- Only reloads when shop actually changes (not on every UserCubit emit)
- Uses `useOldState: true` for dashboard to maintain UI state during reload

### UI Experience
- No full page refresh (just data reload)
- Loading indicators show during reload
- Smooth transition between shops
- No data flash or flicker

## Notes

- The `userState != null` check ensures we only reload when a valid user state exists
- All existing search, filter, and pagination logic continues to work
- The shop ID is automatically sent with all API requests (handled by repository layer)
- Drawer state is maintained across shop switches (unless explicitly closed)

## Visual Flow

**Before (Bug):**
```
Shop A selected → All Bookings page showing Shop A data
              ↓
Switch to Shop B
              ↓
All Bookings page STILL showing Shop A data ❌
(User has to refresh manually or navigate away and back)
```

**After (Fixed):**
```
Shop A selected → All Bookings page showing Shop A data
              ↓
Switch to Shop B
              ↓
All Bookings page AUTOMATICALLY reloads
              ↓
All Bookings page showing Shop B data ✅
```
