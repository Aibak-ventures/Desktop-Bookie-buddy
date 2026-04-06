# Testing Checklist - Desktop Bookie Buddy Features

## Branch: `feature/booking-cancellation-refund`

### 1. Booking Cancellation Flow
**Location**: Booking Details Screen → Cancel Booking Button

- [ ] **Test 1.1**: Cancel button visibility
  - Open any active/upcoming booking
  - Verify "Cancel Booking" button appears in secondary actions (between Edit and Delete)
  - Open a completed booking
  - Verify button does NOT appear for completed bookings

- [ ] **Test 1.2**: Cancel booking dialog opens
  - Click "Cancel Booking" button
  - Verify refund dialog opens with proper title "Cancel Booking"
  - Verify dialog shows warning message about cancellation

- [ ] **Test 1.3**: Refund amount validation
  - Try entering refund amount > paid amount
  - Verify error message: "Refund amount cannot exceed paid amount"
  - Try entering negative amount
  - Verify validation fails
  - Try entering 0 amount
  - Verify it's accepted
  - Try entering valid amount (less than paid)
  - Verify no error

- [ ] **Test 1.4**: Payment method selection
  - Verify Cash and UPI/GPay radio cards are shown
  - Click Cash option
  - Verify Cash card is highlighted in purple
  - Click UPI option
  - Verify UPI card is highlighted
  - Verify only one can be selected at a time

- [ ] **Test 1.5**: Refund reason dropdown
  - Click refund reason dropdown
  - Verify 6 options appear:
    - Customer request
    - Product unavailable
    - Double booking
    - Better price elsewhere
    - Change of plans
    - Other
  - Select each option
  - Verify dropdown shows selected value

- [ ] **Test 1.6**: Cancel button in dialog
  - Click "Cancel" button in dialog
  - Verify dialog closes
  - Verify booking is not cancelled
  - Verify booking details screen still shows original data

- [ ] **Test 1.7**: Confirm cancellation with full refund
  - Open cancel dialog
  - Enter full paid amount as refund
  - Select payment method (Cash)
  - Select reason
  - Click "Cancel Booking" button
  - Verify loading state appears
  - Verify success message appears
  - Verify booking status updates to "Cancelled"
  - Verify refund is recorded

- [ ] **Test 1.8**: Confirm cancellation with partial refund
  - Open cancel dialog
  - Enter amount less than paid amount (e.g., 50% of paid)
  - Select payment method (UPI)
  - Select reason
  - Click "Cancel Booking"
  - Verify booking is cancelled
  - Verify partial refund is recorded

- [ ] **Test 1.9**: API error handling
  - Simulate network error (disconnect internet)
  - Try to cancel booking
  - Verify error message is displayed
  - Verify dialog stays open
  - Reconnect and verify retry works

- [ ] **Test 1.10**: Responsive design
  - Test on desktop (wide screen)
  - Verify dialog is centered, max width ~500px
  - Test on tablet size
  - Verify layout adjusts properly
  - Test on mobile size
  - Verify bottom sheet appears instead of dialog

---

## Branch: `feature/payment-method-premium-features`

### 2. Payment Method in Expenses
**Location**: Add Expense Screen / Edit Expense Screen

- [ ] **Test 2.1**: Payment method selector visibility (Add Expense)
  - Open "Add Expense" screen
  - Scroll to payment method section (between Amount and Category)
  - Verify "Payment Method" label is shown
  - Verify two radio cards are visible: Cash and UPI/GPay

- [ ] **Test 2.2**: Default selection
  - Open new expense form
  - Verify Cash is selected by default
  - Verify Cash card has purple highlight

- [ ] **Test 2.3**: Switch payment method
  - Click UPI/GPay card
  - Verify UPI card highlights in purple
  - Verify Cash card becomes gray
  - Click Cash card again
  - Verify Cash highlights, UPI becomes gray

- [ ] **Test 2.4**: Visual design (Desktop)
  - Verify cards show icons (₹ for Cash, 📱 for UPI)
  - Verify selected card has:
    - Purple background (light opacity)
    - Purple border
    - Purple text
  - Verify unselected card has:
    - Gray background
    - Gray border
    - Gray text

- [ ] **Test 2.5**: Visual design (Mobile/Tablet)
  - Resize to mobile width
  - Verify cards stack vertically
  - Verify spacing is appropriate
  - Verify touch targets are large enough

- [ ] **Test 2.6**: Save expense with Cash
  - Fill expense form
  - Select Cash payment method
  - Click Save
  - Verify expense is saved successfully
  - Go back and edit the expense
  - Verify Cash is still selected

- [ ] **Test 2.7**: Save expense with UPI
  - Fill expense form
  - Select UPI payment method
  - Click Save
  - Verify expense is saved
  - Edit expense
  - Verify UPI is selected

- [ ] **Test 2.8**: Edit existing expense payment method
  - Find an expense (if exists without payment method)
  - Edit it
  - Change payment method from Cash to UPI
  - Save
  - Verify update is successful
  - Re-edit to confirm UPI is saved

- [ ] **Test 2.9**: API integration
  - Create expense with Cash
  - Check network request (DevTools)
  - Verify `payment_method: "cash"` is sent
  - Create expense with UPI
  - Verify `payment_method: "gpay"` is sent

- [ ] **Test 2.10**: Form validation with payment method
  - Leave amount empty
  - Select payment method
  - Try to save
  - Verify other validations still work
  - Payment method should not block save if other fields are valid

---

## Branch: `feature/remaining-features`

### 3. Additional Charges Edit Access
**Location**: Booking Details Screen → Payment Details → Additional Charges

- [ ] **Test 3.1**: Edit button visibility (with charges)
  - Open booking that has additional charges
  - Expand "Additional charges" section
  - Verify "Edit" button appears next to charge count
  - Verify button has purple color
  - Verify edit icon (pencil) is shown

- [ ] **Test 3.2**: Edit button visibility (without charges)
  - Open booking with NO additional charges
  - Verify additional charges section is not shown at all
  - (This is expected behavior)

- [ ] **Test 3.3**: Navigation to Edit Booking
  - Click "Edit" button on additional charges
  - Verify navigation to Edit Booking screen
  - Verify screen loads correctly
  - Verify Additional Charges section is visible
  - Verify existing charges are shown in list

- [ ] **Test 3.4**: Add charge from Edit Booking
  - From Edit Booking screen
  - Click "+" button on Additional Charges section
  - Verify "Add Additional Charge" dialog opens
  - Enter charge name (e.g., "Delivery Fee")
  - Enter amount (e.g., 100)
  - Click Add
  - Verify charge appears in list
  - Save booking
  - Go back to booking details
  - Verify new charge is shown

- [ ] **Test 3.5**: Delete charge from Edit Booking
  - Navigate to Edit Booking via "Edit" button
  - Click delete icon on an existing charge
  - Verify charge is removed from list
  - Save booking
  - Go back to booking details
  - Verify charge is no longer shown
  - Verify total amount is recalculated

- [ ] **Test 3.6**: Edit charge amount
  - Navigate to Edit Booking
  - Click on existing charge to edit
  - Change amount
  - Save booking
  - Return to booking details
  - Verify updated amount is reflected
  - Verify total booking amount is updated

- [ ] **Test 3.7**: Cancel editing charges
  - Click Edit button
  - Add/modify a charge
  - Click back/cancel without saving
  - Verify changes are not applied
  - Verify original charges remain

- [ ] **Test 3.8**: Expansion animation
  - Click additional charges section to expand
  - Verify smooth animation
  - Verify arrow icon rotates
  - Verify charge list slides down
  - Click again to collapse
  - Verify reverse animation

- [ ] **Test 3.9**: Charge display format
  - Verify charge names are left-aligned
  - Verify charge amounts are right-aligned with currency symbol
  - Verify amounts use proper currency formatting (commas, decimals)
  - Verify total additional charges sum is correct

- [ ] **Test 3.10**: Multiple charges handling
  - Create booking with 5+ additional charges
  - Verify all charges are listed
  - Verify scroll works if list is long
  - Verify total calculation is accurate

---

## Already Implemented Features (Verify Working)

### 4. Premium Badge & Dialog
**Location**: Various screens with premium features

- [ ] **Test 4.1**: Premium badge visibility
  - Find any premium feature in the app
  - Verify crown icon + "Premium" badge is shown
  - Verify badge has shimmer/gradient effect
  - Verify purple theme is consistent

- [ ] **Test 4.2**: Premium dialog trigger
  - As non-premium user, click premium feature
  - Verify "Premium Feature" dialog opens
  - Verify message explains feature requires subscription
  - Verify "Upgrade Now" button is shown

- [ ] **Test 4.3**: Premium user access
  - Log in as premium user (if possible)
  - Verify premium features are accessible
  - Verify no dialog blocks access

### 5. Availability Check Feature
**Location**: Profile Screen → Check Availability

- [ ] **Test 5.1**: Profile tile navigation
  - Open Profile screen
  - Locate "Check Availability" tile/option
  - Click on it
  - Verify Check Availability screen opens

- [ ] **Test 5.2**: Service selection dialog
  - Verify dialog opens immediately on screen load
  - Verify service dropdown is shown
  - Verify only rental/sale services appear (material services filtered)
  - Select a service
  - Verify date picker appears

- [ ] **Test 5.3**: Date selection
  - Select a date
  - Verify date is highlighted
  - Click confirm/next
  - Verify navigation to product selection screen
  - Verify `availabilityCheckOnly` mode is active

- [ ] **Test 5.4**: Product display in availability mode
  - Verify products are shown in grid
  - Verify available products are highlighted/enabled
  - Verify unavailable products are grayed out/disabled
  - Verify "Add to Booking" button is hidden
  - Verify only availability information is shown

- [ ] **Test 5.5**: Back navigation
  - Click back from product screen
  - Verify returns to Check Availability screen
  - Verify can change date and check again

### 6. Date Range Filters
**Location**: All Bookings, Sales List, Ledger Screens

- [ ] **Test 6.1**: Filter button visibility (All Bookings)
  - Open All Bookings screen
  - Verify date filter button appears in app bar
  - Verify button shows calendar icon
  - Verify "Date Filter" label on desktop

- [ ] **Test 6.2**: Filter button visibility (Sales)
  - Open Sales screen
  - Verify filter button is present
  - Verify same styling as bookings

- [ ] **Test 6.3**: Filter button visibility (Ledger/Expenses)
  - Open Ledger screen, Expenses tab
  - Verify filter option exists (may be in menu or toolbar)

- [ ] **Test 6.4**: Open date filter dialog (Desktop)
  - Click filter button on desktop
  - Verify dialog appears (not bottom sheet)
  - Verify centered with max width ~500px
  - Verify close button works

- [ ] **Test 6.5**: Open date filter bottom sheet (Mobile)
  - Resize to mobile width
  - Click filter button
  - Verify bottom sheet slides up
  - Verify swipe down to close works

- [ ] **Test 6.6**: Select date range
  - Click filter button
  - Select start date (e.g., 7 days ago)
  - Select end date (today)
  - Click Apply/Confirm
  - Verify list filters to show only items in range

- [ ] **Test 6.7**: Single date filter
  - Open filter
  - Select only start date (leave end date empty)
  - Apply
  - Verify shows items from start date onwards
  - Try only end date
  - Verify shows items up to end date

- [ ] **Test 6.8**: Filter indicator
  - Apply a date filter
  - Verify filter indicator appears below search bar
  - Verify shows date range text (e.g., "Filtered by: Dec 14 - Dec 21")
  - Verify purple theme
  - Verify "X" close button is shown

- [ ] **Test 6.9**: Clear filter
  - With active filter, click "X" button
  - Verify filter is cleared
  - Verify indicator disappears
  - Verify full list is shown again

- [ ] **Test 6.10**: Filter + Search combination
  - Apply date filter
  - Type in search box
  - Verify both filters apply together
  - Clear search, verify date filter still active
  - Clear date filter, verify list returns to normal

- [ ] **Test 6.11**: Filter persistence
  - Apply date filter
  - Navigate away from screen
  - Come back
  - Verify filter is still active (or cleared - check expected behavior)

---

## Cross-Feature Integration Tests

### 7. Combined Scenarios

- [ ] **Test 7.1**: Cancel booking with additional charges
  - Open booking that has additional charges
  - Note total amount and charges
  - Cancel booking with full refund
  - Verify refund includes additional charges in calculation

- [ ] **Test 7.2**: Edit charges then cancel
  - Add additional charge via Edit button
  - Save changes
  - Cancel the booking
  - Verify updated total is used for refund calculation

- [ ] **Test 7.3**: Filter + Premium feature
  - Apply date filter on bookings
  - Try to access premium feature from filtered list
  - Verify premium dialog works
  - Clear filter, verify still works

- [ ] **Test 7.4**: Search + Filter + View details
  - Apply date filter
  - Search for specific booking
  - Open booking details
  - Cancel the booking
  - Verify list updates correctly

- [ ] **Test 7.5**: Multiple bookings workflow
  - Create/open 3 bookings
  - Add expenses with different payment methods
  - Check availability for dates
  - Apply date filters
  - Cancel one booking
  - Edit charges on another
  - Verify all features work independently

---

## Performance & Edge Cases

### 8. Stress Testing

- [ ] **Test 8.1**: Large expense list with filters
  - If many expenses exist, apply date filter
  - Verify performance is acceptable
  - Scroll through filtered list
  - Verify smooth scrolling

- [ ] **Test 8.2**: Many additional charges
  - Create booking with 10+ charges
  - Open booking details
  - Expand charges section
  - Verify all render correctly
  - Edit via Edit button
  - Verify edit screen handles many charges

- [ ] **Test 8.3**: Rapid filter changes
  - Quickly change date filters multiple times
  - Verify no crashes
  - Verify debouncing works (if implemented)

- [ ] **Test 8.4**: Network timeout scenarios
  - Start cancelling booking
  - Simulate slow network
  - Verify loading indicator shows
  - Verify timeout error handling

- [ ] **Test 8.5**: Concurrent actions
  - Open multiple booking details (if possible)
  - Try cancelling multiple bookings
  - Verify each maintains correct state

---

## Platform-Specific Tests

### 9. Desktop (Windows/Mac/Linux)

- [ ] **Test 9.1**: Keyboard navigation
  - Use Tab to navigate through cancel dialog fields
  - Use Enter to confirm
  - Use Esc to close dialogs
  - Verify shortcuts work

- [ ] **Test 9.2**: Mouse interactions
  - Hover over Edit button
  - Verify hover state (if implemented)
  - Right-click scenarios
  - Verify context menus (if any)

- [ ] **Test 9.3**: Window resizing
  - Resize window while on booking details
  - Verify responsive layouts adjust
  - Verify no UI breaks

### 10. Mobile (Android/iOS if supported)

- [ ] **Test 10.1**: Touch targets
  - Verify all buttons are easily tappable
  - Verify minimum 44x44 touch area
  - Verify no overlapping interactive elements

- [ ] **Test 10.2**: Keyboard behavior
  - Open expense form
  - Verify keyboard appears for amount field
  - Verify number keyboard for amount
  - Verify keyboard dismisses properly

- [ ] **Test 10.3**: Bottom sheet gestures
  - Swipe down to close bottom sheets
  - Drag to adjust height
  - Verify smooth animations

---

## Accessibility

### 11. Accessibility Tests

- [ ] **Test 11.1**: Screen reader support
  - Enable screen reader
  - Navigate through cancel booking dialog
  - Verify all elements are announced
  - Verify button labels are clear

- [ ] **Test 11.2**: Color contrast
  - Verify purple text on white background meets WCAG AA
  - Verify error messages are readable
  - Verify disabled states are distinguishable

- [ ] **Test 11.3**: Focus indicators
  - Tab through form fields
  - Verify focus ring is visible
  - Verify focus order is logical

---

## Summary Stats

- **Total Test Cases**: 110+
- **Critical Path Tests**: 40
- **Integration Tests**: 15
- **Edge Case Tests**: 20
- **Platform Tests**: 15
- **Accessibility Tests**: 10

## Priority Levels

🔴 **High Priority (Must Test)**:
- All Test 1.x (Booking Cancellation)
- Tests 2.1-2.7 (Payment Method)
- Tests 3.1-3.6 (Additional Charges)
- Tests 6.1-6.9 (Date Filters)

🟡 **Medium Priority (Should Test)**:
- Tests 1.9-1.10 (Error handling, responsive)
- Tests 2.8-2.10 (Edit scenarios)
- Tests 3.7-3.10 (Edge cases)
- Tests 6.10-6.11 (Combined scenarios)

🟢 **Low Priority (Nice to Test)**:
- Tests 4.x-5.x (Already working features)
- Tests 8.x (Performance)
- Tests 9.x-11.x (Platform specific)

---

## Testing Notes

- Test with **real backend** connected
- Test with **multiple user roles** (if applicable)
- Test **both desktop and mobile layouts**
- Document any bugs found with:
  - Steps to reproduce
  - Expected vs actual behavior
  - Screenshots/recordings
  - Device/platform details

Good luck with testing! 🚀
