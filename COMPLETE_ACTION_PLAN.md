# 🚀 COMPLETE DESKTOP APP FEATURE PARITY ACTION PLAN

**Date:** December 22, 2025  
**Goal:** Make Desktop App 100% Match Mobile App  
**Current Status:** 70% Parity → Target: 100%

---

## 🐛 PHASE 0: FIX CRITICAL BUGS (2-4 hours)

### Bug #1: ✅ FIXED - Expense Payment Method API Error
**Status:** FIXED - Code regenerated  
**Branch:** `feature/payment-method-premium-features`  
- payment_method field was already in model
- Regenerated freezed/json_serializable code
- **Action:** Push and merge this branch

### Bug #2: Cancel Booking Dialog Overflow  
**Priority:** 🔴 CRITICAL  
**Branch:** `feature/booking-cancellation-refund`  
**File:** Need to find where `CancelBookingDialog` is defined  
**Fix:** Wrap Column in SingleChildScrollView  
**Time:** 30 minutes

### Bug #3: Edit Booking Provider Missing
**Priority:** 🔴 CRITICAL  
**Branch:** `feature/remaining-features`  
**File:** `lib/features/booking_details/view/widgets/sections/booking_details_payment_details_section.dart`  
**Fix:** Provide UpdateBookingCubit when navigating  
**Time:** 15 minutes

---

## 📋 PHASE 1: PROFILE SCREEN MISSING OPTIONS (1 day)

Based on your request, these are missing from Profile:

### 1.1 Report & History Feature ⏰ 2 hours
**Missing Screen:** `ReportHistoryScreen` or similar  
**What it does:** View report history / analytics history  
**Where to add:** Profile screen as new tile  
**Implementation:**
```dart
CustomProfileTile(
  icon: Icons.history_outlined,
  title: 'Report & History',
  onTap: () => NavigatorX(context).push(const ReportHistoryScreen()),
),
```

### 1.2 More Options / Settings Expansion ⏰ 4 hours
**Current:** Settings tile exists but may be incomplete  
**Mobile has:** "More" section with expanded options  
**Need to add:**
- Report a Problem
- Help & FAQ
- Terms of Service
- Data Export
- Account Settings

**Implementation:**
```dart
CustomProfileExpansionTile(
  icon: Icons.more_horiz_outlined,
  title: 'More',
  cards: [
    CustomProfileExpandedCard(
      icon: Icon(Icons.report_problem_outlined),
      text: 'Report a\nProblem',
      color: Colors.orange,
      onTap: () => NavigatorX(context).push(const ReportProblemScreen()),
    ),
    CustomProfileExpandedCard(
      icon: Icon(Icons.help_outline),
      text: 'Help &\nFAQ',
      color: Colors.blue,
      onTap: () => NavigatorX(context).push(const HelpScreen()),
    ),
    // ... more options
  ],
),
```

### 1.3 Shop Performance (Premium Feature) ⏰ 8 hours
**Priority:** 🔴 CRITICAL - Main premium feature  
**Missing Screen:** `ShopPerformanceScreen`  
**Features:**
- Revenue analytics
- Booking trends
- Product performance
- Staff performance
- Monthly/yearly comparisons
- Charts & graphs
- Export reports

**Implementation Steps:**
1. Create ShopPerformanceScreen (4 hours)
2. Add analytics widgets (2 hours)
3. Integrate charts (fl_chart package) (2 hours)
4. Add premium check/paywall

**API Endpoints Needed:**
```
GET /api/v4/analytics/shop-performance/
GET /api/v4/analytics/revenue-trends/
GET /api/v4/analytics/product-performance/
GET /api/v4/analytics/staff-performance/
```

---

## 🎯 PHASE 2: CRITICAL MISSING FEATURES (3-4 weeks)

### 2.1 Custom Work Module ⏰ 2-3 weeks
**Priority:** 🔴 HIGHEST - 30% of users need this  
**Status:** Completely missing

**Screens to create (6):**
1. `CustomWorkListScreen` - List all custom work orders
2. `CustomWorkDetailsScreen` - View order details  
3. `CustomWorkDetailsConvertScreen` - Convert to booking
4. `AddCustomWorkProductListScreen` - Select products
5. `AddCustomWorkAddProductScreen` - Add custom products
6. `AddCustomWorkDetailsScreen` - Client & payment

**Features:**
- Create custom work orders for non-standard items
- Define custom measurements
- Material usage tracking  
- Convert custom work to regular booking
- Payment installments
- Tailor assignment
- Custom product pricing

**Navigation Addition:**
```dart
// Add to bottom navigation or profile
CustomProfileTile(
  icon: Icons.construction_outlined,
  title: 'Custom Work',
  onTap: () => NavigatorX(context).push(const CustomWorkListScreen()),
),
```

### 2.2 Tailor Management ⏰ 1-2 weeks
**Priority:** 🔴 CRITICAL - Required for custom work

**Screens to create (3):**
1. `TailorListScreen` - List active tailors
2. `TailorDeletedListScreen` - View archived tailors
3. `TailorMonthlySummaryScreen` - Workload tracking

**Features:**
- Add/edit/delete tailors
- Assign to custom work orders
- Track monthly workload
- Payment tracking
- Performance metrics

---

## 📱 PHASE 3: PROFILE SCREEN COMPLETE AUDIT

### Current Profile Options (Desktop):
✅ All Bookings → Upcoming & Completed  
✅ Ledger (with secret password)  
✅ Staff  
✅ Sales  
✅ Settings  
✅ Check Availability  
✅ Clients  
✅ Contact & Support  
✅ Privacy Policy  
✅ About Us  
✅ Logout  

### Missing Profile Options (From Mobile):
❌ Shop Performance (Premium)  
❌ Report & History  
❌ More Options (expansion tile)  
  ❌ Report a Problem  
  ❌ Help & FAQ  
  ❌ Terms of Service  
  ❌ Data Export  
❌ Transfer Product History  
❌ Shop Activity Log  
❌ Custom Work  
❌ Tailors  
❌ Change Password (commented out but exists)

### Profile Screen Implementation Plan:

```dart
Widget _buildProfileContent(BuildContext context, ShopRole shopRole) {
  return Column(
    children: [
      // EXISTING:
      CustomProfileExpansionTile(/* All Bookings */),
      if (!shopRole.isStaff) CustomProfileTile(/* Ledger */),
      CustomProfileTile(/* Staff */),
      CustomProfileTile(/* Sales */),
      
      // ADD: Custom Work
      CustomProfileTile(
        icon: Icons.construction_outlined,
        title: 'Custom Work',
        badge: _getCustomWorkCount(), // Show pending count
        onTap: () => NavigatorX(context).push(const CustomWorkListScreen()),
      ),
      
      // ADD: Tailors
      CustomProfileTile(
        icon: Icons.person_outline,
        title: 'Tailors',
        onTap: () => NavigatorX(context).push(const TailorListScreen()),
      ),
      
      // ADD: Shop Performance (Premium)
      CustomProfileTile(
        icon: Icons.analytics_outlined,
        title: 'Shop Performance',
        trailing: PremiumBadge(), // Show premium badge
        onTap: () {
          if (user.isPremium) {
            NavigatorX(context).push(const ShopPerformanceScreen());
          } else {
            showPremiumDialog(context);
          }
        },
      ),
      
      // EXISTING:
      CustomProfileTile(/* Settings */),
      CustomProfileTile(/* Check Availability */),
      CustomProfileTile(/* Clients */),
      
      // ADD: Report & History
      CustomProfileTile(
        icon: Icons.history_outlined,
        title: 'Report & History',
        onTap: () => NavigatorX(context).push(const ReportHistoryScreen()),
      ),
      
      // ADD: More Options
      CustomProfileExpansionTile(
        icon: Icons.more_horiz_outlined,
        title: 'More',
        cards: [
          CustomProfileExpandedCard(
            icon: Icon(Icons.report_problem_outlined),
            text: 'Report a\nProblem',
            color: Colors.orange,
            onTap: () => NavigatorX(context).push(const ReportProblemScreen()),
          ),
          CustomProfileExpandedCard(
            icon: Icon(Icons.help_outline),
            text: 'Help &\nFAQ',
            color: Colors.blue,
            onTap: () => NavigatorX(context).push(const HelpScreen()),
          ),
          CustomProfileExpandedCard(
            icon: Icon(Icons.description_outlined),
            text: 'Terms of\nService',
            color: Colors.purple,
            onTap: () => _openTermsOfService(context),
          ),
          CustomProfileExpandedCard(
            icon: Icon(Icons.download_outlined),
            text: 'Export\nData',
            color: Colors.green,
            onTap: () => _showDataExportDialog(context),
          ),
          CustomProfileExpandedCard(
            icon: Icon(Icons.transfer_within_a_station_outlined),
            text: 'Transfer\nHistory',
            color: Colors.teal,
            onTap: () => NavigatorX(context).push(const TransferHistoryScreen()),
          ),
          CustomProfileExpandedCard(
            icon: Icon(Icons.history_outlined),
            text: 'Activity\nLog',
            color: Colors.indigo,
            onTap: () => NavigatorX(context).push(const ActivityLogScreen()),
          ),
        ],
      ),
      
      // EXISTING:
      CustomProfileTile(/* Contact & Support */),
      CustomProfileTile(/* Privacy Policy */),
      CustomProfileTile(/* About Us */),
      
      // UNCOMMENT: Change Password
      CustomProfileExpansionTile(
        icon: Icons.key_outlined,
        title: 'Change password',
        cards: [
          CustomProfileExpandedCard(/* Account Password */),
          CustomProfileExpandedCard(/* Secret Password */),
        ],
      ),
      
      CustomElevatedButton(/* Logout */),
    ],
  );
}
```

---

## 🎨 PHASE 4: ADDITIONAL MISSING SCREENS (1 week)

### 4.1 Report & History Screens ⏰ 1 day
**Screens:**
- `ReportHistoryScreen` - View past reports
- `GenerateReportScreen` - Create new reports  
**Features:**
- Report history list
- Filter by date/type
- Download/export reports
- Share reports

### 4.2 Report Problem Screen ⏰ 4 hours
**Screen:** `ReportProblemScreen`  
**Features:**
- Problem description form
- Category selection
- Attach screenshots
- Submit to support
- Track report status

### 4.3 Help & FAQ Screen ⏰ 2 hours
**Screen:** `HelpScreen`  
**Features:**
- FAQ accordion
- Search functionality
- Video tutorials links
- Contact support button

### 4.4 Transfer History Screen ⏰ 1 day
**Screen:** `TransferProductHistoryScreen`  
**Features:**
- Product transfer audit trail
- Filter by shop/product/date
- Export to CSV

### 4.5 Activity Log Screen ⏰ 1 day
**Screen:** `ShopActivityLogScreen`  
**Features:**
- User action audit trail
- Filter by user/action/date
- Export logs

---

## 🔧 PHASE 5: REFUND MANAGEMENT UI (4 hours)

**Currently:** Refund API exists, but no UI to view refunds  
**Need:** Refund history section in booking details

**Implementation:**
```dart
// Add to booking_details_payment_details_section.dart

// After payments section:
if (booking.refunds.isNotEmpty) ...[
  const Divider(),
  ExpansionTile(
    title: Row(
      children: [
        Expanded(
          child: Text(
            'Refunds (${booking.refunds.length})',
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
        Text(
          '-${booking.totalRefunded.toCurrency()}',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.red,
          ),
        ),
      ],
    ),
    children: booking.refunds.map((refund) => 
      ListTile(
        leading: Icon(Icons.money_off, color: AppColors.red),
        title: Text(refund.reason ?? 'Refund'),
        subtitle: Text(refund.createdAt ?? ''),
        trailing: Text(
          '-${refund.amount.toCurrency()}',
          style: TextStyle(
            color: AppColors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ).toList(),
  ),
],

// Show refundable balance
if ((booking.refundableBalance ?? 0) > 0)
  _PaymentDetailsRow(
    title: 'Refundable balance',
    amount: booking.refundableBalance ?? 0,
    color: AppColors.green,
  ),
```

---

## 🏪 PHASE 6: MULTI-SHOP HANDLING (1 week)

**Currently:** API supports shops (`X-Active-Shop-ID: 7`), no UI  
**Need:** Shop selector and current shop display

### Implementation:

1. **Create ShopSelectorCubit** (2 hours)
2. **Add Shop Selector Widget** (2 hours)
   - Dropdown in app bar
   - Current shop display
   - Shop list dialog
   - Switch shop functionality

3. **Update API calls** (4 hours)
   - Ensure all API calls include shop header
   - Handle shop switching
   - Clear cache on shop switch

4. **Add Shop Management Screen** (2 days)
   - List all shops
   - Add/edit/delete shops
   - Shop settings
   - Staff assignments per shop

---

## 🎭 PHASE 7: COSTUME SERVICE CONDITIONS (TBD)

**Need Clarification:** What are the specific costume service conditions?

Possible scenarios:
- Size/height matching restrictions?
- Same person can't book same costume twice?
- Special return date rules?
- Cooling period differences?
- Availability calculation changes?

**Please specify what costume service conditions you need implemented!**

---

## 📦 PHASE 8: PACKAGE UPDATES & CLEANUP (1 day)

### Remove Incompatible Packages:
- [ ] Remove `in_app_update` (mobile-only)
- [ ] Delete `lib/features/in_app_update/` folder
- [ ] Delete `lib/utils/http_test_screen.dart`
- [ ] Delete `lib/utils/network_test_screen.dart`

### Add Desktop Packages:
- [ ] `window_manager` - Window size control
- [ ] `drift` - SQLite database
- [ ] `sqlite3_flutter_libs` - SQLite libraries  
- [ ] `tray_manager` - System tray
- [ ] `hotkey_manager` - Keyboard shortcuts
- [ ] `printing` - Native print dialogs

### Window Management (CRITICAL):
```dart
// main.dart
await windowManager.ensureInitialized();

WindowOptions windowOptions = const WindowOptions(
  size: Size(1200, 800),           // Default
  minimumSize: Size(800, 600),     // CRITICAL
  center: true,
);

windowManager.waitUntilReadyToShow(windowOptions, () async {
  await windowManager.show();
  await windowManager.focus();
});
```

---

## 🗓️ IMPLEMENTATION TIMELINE

### Week 1 (Dec 22-28, 2025):
**Day 1-2: Bug Fixes & Quick Wins**
- [ ] Fix Bug #2: Cancel dialog scroll
- [ ] Fix Bug #3: Edit booking provider
- [ ] Push and merge all 3 bug fix branches
- [ ] Add window management
- [ ] Package cleanup
- [ ] Add Report & History tile
- [ ] Add More Options expansion
- [ ] Start Shop Performance screen

**Day 3-5: Shop Performance (Premium)**
- [ ] Complete Shop Performance screen
- [ ] Add charts and analytics
- [ ] Test premium paywall
- [ ] Add to profile

**Day 6-7: Profile Screen Completion**
- [ ] Add all missing profile tiles
- [ ] Uncomment Change Password
- [ ] Add Report a Problem screen
- [ ] Add Help & FAQ screen
- [ ] Test full profile navigation

### Week 2 (Dec 29 - Jan 4, 2026):
**Refund UI & Multi-Shop**
- [ ] Add refund history UI
- [ ] Implement shop selector
- [ ] Add shop management
- [ ] Test shop switching

**Start Custom Work Module**
- [ ] Create CustomWorkListScreen
- [ ] Create CustomWorkDetailsScreen
- [ ] Set up models and BLoC

### Week 3-4 (Jan 5-18, 2026):
**Complete Custom Work Module**
- [ ] All 6 custom work screens
- [ ] API integration
- [ ] Testing
- [ ] Documentation

### Week 5-6 (Jan 19 - Feb 1, 2026):
**Tailor Management**
- [ ] All 3 tailor screens
- [ ] Workload tracking
- [ ] Payment tracking
- [ ] Integration with custom work

### Week 7 (Feb 2-8, 2026):
**Audit Screens**
- [ ] Transfer History
- [ ] Activity Log
- [ ] Report History
- [ ] Export functionality

### Week 8 (Feb 9-15, 2026):
**Final Testing & Polish**
- [ ] Full regression testing
- [ ] Fix any discovered bugs
- [ ] Performance optimization
- [ ] Documentation
- [ ] Deployment

---

## ✅ SUCCESS CRITERIA

- [ ] All 3 bugs fixed
- [ ] Profile screen matches mobile 100%
- [ ] Shop Performance premium feature working
- [ ] Custom Work module complete
- [ ] Tailor management complete
- [ ] Multi-shop handling working
- [ ] All audit/history screens done
- [ ] Refund UI implemented
- [ ] Window management working
- [ ] Package cleanup done
- [ ] Desktop optimizations complete
- [ ] 95%+ feature parity achieved

---

## 🚀 IMMEDIATE ACTIONS (TODAY)

1. **Fix Bug #2** - Cancel dialog scroll (30 min)
2. **Fix Bug #3** - Edit booking provider (15 min)
3. **Create branches** for each phase
4. **Add window management** (2 hours)
5. **Start Shop Performance screen** (4 hours)

---

## 📞 QUESTIONS NEEDED:

1. **Costume Service Conditions:** What are the specific rules?
2. **Priority Order:** Which features are most urgent after bugs?
3. **Custom Work:** Do you have API documentation for custom work endpoints?
4. **Shop Performance:** What specific metrics/charts do you want?
5. **Report & History:** What types of reports does mobile generate?

---

**Total Estimated Time:** 6-8 weeks  
**Current Progress:** 70% → Target: 100%  
**Next Review:** End of Week 1

Let's start! 🚀
