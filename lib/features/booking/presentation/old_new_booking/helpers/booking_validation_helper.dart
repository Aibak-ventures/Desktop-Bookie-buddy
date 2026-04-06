import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

/// Validation result model that holds validation status and error messages
class BookingValidationResult {
  final bool isValid;
  final List<String> errors;
  final String? firstErrorField;
  final Map<String, String> fieldErrors;

  const BookingValidationResult({
    required this.isValid,
    this.errors = const [],
    this.firstErrorField,
    this.fieldErrors = const {},
  });

  factory BookingValidationResult.valid() =>
      const BookingValidationResult(isValid: true);

  factory BookingValidationResult.invalid({
    required List<String> errors,
    String? firstErrorField,
    Map<String, String> fieldErrors = const {},
  }) => BookingValidationResult(
    isValid: false,
    errors: errors,
    firstErrorField: firstErrorField,
    fieldErrors: fieldErrors,
  );
}

/// Helper class for validating booking form fields
class BookingValidationHelper {
  /// Validates the client details panel (Step 0)
  /// Required: Client name (only for bookings), Phone 1, Staff
  /// Optional: Phone 2, Place, Documents, Notes
  static BookingValidationResult validateClientDetailsPanel({
    required String clientName,
    required String phone1,
    required String phone2,
    required String address,
    required int documentsCount,
    required int? selectedStaffId,
    required String staffName,
    bool isSalesMode = false,
  }) {
    final errors = <String>[];
    String? firstErrorField;

    // Validate client name - only required for booking mode
    if (!isSalesMode && clientName.trim().isEmpty) {
      errors.add('Client name is required');
      firstErrorField ??= 'clientName';
    }

    // Validate phone 1
    if (phone1.trim().isEmpty) {
      errors.add('Phone number is required');
      firstErrorField ??= 'phone1';
    } else if (!_isValidPhoneNumber(phone1)) {
      errors.add('Please enter a valid phone number');
      firstErrorField ??= 'phone1';
    }

    // Validate phone 2 (optional but if provided, should be valid)
    if (phone2.trim().isNotEmpty && !_isValidPhoneNumber(phone2)) {
      errors.add('Please enter a valid phone 2 number');
      firstErrorField ??= 'phone2';
    }

    // Documents are optional - removed validation

    // Validate staff selection
    if (selectedStaffId == null && staffName.trim().isEmpty) {
      errors.add('Please select a staff member');
      firstErrorField ??= 'staff';
    }

    if (errors.isEmpty) {
      return BookingValidationResult.valid();
    }

    // Construct field errors map
    final fieldErrors = <String, String>{};
    if (!isSalesMode && clientName.trim().isEmpty) {
      fieldErrors['clientName'] = 'Name is required';
    }
    if (phone1.trim().isEmpty) {
      fieldErrors['phone1'] = 'Phone is required';
    } else if (!_isValidPhoneNumber(phone1)) {
      fieldErrors['phone1'] = 'Invalid phone';
    }
    if (selectedStaffId == null && staffName.trim().isEmpty) {
      fieldErrors['staff'] = 'Staff is required';
    }

    return BookingValidationResult.invalid(
      errors: errors,
      firstErrorField: firstErrorField,
      fieldErrors: fieldErrors,
    );
  }

  static String? phoneNumber(String? value, {bool isRequired = true}) {
    // If not required and empty, return null
    if (!isRequired && (value == null || value.trim().isEmpty)) {
      return null;
    }

    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    // Allow optional leading '+' and digits only, any length
    final phoneRegex = RegExp(r'^\+?\d+$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  /// Validates phone number format
  static bool _isValidPhoneNumber(String phone) {
    // Allow optional leading '+' and digits only, any length
    final phoneRegex = RegExp(r'^\+?\d+$');
    return phoneRegex.hasMatch(phone.trim());
  }

  /// Shows a validation error using the same toast as confirm button
  static void showValidationErrors(
    BuildContext context,
    BookingValidationResult result,
  ) {
    if (result.isValid) return;

    context.showSnackBar(
      result.errors.join(', '),
      isError: true,
      title: 'Validation Error',
    );
  }

  /// Shows a validation error dialog (alternative UI)
  static Future<void> showValidationErrorDialog(
    BuildContext context,
    BookingValidationResult result,
  ) async {
    if (result.isValid) return;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: Colors.red.shade600,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Required Fields Missing',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please fill in the following required fields:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            ...result.errors.map(
              (error) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.circle, size: 8, color: Colors.red.shade400),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(error, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF6132E4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
