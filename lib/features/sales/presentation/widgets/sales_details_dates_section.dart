import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:flutter/material.dart';

/// Sale date & time section for [SalesDetailsDrawer].
class SalesDetailsDatesSection extends StatelessWidget {
  final SaleDetailsEntity sale;

  const SalesDetailsDatesSection({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sale Date',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                sale.saleDate,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          if (sale.createdAt.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Time',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  _extractTime(sale.createdAt),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String _extractTime(String dateTimeStr) {
    try {
      final parts = dateTimeStr.split(' ');
      if (parts.length >= 2) {
        final timePart = parts[1];
        final timeComponents = timePart.split(':');
        if (timeComponents.length >= 2) {
          final hour = int.tryParse(timeComponents[0]) ?? 0;
          final minute = timeComponents[1];
          final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
          final period = hour >= 12 ? 'PM' : 'AM';
          return '${hour12.toString().padLeft(2, '0')}:$minute $period';
        }
      }
      return dateTimeStr;
    } catch (e) {
      return dateTimeStr;
    }
  }
}
