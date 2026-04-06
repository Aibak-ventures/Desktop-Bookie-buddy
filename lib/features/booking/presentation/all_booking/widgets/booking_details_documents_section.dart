import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Documents section for [BookingDetailsDrawer].
class BookingDetailsDocumentsSection extends StatelessWidget {
  final BookingDetailsEntity booking;

  const BookingDetailsDocumentsSection({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    if (booking.documents.isEmpty) return const SizedBox.shrink();

    final totalCount = booking.documents.length;

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
          Row(
            children: [
              Icon(Icons.attach_file, size: 16, color: Colors.grey.shade700),
              const SizedBox(width: 8),
              Text(
                'Documents ($totalCount)',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: booking.documents.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final doc = booking.documents[index];
                final docUrl = doc is String
                    ? doc
                    : (doc is Map ? (doc['url'] ?? doc['file'] ?? '') : '');

                if (docUrl.isEmpty) return const SizedBox.shrink();

                final isPdf = docUrl.toLowerCase().endsWith('.pdf');

                return InkWell(
                  onTap: () => _showDocumentModal(
                      context, docUrl, index + 1, booking.client.phone1.toString()),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: isPdf
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.picture_as_pdf,
                                    size: 40, color: Colors.red.shade400),
                                const SizedBox(height: 4),
                                Text('PDF ${index + 1}',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade700)),
                              ],
                            )
                          : Image.network(
                              docUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image,
                                      size: 32, color: Colors.grey.shade400),
                                  const SizedBox(height: 4),
                                  Text('Doc ${index + 1}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDocumentModal(
      BuildContext context, String docUrl, int docNumber, String? phone) {
    final isPdf = docUrl.toLowerCase().endsWith('.pdf');

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.black87,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Stack(
            children: [
              Center(
                child: isPdf
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.picture_as_pdf,
                              size: 100, color: Colors.red.shade400),
                          const SizedBox(height: 16),
                          Text(
                            'PDF Document $docNumber',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Click download to view',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      )
                    : InkWell(
                        onTap: () async {
                          final uri = Uri.parse(docUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri,
                                mode: LaunchMode.externalApplication);
                          }
                        },
                        child: InteractiveViewer(
                          child: Image.network(
                            docUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.error,
                                      size: 64, color: Colors.white54),
                                  SizedBox(height: 16),
                                  Text('Failed to load image',
                                      style: TextStyle(color: Colors.white70)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Choose action'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.share),
                                  title: const Text('Share'),
                                  subtitle: const Text('Share via WhatsApp'),
                                  onTap: () async {
                                    Navigator.of(ctx).pop();
                                    final encoded =
                                        Uri.encodeComponent(docUrl);
                                    Uri uri;
                                    if (phone != null &&
                                        phone.trim().isNotEmpty) {
                                      final plain = phone.replaceAll(
                                          RegExp(r"[^0-9+]"), '');
                                      uri = Uri.parse(
                                          'https://wa.me/$plain?text=$encoded');
                                    } else {
                                      uri = Uri.parse(
                                          'https://api.whatsapp.com/send?text=$encoded');
                                    }
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    }
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.print),
                                  title: const Text('Print'),
                                  subtitle:
                                      const Text('Open document to print'),
                                  onTap: () async {
                                    Navigator.of(ctx).pop();
                                    final uri = Uri.parse(docUrl);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    }
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(ctx).pop(),
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.download,
                          color: Colors.white, size: 28),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black45,
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 28),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black45,
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
