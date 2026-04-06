import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
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
    final phone1 = _preferredPhone(
            booking.client.phone1E164, booking.client.phone1.toString()) ??
        booking.client.phone1.toString();
    final phone2 = _preferredPhone(
        booking.client.phone2E164, booking.client.phone2?.toString());
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
            children: [
              Expanded(
                child: _buildInfoCell(
                  label: 'Name',
                  value: booking.client.name,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPhoneCell(
                  label: 'Phone 1',
                  phone: phone1,
                ),
              ),
            ],
          ),
          if ((phone2 != null && phone2.isNotEmpty && phone2 != '0') ||
              hasPlace) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: phone2 != null && phone2.isNotEmpty && phone2 != '0'
                      ? _buildPhoneCell(
                          label: 'Phone 2',
                          phone: phone2,
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: hasPlace
                      ? _buildInfoCell(
                          label: 'Place',
                          value: place,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String? _preferredPhone(String? e164Phone, String? rawPhone) {
    final e164 = e164Phone?.trim();
    if (e164 != null && e164.isNotEmpty && e164 != '0') return e164;
    final raw = rawPhone?.trim();
    if (raw != null && raw.isNotEmpty && raw != '0') return raw;
    return null;
  }

  Widget _buildInfoCell({
    required String label,
    required String value,
  }) {
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

  Widget _buildPhoneCell({
    required String label,
    required String phone,
  }) {
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
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
                final uri = Uri.parse('tel:$phone');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () async {
                final uri = Uri.parse('https://wa.me/${phone.toWaPhone}');
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
