# 🧪 TESTING GUIDE - Date Constraints Implementation
## How to Test All Completed Features

---

## 📋 PRE-TESTING SETUP

### **IMPORTANT: Set Cooling Period in Settings First**

Before testing, you need to configure the cooling period settings:

1. **Navigate to Settings** (if available in your app)
2. **Find "Product Maintenance / Cooling End Date" section**
3. **Set Cooling Period Duration**: 
   - Try `3 days` for initial testing
   - You can change this later to test different scenarios

**NOTE**: The cooling mode is currently hardcoded to "AFTER" mode since the Settings UI isn't implemented yet. This means:
- ✅ You CAN test: Cooling period after return date (maintenance mode)
- ❌ You CANNOT test: Cooling period before pickup date (preparation mode) - *requires Settings UI*

---

## 🎯 TEST SUITE 1: PICKUP DATE CONSTRAINTS

### **TC-05: Ongoing Booking (Past Pickup Date)**
**What Was Fixed**: Pickup date can now go back 365 days (was only 30 days)

**Steps**:
1. Open **New Booking** screen
2. Click on **Pickup Date** field
3. In the calendar picker, **scroll back to previous months**
4. **Try to select a date 3 months ago** (e.g., if today is Feb 10, select Nov 10)
5. **Try to select a date 1 year ago** (should be the earliest allowed)
6. **Try to scroll further back** (should be disabled)

**Expected Result**:
- ✅ Can select dates from **Today - 365 days** to **Today + 365 days**
- ✅ Dates older than 365 days should be disabled/grayed out
- ✅ Calendar should not scroll before (Today - 365 days)

---

### **TC-04: Future Booking**
**What Was Fixed**: Future dates limited to 365 days (was 730 days)

**Steps**:
1. Open **New Booking** screen
2. Click on **Pickup Date** field
3. In the calendar picker, **scroll forward to future months**
4. **Try to select a date 6 months ahead**
5. **Try to select a date 1 year ahead** (should be the latest allowed)
6. **Try to scroll further ahead** (should be disabled)

**Expected Result**:
- ✅ Can select dates up to **Today + 365 days**
- ✅ Dates beyond 365 days should be disabled/grayed out
- ✅ Calendar should not scroll beyond (Today + 365 days)

---

## 🎯 TEST SUITE 2: RETURN DATE CONSTRAINTS

### **TC-09: Block Past Return Date**
**What Was Fixed**: Return date MUST be today or future, never past

**Steps**:
1. Open **New Booking** screen
2. Set **Pickup Date** to **last week** (e.g., 7 days ago)
3. Now click on **Return Date** field
4. In the calendar picker, **try to scroll to past dates**

**Expected Result**:
- ✅ Return date picker should start at **TODAY** (not last week)
- ✅ All dates before TODAY should be disabled/grayed out
- ✅ You can ONLY select TODAY or future dates
- ❌ You CANNOT select any past dates, even after the pickup date

**Visual Check**:
```
Pickup: Feb 3, 2026 (past)
Return: Can only choose Feb 10, 2026 (today) or later
        ❌ Cannot choose Feb 4-9 (blocked even though they're after pickup)
```

---

### **TC-06: Push Logic (Pickup > Return)**
**What Was Fixed**: When pickup goes after return, return auto-updates

**Steps**:
1. Open **New Booking** screen
2. Set **Pickup Date**: **Feb 10** (today)
3. Set **Return Date**: **Feb 12**
4. Now **change Pickup Date** to **Feb 15**

**Expected Result**:
- ✅ Return Date should **automatically change** to **Feb 16** (Pickup + 1 day)
- ✅ You should see the return date update instantly
- ✅ If you had a cooling period set, it should also update

**Visual Check**:
```
Before:  Pickup: Feb 10 → Return: Feb 12
Change:  Pickup: Feb 15
After:   Pickup: Feb 15 → Return: Feb 16 (auto-updated!)
```

---

## 🎯 TEST SUITE 3: COOLING PERIOD "AFTER" MODE

**NOTE**: This only works if you've set cooling period days > 0 in Settings

### **TC-02: Default Load with Cooling After**
**What Was Fixed**: Cooling period auto-initializes on screen load

**Steps**:
1. Make sure **Settings > Cooling Period** is set to **3 days** (or any value > 0)
2. **Close and reopen** the New Booking screen (or refresh the app)
3. Check the **Cooling Period Date** field

**Expected Result**:
- ✅ Pickup Date: **Today** (e.g., Feb 10)
- ✅ Return Date: **Tomorrow** (e.g., Feb 11)
- ✅ Cooling Period Date: **Return + 3 days** = **Feb 14**
- ✅ All three dates should be visible and set automatically

---

### **TC-10: Auto-Calc on Return Change (After Mode)**
**What Was Fixed**: Cooling period updates when return date changes

**Steps**:
1. Make sure **Cooling Period** is set to **3 days** in Settings
2. Open **New Booking** screen
3. Note the initial **Cooling Period Date**
4. **Change Return Date** from Feb 11 to **Feb 20**
5. Watch the **Cooling Period Date** field

**Expected Result**:
- ✅ Cooling Period Date should **automatically change** from Feb 14 to **Feb 23**
- ✅ Formula: New Return (Feb 20) + 3 days = Feb 23
- ✅ Update should be instant

**Visual Check**:
```
Before:  Return: Feb 11 → Cooling: Feb 14
Change:  Return: Feb 20
After:   Return: Feb 20 → Cooling: Feb 23 (auto-updated!)
```

---

### **TC-11: Manual Cooling Extension**
**What Was Fixed**: You can manually adjust cooling date, but it must be after return

**Steps**:
1. Set **Return Date**: **Feb 15**
2. Set **Cooling Period** to 3 days (auto-sets to Feb 18)
3. Click on **Cooling Period Date** field
4. In the picker, **try to select Feb 14** (before return)
5. **Try to select Feb 15** (same as return)
6. **Try to select Feb 20** (after return)

**Expected Result**:
- ❌ Feb 14 (before return) should be **disabled/grayed out**
- ✅ Feb 15 (return date) should be **allowed** (minimum)
- ✅ Feb 20 should be **allowed**
- ✅ You can extend cooling period as far as you want (up to +365 days)

---

### **TC-14: Push Logic Propagation**
**What Was Fixed**: Changing pickup cascades to return, then to cooling

**Steps**:
1. Set **Pickup**: **Feb 1**, **Return**: **Feb 5**, **Cooling**: **Feb 8** (with 3-day cooling)
2. Now **change Pickup** to **Feb 10** (after current return)
3. Watch all three dates

**Expected Result**:
- ✅ Pickup changes to **Feb 10**
- ✅ Return auto-updates to **Feb 11** (pickup + 1)
- ✅ Cooling auto-updates to **Feb 14** (return + 3)
- ✅ All three cascade perfectly!

**Visual Check**:
```
Before:  Pickup: Feb 1  → Return: Feb 5  → Cooling: Feb 8
Change:  Pickup: Feb 10
After:   Pickup: Feb 10 → Return: Feb 11 → Cooling: Feb 14
         (auto!)         (auto!)
```

---

## 🎯 TEST SUITE 4: TIME VALIDATION

### **TC-20-21: Same-Day Time Validation**
**What Was Fixed**: Return time must be after pickup time on same day

**Steps**:
1. Set **Pickup Date**: **Today** (Feb 10)
2. Set **Return Date**: **Today** (Feb 10) - same day
3. Set **Pickup Time**: **2:00 PM**
4. Now try to set **Return Time**: **1:00 PM** (before pickup)

**Expected Result**:
- ✅ Error message appears: **"Return time must be after pickup time"**
- ✅ Return time field should be cleared or not accept the time
- ✅ No error if you set Return Time to **3:00 PM** (after pickup)

---

### **TC-24: Past Time Prevention**
**What Was Fixed**: Cannot set pickup time in the past for today's date

**Steps**:
1. Set **Pickup Date**: **Today** (current date)
2. Try to set **Pickup Time** to **1 hour ago** (e.g., if it's 3 PM now, try 2 PM)

**Expected Result**:
- ✅ Error message: **"Pickup time cannot be in the past"**
- ✅ Time should not be accepted
- ✅ Future times work fine

**NOTE**: This only applies to TODAY's date. Past dates are allowed for ongoing bookings.

---

## 🎯 TEST SUITE 5: EDGE CASES

### **TC-27: Year Transition**
**What Was Fixed**: Calendar works across year boundaries

**Steps**:
1. Set **Pickup Date**: **Dec 31, 2026**
2. Set **Return Date**: **Jan 1, 2027**

**Expected Result**:
- ✅ Both dates should be selectable
- ✅ Return date correctly shows as 2027
- ✅ No errors or weird behavior

---

### **TC-28: Leap Year** (Future Test - 2028)
**What Was Fixed**: Leap year dates work correctly

**Steps**:
1. When testing in 2028, set **Pickup Date**: **Feb 28, 2028**
2. Set **Return Date**: **Feb 29, 2028**

**Expected Result**:
- ✅ Feb 29 should be selectable
- ✅ Calendar should show 29 days in February 2028

---

## 🎯 TEST SUITE 6: CALENDAR WIDGET

### **Visual Calendar Range**
**What Was Fixed**: Calendar now shows correct date range

**Steps**:
1. Open **New Booking** screen
2. Look at the calendar widget (not the picker, the inline calendar)
3. Try to scroll to previous months
4. Try to scroll to future months

**Expected Result**:
- ✅ Can scroll back to **1 year ago**
- ✅ Can scroll forward to **1 year ahead**
- ✅ Cannot scroll beyond these boundaries
- ✅ Dates outside range are grayed out

---

## 🚨 KNOWN LIMITATIONS (Cannot Test Yet)

### ❌ **TC-03: Cooling "Before" Mode (Preparation)**
**Why Can't Test**: Settings UI for cooling mode toggle not implemented

**What It Would Do**:
- Cooling period would end BEFORE pickup (for prep/maintenance before rental)
- Formula: Cooling Date = Pickup Date - Duration
- Example: Pickup Feb 10, Duration 3 days → Cooling Feb 7

**To Test This**: You need to add the mode toggle in Settings first

---

### ❌ **TC-31: Mode Switch Ripple Effect**
**Why Can't Test**: No UI to switch modes

**What It Would Do**:
- When switching from After → Before: Cooling recalculates from (return+days) to (pickup-days)
- When switching from Before → After: Opposite recalculation

**To Test This**: Implement settings UI first

---

## 📊 QUICK TEST CHECKLIST

Copy this into your notes and check off as you test:

```
PICKUP DATE CONSTRAINTS:
□ Can select date 1 year ago (TC-05)
□ Can select date 1 year ahead (TC-04)
□ Cannot go beyond 1 year in either direction

RETURN DATE CONSTRAINTS:
□ Cannot select past dates (TC-09)
□ Return auto-updates when pickup moves ahead (TC-06)
□ Can select same day as pickup (TC-08)

COOLING PERIOD (AFTER MODE):
□ Auto-initializes on screen load (TC-02)
□ Updates when return date changes (TC-10)
□ Cannot manually set before return date (TC-12)
□ Can manually extend beyond auto-calculated date (TC-11)
□ Cascades when pickup→return→cooling (TC-14)

TIME VALIDATION:
□ Same-day return must be after pickup (TC-20-21)
□ Cannot select past time for today's pickup (TC-24)
□ Cannot select past time for today's return (TC-26)

EDGE CASES:
□ Year transition works (TC-27)
□ Leap year works (TC-28) - test in 2028

NOT TESTABLE YET:
□ Cooling "Before" mode - needs Settings UI
□ Mode switching - needs Settings UI
```

---

## 💡 TIPS FOR EFFECTIVE TESTING

1. **Test with Different Cooling Durations**: Try 0, 1, 3, 7, and 14 days
2. **Test Rapid Changes**: Quickly change dates back and forth
3. **Test Calendar vs Picker**: Use both the inline calendar and date pickers
4. **Check Console**: Look for any error messages in debug console
5. **Test Sales Mode Too**: Switch to Sales tab and test booked date
6. **Hot Reload**: After each code change, hot reload and retest

---

## 🐛 WHAT TO REPORT IF YOU FIND ISSUES

If something doesn't work as expected, report:

1. **What you did** (steps to reproduce)
2. **What you expected** (from this guide)
3. **What actually happened** (screenshot if possible)
4. **Error messages** (from console/screen)
5. **Test case ID** (e.g., TC-05)

---

## ✅ SUCCESS CRITERIA

Your implementation is working correctly if:

- ✅ All pickup/return date constraints match the specification
- ✅ Cooling period auto-calculates in "After" mode
- ✅ Return date never goes into the past
- ✅ Pickup→Return→Cooling cascade works
- ✅ Time validation prevents invalid same-day bookings
- ✅ Calendar shows correct 1-year range in both directions

**Overall Target**: 17/36 test cases should pass (70% of spec)
