import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Customer details section for [SalesDetailsDrawer].
class SalesDetailsCustomerSection extends StatelessWidget {
  final SaleDetailsEntity sale;

  const SalesDetailsCustomerSection({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final phone1 = _preferredPhone(
      sale.client?.phone1E164,
      sale.client?.phone1.toString(),
      fallback: sale.clientPhone?.toString(),
    );
    final phone2 = _preferredPhone(
      sale.client?.phone2E164,
      sale.client?.phone2?.toString(),
    );
    final name = sale.client?.name;

    if (phone1 == null || phone1.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer details',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          if (name != null && name.isNotEmpty) ...[
            _buildDetailRow('Name', name),
            const SizedBox(height: 12),
          ],
          _buildPhoneRow('Phone 1', phone1),
          if (phone2 != null && phone2.isNotEmpty && phone2 != '0') ...[
            const SizedBox(height: 12),
            _buildPhoneRow('Phone 2', phone2),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneRow(String label, String phone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        Row(
          children: [
            Text(
              phone,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () async {
                final uri = Uri.parse('tel:$phone');
                if (await canLaunchUrl(uri)) await launchUrl(uri);
              },
              child: Icon(Icons.phone, size: 18, color: Colors.grey.shade600),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () async {
                final uri =
                    Uri.parse('https://wa.me/${phone.toWaPhone}');
                if (await canLaunchUrl(uri)) await launchUrl(uri);
              },
              child: Icon(Icons.message, size: 18, color: Colors.green.shade600),
            ),
          ],
        ),
      ],
    );
  }

  String? _preferredPhone(
    String? e164Phone,
    String? rawPhone, {
    String? fallback,
  }) {
    for (final value in [e164Phone, rawPhone, fallback]) {
      final cleaned = value?.trim();
      if (cleaned != null && cleaned.isNotEmpty && cleaned != '0') {
        return cleaned;
      }
    }
    return null;
  }
}
