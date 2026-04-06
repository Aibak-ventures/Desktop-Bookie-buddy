import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

/// API paths for Customization Work endpoints (v4)
class CustomizationWorkEndpoints {
  static const _root = '${ApiConfig.v4}/customization-work/';

  // CRUD Operations
  static const customizationWorks =
      '${_root}customization-works/'; // List & Create
  static String customizationWorkDetail(int id) =>
      '${_root}customization-works/$id/'; // Get detail
  static String updateCustomizationWork(int id) =>
      '${_root}customization-works/$id/'; // Update
  static String deleteCustomizationWork(int id) =>
      '${_root}customization-works/$id/'; // Delete

  // Status Management
  static String markAsCompleted(int id) =>
      '${_root}customization-works/$id/mark-completed/';
  static String markAsPending(int id) =>
      '${_root}customization-works/$id/mark-pending/';
  static String markAsInProgress(int id) =>
      '${_root}customization-works/$id/mark-in-progress/';

  // Filtering & Search
  static const searchCustomizationWorks = '${_root}customization-works/search/';
  static const filterByStatus = '${_root}customization-works/filter-by-status/';
}
