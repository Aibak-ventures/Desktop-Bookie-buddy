# 🎯 QUICK TESTING REFERENCE CARD

## 🔧 BEFORE YOU START

**Set Cooling Period in Settings**: 3 days (or any value > 0)

---

## ⚡ 5-MINUTE SMOKE TEST

### Test 1: Past Pickup Date (30 seconds)
```
1. New Booking → Click "Pickup Date"
2. Scroll calendar BACK 3 months
3. Select a past date
✅ Should work (was broken before - only 30 days allowed)
```

### Test 2: Return Date Cannot Be Past (30 seconds)
```
1. Set Pickup = Last Week
2. Click "Return Date"  
3. Try to select yesterday
✅ Should be blocked/disabled
```

### Test 3: Pickup Push Logic (30 seconds)
```
1. Pickup = Feb 10, Return = Feb 12
2. Change Pickup → Feb 15
✅ Return should auto-change to Feb 16
```

### Test 4: Cooling Auto-Calc (30 seconds)
```
1. Check Cooling Period field shows a date
2. Change Return from Feb 11 → Feb 20
✅ Cooling should auto-update from Feb 14 → Feb 23
```

### Test 5: Same-Day Time Validation (1 minute)
```
1. Pickup Date = Today, Return Date = Today
2. Pickup Time = 2:00 PM
3. Return Time = 1:00 PM (before pickup)
✅ Should show error: "Return time must be after pickup time"
```

### Test 6: Calendar Range (1 minute)
```
1. Look at inline calendar
2. Scroll back as far as possible
3. Scroll forward as far as possible  
✅ Should stop at exactly 1 year in both directions
```

---

## 📊 EXPECTED BEHAVIORS

| Action | Before Fix | After Fix |
|--------|-----------|-----------|
| Pickup Date Range | Today ± 30 days | Today ± 365 days ✅ |
| Return Min Date | Pickup Date | Max(Today, Pickup) ✅ |
| Calendar Range | Today to +2 years | Today ±1 year ✅ |
| Cooling After Return | ✅ Working | ✅ Working |
| Cooling Before Pickup | ❌ Not Available | ❌ Not Available* |

*Requires Settings UI

---

## 🎨 VISUAL EXAMPLES

### Example 1: Ongoing Booking
```
Pickup:  Jan 10, 2026 (1 month ago) ✅ Allowed now
Return:  Feb 10, 2026 (today) ✅ Cannot be earlier than today
Cooling: Feb 13, 2026 (return + 3 days) ✅ Auto-calculated
```

### Example 2: Future Booking
```
Pickup:  May 15, 2026 (3 months ahead) ✅ Allowed
Return:  May 20, 2026 (5 days later) ✅ Any date ≥ pickup
Cooling: May 23, 2026 (return + 3 days) ✅ Auto-calculated
```

### Example 3: Cascade Effect
```
Before:  Pickup: Feb 1  → Return: Feb 5  → Cooling: Feb 8
Action:  Change Pickup to Feb 10 (after return)
After:   Pickup: Feb 10 → Return: Feb 11 → Cooling: Feb 14
                          ⬆️ auto!     ⬆️ auto!
```

---

## 🚨 COMMON ISSUES & SOLUTIONS

### Issue: "Calendar doesn't show past dates"
**Check**: Are you clicking the PICKUP date field? (Return date blocks past)

### Issue: "Cooling period is empty/blank"
**Check**: Did you set Cooling Period Days > 0 in Settings?

### Issue: "Return date jumps to tomorrow"
**Check**: This is correct if pickup is in the past (return cannot be past)

### Issue: "Time validation not working"
**Check**: Are pickup and return on the SAME DAY? (validation only for same day)

---

## 📝 TEST RESULT TEMPLATE

Copy and fill this out:

```
DATE: ______________________
TESTER: ____________________

PICKUP DATE CONSTRAINTS:
□ Past dates (1 year) work: _______________
□ Future dates (1 year) work: _____________
□ Cannot go beyond 1 year: ________________

RETURN DATE CONSTRAINTS:  
□ Blocks past dates: ______________________
□ Auto-updates on pickup push: ____________

COOLING PERIOD:
□ Auto-initializes: _______________________
□ Updates on return change: _______________
□ Manual adjustment works: ________________

TIME VALIDATION:
□ Same-day validation: ____________________
□ Past time blocked: ______________________

OVERALL: ✅ PASS / ❌ FAIL / ⚠️ PARTIAL

NOTES:
_________________________________________
_________________________________________
```

---

## 🎯 SUCCESS = ALL GREEN

| Feature | Status |
|---------|--------|
| Pickup ±365 days | ✅ |
| Return ≥ Today | ✅ |
| Cooling auto-calc | ✅ |
| Pickup→Return cascade | ✅ |
| Time validation | ✅ |
| Calendar range | ✅ |

**If all ✅ → Implementation is working correctly!**
