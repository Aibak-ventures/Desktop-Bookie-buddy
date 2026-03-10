/// Enum representing all business capabilities in the application.
///
/// This centralizes permission logic instead of scattering role checks across UI.
/// Each capability represents a specific business action a user can perform.
///
/// Usage:
/// ```dart
/// if (capabilities.can(AppCapability.viewLedger)) {
///   // Show ledger screen
/// }
/// ```
enum AppCapability {
  // ==================== Booking Capabilities ====================

  /// View list of pending bookings
  viewPendingBookings,

  /// View list of completed bookings (non-staff only)
  viewCompletedBookings,

  /// Edit existing bookings (may require password based on settings)
  editBooking,

  /// Delete bookings (may require password based on settings)
  deleteBooking,

  /// Make payments on bookings (may require password based on settings)
  makeBookingPayment,

  // ==================== Sales Capabilities ====================

  /// View and manage sales
  accessSales,

  // ==================== Customization Work Capabilities ====================

  /// View customization works (requires premium feature)
  viewCustomizationWork,

  /// Manage customization works (non-staff with premium feature)
  manageCustomizationWork,

  // ==================== Ledger Capabilities ====================

  /// View ledger (non-staff only, may require password)
  viewLedger,

  /// View monthly gross revenue
  viewMonthlyGross,

  // ==================== Stock Management Capabilities ====================

  /// View and manage stock/inventory
  manageStock,

  /// Check product availability
  checkProductAvailability,

  /// Edit products (may require password based on settings)
  editProduct,

  /// Delete products (may require password based on settings)
  deleteProduct,

  // ==================== Transfer Product Capabilities ====================

  /// Transfer products between shops (requires premium feature + password)
  transferProduct,

  /// View transfer history (non-staff with premium feature)
  viewTransferHistory,

  // ==================== Contact Management Capabilities ====================

  /// View and manage clients (non-staff only)
  manageClients,

  /// View and manage staff (non-staff only)
  manageStaff,

  /// View and manage tailors (non-staff with customization feature)
  manageTailors,

  // ==================== Reports & Analytics Capabilities ====================

  /// View all shop summary/performance (owner only with premium feature)
  viewAllShopSummary,

  /// View shop activity logs (non-staff only)
  viewActivityLogs,

  // ==================== Settings Capabilities ====================

  /// Access settings screen (non-staff only)
  accessSettings,

  /// Change account password (all users)
  changeAccountPassword,

  /// Change secret password (all users)
  changeSecretPassword,

  /// Manage password requirements (owner only)
  managePasswordSettings,

  /// Manage shop settings (non-staff)
  manageShopSettings,

  // ==================== Options Capabilities ====================

  /// Access more options menu (non-staff only)
  accessMoreOptions,

  viewProfileContactSection,

  viewProfileReportAndHistorySection,

  // ==================== Navigation Capabilities ====================

  /// Show FAB add button with custom work option
  accessCustomWork,
  showSendInvoiceToWhatsappButton,

  /// Allows viewing staff analytics and performance reports
  viewStaffAnalytics;

  /// Human-readable name for the capability
  String get displayName {
    switch (this) {
      case AppCapability.viewPendingBookings:
        return 'View Pending Bookings';
      case AppCapability.viewCompletedBookings:
        return 'View Completed Bookings';
      case AppCapability.editBooking:
        return 'Edit Booking';
      case AppCapability.deleteBooking:
        return 'Delete Booking';
      case AppCapability.makeBookingPayment:
        return 'Make Booking Payment';
      case AppCapability.accessSales:
        return 'View Sales';
      case AppCapability.viewCustomizationWork:
        return 'View Customization Work';
      case AppCapability.manageCustomizationWork:
        return 'Manage Customization Work';
      case AppCapability.viewLedger:
        return 'View Ledger';
      case AppCapability.viewMonthlyGross:
        return 'View Monthly Gross';
      case AppCapability.manageStock:
        return 'Manage Stock';
      case AppCapability.checkProductAvailability:
        return 'Check Product Availability';
      case AppCapability.editProduct:
        return 'Edit Product';
      case AppCapability.deleteProduct:
        return 'Delete Product';
      case AppCapability.transferProduct:
        return 'Transfer Product';
      case AppCapability.viewTransferHistory:
        return 'View Transfer History';
      case AppCapability.manageClients:
        return 'Manage Clients';
      case AppCapability.manageStaff:
        return 'Manage Staff';
      case AppCapability.manageTailors:
        return 'Manage Tailors';
      case AppCapability.viewAllShopSummary:
        return 'View All Shop Summary';
      case AppCapability.viewActivityLogs:
        return 'View Activity Logs';
      case AppCapability.accessSettings:
        return 'Access Settings';
      case AppCapability.changeAccountPassword:
        return 'Change Account Password';
      case AppCapability.changeSecretPassword:
        return 'Change Secret Password';
      case AppCapability.managePasswordSettings:
        return 'Manage Password Settings';
      case AppCapability.manageShopSettings:
        return 'Manage Shop Settings';
      case AppCapability.accessMoreOptions:
        return 'Access More Options';
      case AppCapability.accessCustomWork:
        return 'Show Custom Work in Add Button';
      case AppCapability.viewProfileContactSection:
        return 'View Profile Contact Section';
      case AppCapability.viewProfileReportAndHistorySection:
        return 'View Profile Report and History Section';
      case AppCapability.showSendInvoiceToWhatsappButton:
        return 'WhatsApp Messaging';
      case AppCapability.viewStaffAnalytics:
        return 'View Staff Analytics';
    }
  }
}