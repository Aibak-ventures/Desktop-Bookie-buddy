/// Enum representing all the named routes in the application.
///
/// This enum centralizes the definition of all navigation routes, providing
/// a single source of truth for paths and names. Each enum value corresponds
/// to a unique screen or feature in the app.
///
/// **Preferred navigation:** Use **named routes** for type-safe and clear navigation:
/// ```dart
/// // Navigate using a named route
/// context.goNamed(AppRoutes.home.name);
///
/// // Navigate with path parameters
/// context.goNamed(
///   AppRoutes.bookingDetails.name,
///   pathParameters: {'id': '42'},
/// );
///
/// // Navigate with query parameters
/// context.goNamed(
///   AppRoutes.products.name,
///   pathParameters: {'service_id': '5'},
///   queryParameters: {'sort': 'asc', 'filter': 'available'},
/// );
/// ```
///
/// **Optional navigation using paths:** Use the `path` getter if you need
/// to build URLs manually, for example with deep linking.
///
enum AppRoutes {
  // ----------------------
  // Authentication & Onboarding
  // ----------------------
  splash,
  onboarding,
  login,

  // ----------------------
  // Bottom Navigation
  // ----------------------
  home,
  searchGlobal,
  addExpense,
  editExpense,
  profile,

  // ----------------------
  // Bookings
  // ----------------------
  allBookings,
  completedBookings,
  bookingDetails,
  editBooking,
  addOldBookings,
  addBookingDate,
  addBookingSelectService,
  addBookingProductReview,
  addBookingDetails,
  addBookingPayment,
  addOldBookingSelectService,

  // ----------------------
  // Sales
  // ----------------------
  sales,
  saleDetails,
  addOrEditSales,
  addSalesSelectService,

  // ----------------------
  // Products
  // ----------------------
  products,
  productAdd,
  productDetails,
  stockManagement,
  selectProducts,
  productTransfer,
  productTransferHistory,
  productSelectAndTransfer,
  productTransferAnimation,
  productGrowth,
  productBookings,
  addCustomization,

  // ----------------------
  // Profile & Clients
  // ----------------------
  clients,
  profileMore,
  ledger,

  // ----------------------
  // Staff
  // ----------------------
  staffs,
  staffAnalytics,
  staffAnalyticsSales,
  staffAnalyticsBookings,
  staffsDeleted,

  // ----------------------
  // Settings & Password
  // ----------------------
  settings,
  manageSecretPassword,
  changeAccountPassword,
  changeSecretPassword,

  // ----------------------
  // Others / Misc
  // ----------------------
  aboutUs,
  contactAndSupport,
  successAnimation;

  // ----------------------
  // Base paths
  // ----------------------
  static const String _baseBookingsPath = '/bookings';
  static const String _baseSalesPath = '/sales';
  static const String _baseProductsPath = '/products';
  static const String _baseSettingsPath = '/settings';
  static const String _baseStaffsPath = '/staffs';
  static const String _basePasswordPath = '/password';

  // ----------------------
  // Path getter
  // ----------------------
  String get path => switch (this) {
    // Authentication
    splash => '/splash',
    onboarding => '/onboarding',
    login => '/login',

    // Bottom navigation
    home => '/home',
    searchGlobal => '/search-global',
    addExpense => '/add-expense',
    editExpense => '/edit-expense', // optional id for editing
    profile => '/profile',

    // Bookings
    allBookings => '$_baseBookingsPath/all',
    completedBookings => '$_baseBookingsPath/completed',
    bookingDetails => '$_baseBookingsPath/details/:id',
    editBooking => '$_baseBookingsPath/edit/:id',
    addOldBookings => '$_baseBookingsPath/add-old',
    addBookingDate => '$_baseBookingsPath/add/date-time',
    addBookingSelectService => '$_baseBookingsPath/add/select-service',
    addBookingProductReview => '$_baseBookingsPath/add/product-review',
    addBookingDetails => '$_baseBookingsPath/add/details',
    addBookingPayment => '$_baseBookingsPath/add/payment',
    addOldBookingSelectService => '$_baseBookingsPath/add-old/select-service',

    // Sales
    sales => '$_baseSalesPath',
    saleDetails => '$_baseSalesPath/details/:id',
    addOrEditSales => '$_baseSalesPath/add-or-edit', // optional id for edit
    addSalesSelectService => '$_baseSalesPath/select-service',

    // Products
    products => '$_baseProductsPath/list/:service_id',
    productAdd => '$_baseProductsPath/:service_id/add',
    productDetails => '$_baseProductsPath/:id/details',
    stockManagement => '$_baseProductsPath/stock-management',
    selectProducts => '$_baseProductsPath/:service_id/select',
    productTransfer => '$_baseProductsPath/transfer/:variant_id',
    productTransferHistory => '$_baseProductsPath/transfer-history',
    productSelectAndTransfer => '$_baseProductsPath/select-and-transfer',
    productTransferAnimation => '$_baseProductsPath/transfer-animation',
    productGrowth => '$_baseProductsPath/growth/:id',
    productBookings => '$_baseProductsPath/:id/bookings',
    addCustomization => '$_baseProductsPath/add-customization',

    // Profile & Clients
    clients => '/clients',
    profileMore => '/profile/more',
    ledger => '/ledger',

    // Staff
    staffs => '$_baseStaffsPath',
    staffAnalytics => '$_baseStaffsPath/:id/analytics',
    staffAnalyticsSales => '$_baseStaffsPath/:id/analytics/sales',
    staffAnalyticsBookings => '$_baseStaffsPath/:id/analytics/bookings',
    staffsDeleted => '$_baseStaffsPath/deleted',

    // Settings & Password
    settings => '$_baseSettingsPath',
    manageSecretPassword => '$_baseSettingsPath/manage-secret-password',
    changeAccountPassword => '$_basePasswordPath/change-account-password',
    changeSecretPassword => '$_basePasswordPath/change-secret-password',

    // Others
    aboutUs => '/about-us',
    contactAndSupport => '/contact-and-support',
    successAnimation => '/success',
  };

  // ----------------------
  // Build path with pathParameters & queryParameters
  // ----------------------
  String buildPath({
    Map<String, String>? pathParameters,
    Map<String, String>? queryParameters,
    String? customPath,
  }) {
    String resolved = customPath ?? path;
    if (pathParameters != null && pathParameters.isNotEmpty) {
      final regex = RegExp(r':([a-zA-Z_][a-zA-Z0-9_]*)');
      resolved = resolved.replaceAllMapped(regex, (m) {
        final key = m.group(1)!;
        final value = pathParameters[key];
        return value != null ? Uri.encodeComponent(value) : m.group(0)!;
      });
    }
    return Uri(path: resolved, queryParameters: queryParameters).toString();
  }
}
