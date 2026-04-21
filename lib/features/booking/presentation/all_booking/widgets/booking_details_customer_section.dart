import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/phone_number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

/// Customer details section for [BookingDetailsDrawer].
class BookingDetailsCustomerSection extends StatelessWidget {
  final BookingDetailsEntity booking;

  const BookingDetailsCustomerSection({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    // Prefer the raw integer phone (reliably updated by backend) over E.164
    // which the backend may not update when phone_1 changes.
    // Derive E.164 client-side for WhatsApp/tel links.
    final phone1Raw = booking.client.phone1;
    final phone2Raw = booking.client.phone2;

    final phone1Display = phone1Raw > 0
        ? phone1Raw.toString()
        : _phoneFromE164(booking.client.phone1E164);
    final phone2Display = (phone2Raw ?? 0) > 0
        ? phone2Raw.toString()
        : _phoneFromE164(booking.client.phone2E164);

    final place = booking.address?.trim();
    final hasPlace = place != null && place.isNotEmpty;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCell(
                      label: 'Name',
                      value: booking.client.name,
                    ),
                    if (hasPlace) ...[
                      const SizedBox(height: 12),
                      _buildInfoCell(label: 'Place', value: place),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (phone1Display != null)
                      _buildPhoneCell(label: 'Phone 1', phone: phone1Display),
                    if (phone1Display != null &&
                        phone2Display != null &&
                        phone2Display.isNotEmpty &&
                        phone2Display != '0')
                      const SizedBox(height: 12),
                    if (phone2Display != null &&
                        phone2Display.isNotEmpty &&
                        phone2Display != '0')
                      _buildPhoneCell(label: 'Phone 2', phone: phone2Display),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Extracts 10-digit phone from E.164 string (e.g. "+919745123456" → "9745123456").
  String? _phoneFromE164(String? e164) {
    if (e164 == null || e164.isEmpty) return null;
    var digits = e164.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.startsWith('91') && digits.length == 12)
      digits = digits.substring(2);
    return digits.isNotEmpty ? digits : null;
  }

  Widget _buildInfoCell({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildPhoneCell({required String label, required String phone}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                phone,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                LucideIcons.phone,
                size: 16,
                color: AppColors.purple,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                // Derive E.164 client-side — backend may not keep phone_1_e164 in sync.
                final e164 = toPhone1E164(phone) ?? phone;
                final uri = Uri.parse('tel:$e164');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () async {
                // Derive E.164 client-side for WhatsApp link.
                final e164 = toPhone1E164(phone) ?? phone;
                final waPhone = e164.startsWith('+') ? e164.substring(1) : e164;
                final uri = Uri.parse('https://wa.me/$waPhone');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child: SvgPicture.asset(
                AppAssets.whatsAppSvg,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  Colors.green.shade600,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
