# 🐛 Bug Fixes Needed - Testing Results

## Critical Bugs Found (December 22, 2025)

### 🔴 Bug #1: Cancel Booking Dialog Overflow
**Status**: CRITICAL  
**Branch**: `feature/booking-cancellation-refund`

**Error**:
```
RenderFlex overflowed by X pixels on the bottom
OVERFLOWING Column in CancelBookingDialog
constraints: BoxConstraints(w=452.0, 0.0<=h<=586.4)
```

**Root Cause**: The cancel booking dialog content exceeds available height (586.4px). Dialog Column has too many fields:
- Warning message
- Refund amount input
- Payment method cards (Cash + UPI)
- Reason dropdown  
- 2 buttons (Cancel, Confirm)

**Fix Required**:
Wrap Column content in SingleChildScrollView to make dialog scrollable.

**Files to Fix**:
- Location: Need to find cancel booking dialog file (wasn't in expected path)
- Likely in: `lib/features/booking_details/view/booking_details_screen.dart` (inline dialog) or separate dialog file

**Fix Code**:
```dart
// Wrap the Column children in SingleChildScrollView
Dialog(
  child: ConstrainedBox(
    constraints: BoxConstraints(maxWidth: 500, maxHeight: 600),
    child: SingleChildScrollView(  // ADD THIS
      child: Padding(
        padding: 24.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ... existing dialog content
          ],
        ),
      ),
    ),
  ),
)
```

---

### 🔴 Bug #2: Expense Payment Method Not Sent to API
**Status**: CRITICAL  
**Branch**: `feature/payment-method-premium-features`

**Error**:
```
POST https://dev.bookiebuddy.in/api/v3/expenses/expenses/61/
statusCode: 400
Response: {"status":"validation_error","message":"Please check your details and try again.","data":null}
```

**Root Cause**: The `payment_method` field was added to `ExpenseRequestModel` BUT:
1. ❌ Field is NOT present in the current model (checked file - missing)
2. ❌ UI collects payment method but doesn't send it to backend
3. ❌ Model needs regeneration after adding field

**Fix Required**:
1. Add `payment_method` field to `ExpenseRequestModel`
2. Regenerate freezed/json_serializable code
3. Pass payment method value when creating/editing expense

**Files to Fix**:
- `lib/features/save_expense/models/expense_request_model/expense_request_model.dart`
- `lib/features/save_expense/view/add_expense_screen.dart`

**Fix Code**:

```dart
// 1. Update expense_request_model.dart
@freezed
class ExpenseRequestModel with _$ExpenseRequestModel {
  const factory ExpenseRequestModel({
    @JsonKey(includeToJson: true, includeIfNull: false)
    int? expenseId,
    @JsonKey(name: 'product_variant', includeIfNull: false)
    int? variantId,
    @JsonKey(includeIfNull: false)
    String? date,
    @JsonKey(name: 'expense', includeIfNull: false)
    int? amount,
    @JsonKey(includeIfNull: false)
    String? type,
    @JsonKey(includeIfNull: false)
    String? description,
    // ADD THIS FIELD:
    @JsonKey(name: 'payment_method', includeIfNull: false)
    String? paymentMethod,  // "cash" or "gpay"
  }) = _ExpenseRequestModel;

  factory ExpenseRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseRequestModelFromJson(json);
}
```

```dart
// 2. Update add_expense_screen.dart - in _saveExpense method
final expenseData = ExpenseRequestModel(
  expenseId: widget.expense?.id,
  variantId: _variantNotifier.value?.id,
  date: _selectedDate.format(pattern: 'yyyy-MM-dd'),
  amount: expenseController.text.toIntOrDefault(),
  type: _selectedCategory,
  description: descriptionController.text.trim(),
  paymentMethod: _selectedPaymentMethod.value, // ADD THIS LINE
);
```

```bash
# 3. Regenerate code
flutter pub run build_runner build --delete-conflicting-outputs
```

---

### 🔴 Bug #3: Edit Booking Provider Missing
**Status**: CRITICAL  
**Branch**: `feature/remaining-features`

**Error**:
```
ProviderNotFoundException: Could not find the correct Provider<UpdateBookingCubit>
The relevant error-causing widget was: EditBookingButton
EditBookingButton:file:///D:/Documents/bookie_buddy_web/lib/features/booking_details/view/edit_booking_screen/edit_booking_screen.dart:157:25
```

**Root Cause**: When navigating to `EditBookingScreen` from Additional Charges "Edit" button, the `UpdateBookingCubit` provider is not available in the widget tree. The screen expects the cubit to be provided by a parent, but Navigator.push creates a new route without it.

**Fix Required**:
Provide the `UpdateBookingCubit` when navigating to Edit Booking screen.

**Files to Fix**:
- `lib/features/booking_details/view/widgets/sections/booking_details_payment_details_section.dart`

**Fix Code**:

```dart
// CURRENT (BROKEN):
TextButton.icon(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookingScreen(booking: booking),
      ),
    );
  },
  // ...
)

// FIX - Wrap with BlocProvider:
TextButton.icon(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => UpdateBookingCubit(
            repository: context.read<BookingRepository>(),
          ),
          child: EditBookingScreen(booking: booking),
        ),
      ),
    );
  },
  // ...
)
```

**Alternative Fix** (Better):
Use the app's navigation system that already provides cubits:
```dart
TextButton.icon(
  onPressed: () {
    // Use context.push instead if using go_router
    // Or use the existing navigation helper
    NavigatorX(context).push(EditBookingScreen(booking: booking));
  },
  // ...
)
```

---

## 📋 Missing Features (Not in Original 8 Tasks)

### 1. ❌ Refund Management UI
**What Exists**: 
- ✅ Refund API: `/api/v5/bookings/add-refund/`
- ✅ Refund model in booking details: `refunds[]`, `total_refunded`, `refundable_balance`

**What's Missing**:
- ❌ UI to view refund history in booking details
- ❌ Section to show all refunds with dates, amounts, methods
- ❌ Total refunded display
- ❌ Refundable balance indicator

**Where to Add**:
`lib/features/booking_details/view/widgets/sections/booking_details_payment_details_section.dart`

Add after payments section:
```dart
// Refunds Section
if (booking.refunds.isNotEmpty)
  ExpansionTile(
    title: Text('Refunds (${booking.refunds.length})'),
    children: booking.refunds.map((refund) => ListTile(
      title: Text(refund.reason),
      subtitle: Text(refund.date),
      trailing: Text('-${refund.amount.toCurrency()}'),
    )).toList(),
  ),

// Refundable Balance
if ((booking.refundableBalance ?? 0) > 0)
  _PaymentDetailsRow(
    title: 'Refundable balance',
    amount: booking.refundableBalance ?? 0,
    color: AppColors.green,
  ),
```

---

### 2. ❌ Multi-Shop Handling
**What Exists**:
- ✅ API header: `X-Active-Shop-ID: 7`
- ✅ Shop selection in profile (saw "Shop role in profile screen: ShopRole.owner")

**What's Missing**:
- ❌ Shop switcher in app bar/drawer
- ❌ Current shop display
- ❌ Shop list to switch between shops
- ❌ Permissions based on shop role

**Where It Might Be**:
- Check `lib/features/profile/view/profile_screen.dart`
- May need to add shop selector widget

**Estimated Work**: 4-6 hours

---

### 3. ❌ Costume Service Special Availability Checking
**What's Observed**:
```json
{"id":99,"service_name":"Costumes","description":"","main_service_name":"Costume"}
```

**What's Missing**:
- ❌ Special conditions for costume availability
  - Different cooling period calculation?
  - Same person height/size restrictions?
  - Special booking rules?

**Need Clarification**:
What are the specific costume service conditions you mentioned?
- Is it about size matching?
- Return date restrictions?
- Availability calculation differences?

---

## 🔧 How to Fix These Bugs

### Step 1: Fix Cancel Dialog Overflow
```bash
# Find the cancel dialog file
git log --all --full-history --source -- "**/cancel_booking_dialog.dart"

# Or check where it's defined
grep -r "CancelBookingDialog\|showCancelBookingDialog" lib/
```

### Step 2: Fix Expense Payment Method
```bash
# Switch to payment method branch
git checkout feature/payment-method-premium-features

# Add payment_method field to model (shown above)

# Regenerate code
flutter pub run build_runner build --delete-conflicting-outputs

# Test the fix
flutter run -d windows
```

### Step 3: Fix Edit Booking Navigation
```bash
# Switch to remaining features branch
git checkout feature/remaining-features

# Update booking_details_payment_details_section.dart (shown above)

# Test
flutter run -d windows
```

---

## 🎯 Priority Order

1. **FIX BUG #2 FIRST** (Expense Payment Method) - Breaks new feature completely
2. **FIX BUG #3** (Edit Booking Provider) - Breaks additional charges editing  
3. **FIX BUG #1** (Cancel Dialog Scroll) - UX issue but not breaking

Then decide if you want to add the missing features:
4. Refund history UI (2 hours)
5. Multi-shop selector (4-6 hours)
6. Costume special conditions (depends on requirements)

---

## Testing Checklist After Fixes

- [ ] Cancel booking with full refund (should scroll if needed)
- [ ] Edit expense with Cash payment method → Verify API sends `payment_method: "cash"`
- [ ] Edit expense with UPI payment method → Verify API sends `payment_method: "gpay"`
- [ ] Click "Edit" on additional charges → Should open edit booking without error
- [ ] Add/delete charges in edit booking → Save successfully
- [ ] Return to booking details → Verify charges updated

---

## Questions for You

1. **Cancel Dialog**: Where did you implement the cancel booking dialog? I couldn't find the file.

2. **Expense Payment Method**: Did you add the field to the model? The current code shows it's missing.

3. **Refund Management**: Do you want me to add the refund history UI?

4. **Multi-Shop**: Is shop switching important for your use case?

5. **Costume Conditions**: What are the specific availability rules for costume service?

Let me know which bugs you want me to fix first! 🚀
