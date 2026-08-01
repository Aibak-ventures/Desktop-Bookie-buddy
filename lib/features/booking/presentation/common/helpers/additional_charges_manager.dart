import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_form_validator.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Shared logic for adding and removing additional charges.
/// Used by both the New Booking and Edit Booking flows.
class AdditionalChargesManager {
  static Future<void> showAddChargeDialog(
    BuildContext context,
    ValueNotifier<List<AdditionalChargesEntity>> notifier,
  ) async {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    final result = await showDialog<AdditionalChargesEntity>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Charge', style: TextStyle(fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'e.g., Delivery',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '₹ ',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final amount = int.tryParse(amountController.text);

              final chargeResult =
                  BookingFormValidator.validateAdditionalCharge(
                    name: name,
                    amount: amount,
                  );
              if (!chargeResult.isValid) {
                context.showSnackBar(chargeResult.errors.first, isError: true);
                return;
              }

              Navigator.pop(
                context,
                AdditionalChargesEntity(name: name, amount: amount!),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6132E4),
            ),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (result != null) {
      final charges = List<AdditionalChargesEntity>.from(notifier.value);
      charges.add(result);
      notifier.value = charges;
    }
  }

  static void removeCharge(
    AdditionalChargesEntity charge,
    ValueNotifier<List<AdditionalChargesEntity>> notifier,
  ) {
    final charges = List<AdditionalChargesEntity>.from(notifier.value);
    charges.remove(charge);
    notifier.value = charges;
  }
}
