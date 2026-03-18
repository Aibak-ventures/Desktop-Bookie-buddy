import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

/// API paths for Tailor module endpoints
///
/// Handles all tailor-related operations including:
/// - CRUD operations for tailors
/// - Monthly summary and analytics
/// - Tailor management
class TailorEndpoints {
  const TailorEndpoints();

  static const _root = '${ApiConfig.v3}/tailored/';
  static const tailors = '${_root}tailor/';

  // Dynamic methods with ID parameters
  static String tailorById(int id) => '${tailors}$id/';
  static String tailorMonthlySummary(int tailorId) =>
      '${tailors}tailor-monthly-summary/$tailorId/';
  static String restoreDeletedTailor(int id) => '${tailors}restore/$id/';
}
