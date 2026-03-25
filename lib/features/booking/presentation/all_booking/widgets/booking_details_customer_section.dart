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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600)),
                    const SizedBox(height: 4),
                    Text(
                      booking.client.name,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone 1',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade600)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(phone1,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500)),
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.phone,
                              size: 16, color: AppColors.purple),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () async {
                            final uri = Uri.parse('tel:$phone1');
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () async {
                            final uri = Uri.parse(
                                'https://wa.me/${phone1.toWaPhone}');
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
                ),
              ),
            ],
          ),
          if (phone2 != null && phone2.isNotEmpty && phone2 != '0') ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: const SizedBox()),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone 2',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(phone2,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500)),
                          ),
                          IconButton(
                            icon: const Icon(LucideIcons.phone,
                                size: 16, color: AppColors.purple),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () async {
                              final uri = Uri.parse('tel:$phone2');
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () async {
                              final uri = Uri.parse(
                                  'https://wa.me/${phone2.toWaPhone}');
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
                  ),
                ),
              ],
            ),
          ],
          if (booking.address != null && booking.address!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600)),
                      const SizedBox(height: 4),
                      Text(
                        booking.address!,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
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
}
