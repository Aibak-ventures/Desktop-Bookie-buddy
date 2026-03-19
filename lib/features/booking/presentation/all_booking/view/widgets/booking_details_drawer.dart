import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/dialogs/cancel_booking_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_new_booking/pages/edit_new_booking_screen.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/selected_products_cubit/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_payment_history_cubit/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/dialogs/show_booking_details_add_payment_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/components/booking_payment_history_tile.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/core/common/models/user_model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:bookie_buddy_web/features/booking/domain/usecases/send_invoice_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_invoice_pdf_bytes_usecase.dart';
import 'package:bookie_buddy_web/utils/open_pdf_in_new_tab.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class BookingDetailsDrawer extends StatelessWidget {
  const BookingDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserModel?>(
      listenWhen: (previous, current) {
        // Listen when shop changes (user switches shop)
        if (previous == null || current == null) return false;
        return previous.shopDetails.id != current.shopDetails.id;
      },
      listener: (context, user) {
        // Close the drawer when shop is switched
        context.read<BookingDetailsDrawerCubit>().closeDrawer();
      },
      child: BlocBuilder<BookingDetailsDrawerCubit, BookingDetailsDrawerState>(
        builder: (context, drawerState) {
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            right: drawerState.isOpen ? 0 : -650,
            top: 0,
            bottom: 0,
            width: 470,
            child: GestureDetector(
              // Consume all taps inside the drawer to prevent closing
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // Do nothing - just consume the tap
              },
              child: Material(
                elevation: 16,
                shadowColor: Colors.black.withOpacity(0.3),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(-4, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Close button header
                      Container(
                        // padding: const EdgeInsets.symmetric(
                        //     horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_right, size: 28),
                              onPressed: () {
                                context
                                    .read<BookingDetailsDrawerCubit>()
                                    .closeDrawer();
                              },
                              tooltip: 'Close',
                              color: Colors.grey.shade600,
                              hoverColor: Colors.grey.shade100,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _buildContent(context, drawerState),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, BookingDetailsDrawerState drawerState) {
    if (!drawerState.isOpen || drawerState.selectedBookingId == null) {
      return const SizedBox.shrink();
    }

    return BlocListener<BookingDetailsBloc, BookingDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: (booking) {
            // Collapse payment history when a new booking is loaded
            final paymentHistoryCubit =
                context.read<BookingDetailsPaymentHistoryCubit>();
            if (paymentHistoryCubit.isExpanded) {
              paymentHistoryCubit.collapsePaymentHistory();
            }
          },
          success: (message, didPop, needRefresh) {
            // Show success message using context extension
            context.showSnackBar(message);

            // Reload booking details to show updated status without closing drawer
            if (needRefresh && drawerState.selectedBookingId != null) {
              context.read<BookingDetailsBloc>().add(
                    BookingDetailsEvent.fetchBookingDetails(
                      drawerState.selectedBookingId!,
                    ),
                  );

              // Refresh the main booking list to reflect status/payment changes
              final allBookingBloc = context.read<AllBookingBloc>();
              allBookingBloc.state.mapOrNull(
                loaded: (s) => allBookingBloc.add(AllBookingEvent.loadBookings(
                  status: s.status,
                  startDate: s.startDate,
                  endDate: s.endDate,
                  searchQuery: s.searchQuery,
                )),
              );
            }
          },
          failed: (error) {
            context.showSnackBar(error, isError: true);
          },
        );
      },
      child: BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => SizedBox(
              height: context.mediaQueryHeight(0.8),
              child: const Center(
                child: SpinKitFadingCircle(color: AppColors.purple),
              ),
            ),
            error: (error) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomErrorWidget(
                errorText: error,
                onRetry: () {
                  if (drawerState.selectedBookingId != null) {
                    context.read<BookingDetailsBloc>().add(
                          BookingDetailsEvent.fetchBookingDetails(
                            drawerState.selectedBookingId!,
                          ),
                        );
                  }
                },
              ),
            ),
            loaded: (booking) => Column(
              key:
                  ValueKey('booking_${booking.id}_${booking.actualPaidAmount}'),
              children: [
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Booking ID, Staff Name and Delivery Status
                        _buildBookingHeaderSection(context, booking),
                        const SizedBox(height: 20),

                        // Dates & time
                        _buildDatesSection(booking),
                        const SizedBox(height: 20),

                        // Item details
                        _buildItemDetails(booking),
                        const SizedBox(height: 20),

                        // Customer details
                        _buildCustomerDetails(booking),
                        const SizedBox(height: 20),

                        // Payment details
                        _buildPaymentDetails(booking, context),
                        const SizedBox(height: 20),

                        // Documents (moved below payments)
                        _buildDocumentsSection(booking),
                        const SizedBox(height: 80), // Space for sticky buttons
                      ],
                    ),
                  ),
                ),
                // Sticky action buttons at bottom
                _buildStickyActionBar(context, booking),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookingHeaderSection(
      BuildContext context, BookingDetailsModel booking) {
    final status = booking.deliveryStatus;
    // Check if booking is completed - disable delivery status editing
    // Cancelled bookings can still change delivery status ONLY if no refunds exist
    final isCompleted = booking.bookingStatus == BookingStatus.completed;
    final isCancelled = booking.deliveryStatus == DeliveryStatus.cancelled;
    // Check if booking has refund amounts - if yes, don't allow status change from cancelled
    final hasRefundAmounts =
        booking.totalRefunded > 0 || booking.refunds.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT — Booking ID
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Booking Id',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '#${booking.invoiceId}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        // CENTER — Staff
        if (booking.staffName != null)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Staff',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  booking.staffName!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.purple,
                  ),
                ),
              ],
            ),
          ),

        // RIGHT — Delivery Status
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Delivery status',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              // Show non-interactive status badge for completed bookings
              // OR for cancelled bookings that have refund amounts
              if (isCompleted || (isCancelled && hasRefundAmounts))
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: status.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          status.name,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: status.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              else
                PopupMenuButton<DeliveryStatus>(
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (newStatus) async {
                    // Show confirmation dialog for cancellation
                    if (newStatus == DeliveryStatus.cancelled) {
                      // Check security password before allowing cancellation
                      performSecureActionDialog(
                        context,
                        SecretPasswordLocations.bookingDelete,
                        onSuccess: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) => CancelBookingDialog(
                              maxRefundAmount: booking.actualPaidAmount,
                              onCancel: () => Navigator.of(dialogContext).pop(),
                              onConfirm: (refundAmount, paymentMethod) {
                                Navigator.of(dialogContext).pop();
                                context.read<BookingDetailsBloc>().add(
                                      BookingDetailsEvent.cancelBooking(
                                        bookingId: booking.id,
                                        refundAmount: refundAmount,
                                        paymentMethod: paymentMethod,
                                      ),
                                    );
                              },
                            ),
                          );
                        },
                      );
                      return;
                    }

                    // Show confirmation dialog for all other status changes
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Change Delivery Status'),
                        content: Text(
                          'Are you sure you want to change delivery status to "${newStatus.name}"?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true && context.mounted) {
                      // Update via BookingDetailsBloc for optimistic UI update
                      context.read<BookingDetailsBloc>().add(
                            BookingDetailsEvent.updateDeliveryStatus(
                              bookingId: booking.id,
                              deliveryStatus: newStatus,
                            ),
                          );
                      // Also update the booking list
                      context.read<AllBookingBloc>().add(
                            AllBookingEvent.updateDeliveryStatus(
                              bookingId: booking.id,
                              deliveryStatus: newStatus,
                            ),
                          );
                    }
                  },
                  itemBuilder: (context) => DeliveryStatus.values.map((s) {
                    return PopupMenuItem(
                      value: s,
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: s.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            s.name,
                            style: TextStyle(
                              fontSize: 13,
                              color: s.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: status.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            status.name,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: status.color,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: status.color,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDatesSection(BookingDetailsModel booking) {
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
            'Dates & time',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pickup',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDateTime(booking.pickupDate),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Booked on',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(booking.bookedDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Return',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDateTime(booking.returnDate),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Available from',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatAvailableFromDate(booking),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsSection(BookingDetailsModel booking) {
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
          // Horizontal scrollable list of document images
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: booking.documents.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final doc = booking.documents[index];
                // Documents can be either strings (URLs) or maps
                final docUrl = doc is String
                    ? doc
                    : (doc is Map ? (doc['url'] ?? doc['file'] ?? '') : '');

                if (docUrl.isEmpty) return const SizedBox.shrink();

                final isPdf = docUrl.toLowerCase().endsWith('.pdf');

                return InkWell(
                  onTap: () => _showDocumentModal(context, docUrl, index + 1,
                      booking.client.phone1.toString()),
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
              // Document content
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
                          // Download image when clicked
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
              // Top action buttons
              Positioned(
                top: 16,
                right: 16,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Download / Actions button -> show share/print modal
                    IconButton(
                      onPressed: () async {
                        // Show a small dialog with Share / Print options
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
                                    // If phone available use wa.me with number, else open generic share URL
                                    final encoded = Uri.encodeComponent(docUrl);
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
                    // Close button
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

  Widget _buildItemDetails(BookingDetailsModel booking) {
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
            'Item details',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...booking.bookedItems.map((item) {
            // Determine specifications label based on mainServiceType
            // Uses variantAttributeLabel: 'Size' for dress/costume, 'Serial Number' for gadget, 'Model' for vehicle, 'Variant' for others
            String specsLabel = item.mainServiceType.variantAttributeLabel;
            // if (item.mainServiceType != null) {
            //   switch (item.mainServiceType) {
            //     case MainServiceType.tailoring:
            //       specsLabel = 'Measurements';
            //       break;
            //     case MainServiceType.laundry:
            //       specsLabel = 'Specifications';
            //       break;
            //     case MainServiceType.rental:
            //       specsLabel = 'Size';
            //       break;
            //     default:
            //       specsLabel = 'Size';
            //   }
            // }

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product image
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: item.image != null && item.image!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item.image!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.image,
                                          color: Colors.grey.shade400),
                                ),
                              )
                            : Icon(Icons.image, color: Colors.grey.shade400),
                      ),
                      const SizedBox(width: 12),
                      // Product details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (item.variantAttribute != null)
                              Text(
                                '$specsLabel : ${item.variantAttribute}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            if (item.color != null)
                              Text(
                                'Colour : ${item.color}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            if (item.category != null &&
                                item.category!.isNotEmpty)
                              Text(
                                '${item.mainServiceType.categoryFieldLabel} : ${item.category}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                          ],
                        ),
                      ),
                      // Quantity and Price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Qty : ${item.quantity}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '₹ ${item.amount}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Show measurements if they exist
                  if (item.measurements.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 8),
                    Text(
                      'Customization Measurements:',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: item.measurements.map((measurement) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            '${measurement.name}: ${measurement.value}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
          // Show location details once if ANY item is a vehicle (MOVED OUTSIDE LOOP)
          if (booking.bookedItems
                  .any((item) => item.mainServiceType.isVehicle) &&
              (booking.otherDetails.locationStart != null ||
                  booking.otherDetails.locationFrom != null ||
                  booking.otherDetails.locationTo != null)) ...[
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Location Details',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (booking.otherDetails.locationStart != null) ...[
                    Row(
                      children: [
                        Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            booking.otherDetails.locationStart!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                  if (booking.otherDetails.locationFrom != null) ...[
                    Row(
                      children: [
                        Text(
                          'From',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            booking.otherDetails.locationFrom!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                  if (booking.otherDetails.locationTo != null) ...[
                    Row(
                      children: [
                        Text(
                          'To',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            booking.otherDetails.locationTo!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
          // Show notes if they exist - only once at the end
          if (booking.description != null &&
              booking.description!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.note_alt_outlined,
                        size: 16,
                        color: Colors.amber.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    booking.description!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomerDetails(BookingDetailsModel booking) {
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
          // First row: Name and Phone 1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      booking.client.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone 1',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            booking.client.phone1.toString(),
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
                            final uri = Uri.parse(
                                'tel:${booking.client.phone1.toString()}');
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () async {
                            final uri = Uri.parse(
                                'https://wa.me/${booking.client.phone1.toString()}');
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
          // Second row: Phone 2 if exists
          if (booking.client.phone2 != null) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: const SizedBox()), // Empty space for alignment
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone 2',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              booking.client.phone2!.toString(),
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
                              final uri = Uri.parse(
                                  'tel:${booking.client.phone2!.toString()}');
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () async {
                              final uri = Uri.parse(
                                  'https://wa.me/${booking.client.phone2!.toString()}');
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
          // Address if exists
          if (booking.address != null && booking.address!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        booking.address!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
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

  Widget _buildPaymentDetails(
      BookingDetailsModel booking, BuildContext context) {
    final productTotal = booking.bookedItems.fold<int>(
      0,
      (sum, item) => sum + (item.amount),
    );
    final additionalTotal = booking.additionalCharges.fold<int>(
      0,
      (sum, charge) => sum + (charge.amount ?? 0),
    );
    final totalAmount = booking.totalAmount;
    final paid = booking.actualPaidAmount;
    final discount = booking.discountAmount ?? 0;
    final balance = totalAmount - paid - discount;
    final securityAmount = booking.securityAmount ?? 0;
    final isPaymentCompleted = balance <= 0;

    // Check if booking is cancelled or completed
    final isCancelled = booking.deliveryStatus == DeliveryStatus.cancelled;
    final isCompleted = booking.bookingStatus == BookingStatus.completed;
    // final isBookingFinalized = isCancelled || isCompleted;

    return Column(
      children: [
        Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  // Show status badge or payment button
                  if (isCancelled)
                    // Cancelled button style
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.red.shade400, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.cancel,
                              color: Colors.red.shade700, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Cancelled',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (isCompleted || isPaymentCompleted)
                    // Completed button style
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle,
                              color: Colors.green.shade700, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ElevatedButton.icon(
                      onPressed: () {
                        performSecureActionDialog(
                          context,
                          SecretPasswordLocations.bookingPayment,
                          onSuccess: () {
                            showBookingDetailsAddPaymentDialog(
                              context: context,
                              id: booking.id,
                              balanceAmount: balance,
                            );
                          },
                        );
                      },
                      icon: const Icon(LucideIcons.plus, size: 16),
                      label: const Text('Add Payment'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        textStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              _buildPaymentRow('Product total', '₹$productTotal'),
              const SizedBox(height: 8),
              // Only show if discount exists
              if (discount > 0) ...[
                _buildPaymentRow('Discount', '- ₹$discount',
                    valueColor: Colors.black87),
                const SizedBox(height: 8),
              ],
              // Only show security amount if it exists
              if (securityAmount > 0) ...[
                _buildPaymentRow('Security amount', '₹$securityAmount'),
                const SizedBox(height: 8),
              ],
              // Expandable additional amount if it exists
              if (additionalTotal > 0) ...[
                Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: const EdgeInsets.only(left: 16, bottom: 8),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Additional amount',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '₹$additionalTotal',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    children: booking.additionalCharges.map((charge) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              charge.name ?? 'Charge',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              '₹${charge.amount ?? 0}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              const Divider(height: 24),
              _buildPaymentRow('Total amount', '₹$totalAmount',
                  isBold: true, fontSize: 15),
              const SizedBox(height: 8),
              _buildPaymentRow('Paid', '₹$paid',
                  valueColor: Colors.green.shade600,
                  isBold: true,
                  fontSize: 14),
              const SizedBox(height: 8),
              _buildPaymentRow('Balance', '₹$balance',
                  valueColor:
                      balance > 0 ? Colors.red.shade600 : Colors.green.shade600,
                  isBold: true,
                  fontSize: 15),

              // Show refund details for cancelled bookings
              if (isCancelled) ...[
                const SizedBox(height: 12),
                const Divider(height: 24),
                const SizedBox(height: 8),

                // Show refunded amount if any
                if (booking.totalRefunded > 0)
                  _buildPaymentRow(
                    'Refunded',
                    '₹${booking.totalRefunded.toInt()}',
                    valueColor: Colors.green.shade600,
                    fontSize: 13,
                  ),

                // Calculate deducted amount: what was paid but not refunded
                // This is the penalty/cancellation charge
                if (booking.totalRefunded < paid) ...[
                  if (booking.totalRefunded > 0) const SizedBox(height: 6),
                  _buildPaymentRow(
                    'Deducted',
                    '₹${(paid - booking.totalRefunded.toInt())}',
                    valueColor: Colors.red.shade600,
                    fontSize: 13,
                  ),
                ],

                // Show remaining refundable balance
                // if (booking.refundableBalance > 0) ...[
                //   const SizedBox(height: 6),
                //   _buildPaymentRow(
                //     'Remaining balance',
                //     '₹${booking.refundableBalance.toInt()}',
                //     valueColor: AppColors.purple,
                //     isBold: true,
                //     fontSize: 14,
                //   ),
                // ],
              ],

              const SizedBox(height: 12),
              // Payment history toggle
              TextButton.icon(
                onPressed: () {
                  final paymentHistoryCubit =
                      context.read<BookingDetailsPaymentHistoryCubit>();
                  if (paymentHistoryCubit.isExpanded) {
                    paymentHistoryCubit.collapsePaymentHistory();
                  } else {
                    // Use payments data from booking details API (no separate API call)
                    paymentHistoryCubit.showPaymentHistory(
                      booking.payments,
                      booking.refunds,
                    );
                  }
                },
                label: const Text('Payment history'),
                iconAlignment: IconAlignment.end,
                icon: BlocBuilder<BookingDetailsPaymentHistoryCubit,
                    BookingDetailsPaymentHistoryState>(
                  builder: (context, state) {
                    final bool showExpandedIcon = state.maybeWhen(
                      orElse: () => false,
                      expanded: (_) => true,
                      loading: () => true,
                    );
                    return Icon(
                      showExpandedIcon
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Payment history display
        BlocConsumer<BookingDetailsPaymentHistoryCubit,
            BookingDetailsPaymentHistoryState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (error) => context.showSnackBar(error, isError: true),
            );
          },
          builder: (context, state) => state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => BookingPaymentHistoryTile(
              paymentHistory: const [],
              refunds: booking.refunds,
              isLoading: true,
            ),
            expanded: (paymentHistory) => BookingPaymentHistoryTile(
              paymentHistory: paymentHistory,
              refunds: booking.refunds,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentRow(String label, String value,
      {bool isBold = false, Color? valueColor, double? fontSize}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize ?? 13,
            color: Colors.black87,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize ?? 13,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }

  String _formatDateTime(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'N/A';
    try {
      final date = dateStr.parseToDateTime();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));
      final dateOnly = DateTime(date.year, date.month, date.day);

      // Check if time is 23:59 or 00:00 - if so, don't show time
      final isEndOfDay = (date.hour == 23 && date.minute == 59);
      final isStartOfDay = (date.hour == 0 && date.minute == 0);

      String dateLabel;
      if (dateOnly == today) {
        dateLabel = 'Today';
      } else if (dateOnly == tomorrow) {
        dateLabel = 'Tomorrow';
      } else {
        dateLabel = dateStr.formatToUiDate();
      }

      // Don't show time if it's 23:59 or 00:00
      if (isEndOfDay || isStartOfDay) {
        return dateLabel;
      }

      // Convert to 12-hour format
      final hour12 =
          date.hour == 0 ? 12 : (date.hour > 12 ? date.hour - 12 : date.hour);
      final period = date.hour >= 12 ? 'PM' : 'AM';
      final time =
          '${hour12.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
      return '$dateLabel, $time';
    } catch (e) {
      return dateStr;
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'N/A';
    try {
      return dateStr.formatToUiDate();
    } catch (e) {
      return dateStr;
    }
  }

  String _formatAvailableFromDate(BookingDetailsModel booking) {
    final coolingDateStr = booking.coolingPeriodDate;
    if (coolingDateStr == null || coolingDateStr.isEmpty) {
      // Fallback to return date if no cooling period
      if (booking.returnDate.isNotEmpty) {
        try {
          final returnDate = booking.returnDate.parseToDateTime();
          return returnDate.add(const Duration(days: 1)).format();
        } catch (e) {
          return 'N/A';
        }
      }
      return 'N/A';
    }
    try {
      final coolingDate = coolingDateStr.parseToDateTime();
      // Available from next day of cooling date
      final availableDate = coolingDate.add(const Duration(days: 1));
      return availableDate.format();
    } catch (e) {
      return coolingDateStr;
    }
  }

  Widget _buildActionButtons(
      BuildContext context, BookingDetailsModel booking) {
    // Check if booking is completed or cancelled
    final isCompleted = booking.bookingStatus == BookingStatus.completed;
    final isCancelled = booking.deliveryStatus == DeliveryStatus.cancelled;
    // Check if completed but delivery status is cancelled
    final isCompletedButCancelled = isCompleted && isCancelled;

    return Row(
      children: [
        // Only show delete and edit buttons if booking is not completed or cancelled
        if (!isCompleted && !isCancelled) ...[
          // Delete button
          _buildIconActionButton(
            context,
            icon: Icons.delete_outline,
            color: Colors.red,
            onTap: () async {
              performSecureActionDialog(
                context,
                SecretPasswordLocations.bookingDelete,
                onSuccess: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Booking'),
                      content: const Text(
                          'Are you sure you want to delete this booking? This action cannot be undone.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style:
                              TextButton.styleFrom(foregroundColor: Colors.red),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true && context.mounted) {
                    context.read<AllBookingBloc>().add(
                          AllBookingEvent.deleteBooking(bookingId: booking.id),
                        );
                    context.read<BookingDetailsDrawerCubit>().closeDrawer();
                  }
                },
              );
            },
          ),
          const SizedBox(width: 12),
          // Edit button
          _buildIconActionButton(
            context,
            icon: Icons.edit_outlined,
            color: AppColors.purple,
            onTap: () async {
              performSecureActionDialog(
                context,
                SecretPasswordLocations.bookingEdit,
                onSuccess: () async {
                  // Close the drawer first
                  context.read<BookingDetailsDrawerCubit>().closeDrawer();

                  // Navigate to the new edit booking screen with necessary providers
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (_) =>
                                ServiceBloc(getShopServices: getIt()),
                          ),
                          BlocProvider(
                            create: (_) => ClientCubit(getClients: getIt()),
                          ),
                          BlocProvider(
                            create: (_) => StaffSearchCubit(getStaffs: getIt()),
                          ),
                          BlocProvider(
                            create: (_) => SelectedProductsCubit(),
                          ),
                        ],
                        child: EditNewBookingScreen(
                          bookingDetails: booking,
                        ),
                      ),
                    ),
                  );

                  // Refresh booking details if edited
                  if (result == true && context.mounted) {
                    context.read<BookingDetailsBloc>().add(
                          BookingDetailsEvent.fetchBookingDetails(booking.id),
                        );
                    // Reload list preserving current tab/filters
                    final allBookingBloc = context.read<AllBookingBloc>();
                    allBookingBloc.state.mapOrNull(
                      loaded: (s) =>
                          allBookingBloc.add(AllBookingEvent.loadBookings(
                        status: s.status,
                        startDate: s.startDate,
                        endDate: s.endDate,
                        searchQuery: s.searchQuery,
                      )),
                    );
                  }
                },
              );
            },
          ),
          const SizedBox(width: 12),
        ],
        // Download Invoice (always visible)
        _buildIconActionButton(
          context,
          icon: Icons.download_outlined,
          color: AppColors.purple,
          onTap: () => _showInvoiceActionsModal(context, booking),
        ),
        const SizedBox(width: 12),
        // Delete button for completed bookings (icon style, on left side)
        if (isCompleted)
          _buildIconActionButton(
            context,
            icon: Icons.delete_outline,
            color: Colors.red,
            onTap: () async {
              performSecureActionDialog(
                context,
                SecretPasswordLocations.bookingDelete,
                onSuccess: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Booking'),
                      content: const Text(
                          'Are you sure you want to delete this booking? This action cannot be undone.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style:
                              TextButton.styleFrom(foregroundColor: Colors.red),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true && context.mounted) {
                    context.read<AllBookingBloc>().add(
                          AllBookingEvent.deleteBooking(bookingId: booking.id),
                        );
                    context.read<BookingDetailsDrawerCubit>().closeDrawer();
                  }
                },
              );
            },
          ),
        if (isCompleted) const SizedBox(width: 12),
        // Status bar - show red "Booking Cancelled" if completed but delivery cancelled
        // Use Expanded to take remaining space
        if (isCompleted || isCancelled)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                // If completed but cancelled delivery, show red. Otherwise green for completed, red for cancelled
                color: isCompletedButCancelled || isCancelled
                    ? const Color(0xFFFFEBEE)
                    : const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: isCompletedButCancelled || isCancelled
                        ? const Color(0xFFF44336)
                        : const Color(0xFF4CAF50)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isCompletedButCancelled || isCancelled
                        ? Icons.cancel
                        : Icons.check_circle,
                    color: isCompletedButCancelled || isCancelled
                        ? const Color(0xFFF44336)
                        : const Color(0xFF4CAF50),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isCompletedButCancelled
                            ? 'Booking Cancelled'
                            : (isCompleted ? 'Completed' : 'Cancelled'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isCompletedButCancelled || isCancelled
                              ? const Color(0xFFC62828)
                              : const Color(0xFF2E7D32),
                        ),
                      ),
                      if (booking.bookingCompletedDate != null)
                        Text(
                          'on ${_formatCompletionDate(booking.bookingCompletedDate)}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade700,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        if (!isCompleted && !isCancelled) const Spacer(),
        // Mark as Completed button for active bookings
        // OR Complete cancelled work button for cancelled bookings
        if (!isCompleted)
          ElevatedButton(
            onPressed: () async {
              // For cancelled bookings, no validation needed - just complete
              if (!isCancelled) {
                // Calculate balance to check payment status
                final balance = booking.totalAmount -
                    booking.actualPaidAmount -
                    (booking.discountAmount ?? 0);

                // Validation 1: Check if payment is pending
                if (balance > 0) {
                  context.showSnackBar(
                    'Cannot mark as completed. Payment is still pending (Balance: ₹$balance).',
                    isError: true,
                  );
                  return;
                }

                // Validation 2: Check if delivery status is "Returned"
                if (booking.deliveryStatus != DeliveryStatus.returned) {
                  context.showSnackBar(
                    'Cannot mark as completed. Booking must be marked as "Returned" first.',
                    isError: true,
                  );
                  return;
                }
              }

              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(isCancelled
                      ? 'Complete Cancelled Work'
                      : 'Mark as Completed'),
                  content: Text(isCancelled
                      ? 'Are you sure you want to complete this cancelled booking?'
                      : 'Are you sure you want to mark this booking as completed?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              );

              if (confirm == true && context.mounted) {
                context.read<AllBookingBloc>().add(
                      AllBookingEvent.markAsCompleted(
                        bookingId: booking.id,
                        currentStatus: booking.deliveryStatus,
                      ),
                    );
                context.read<BookingDetailsDrawerCubit>().closeDrawer();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isCancelled ? Colors.red.shade600 : AppColors.purple,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              isCancelled ? 'Complete cancelled work' : 'Mark as Completed',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }

  // Sticky action bar at the bottom
  Widget _buildStickyActionBar(
      BuildContext context, BookingDetailsModel booking) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: _buildActionButtons(context, booking),
    );
  }

  Widget _buildIconActionButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  void _showInvoiceActionsModal(
      BuildContext context, BookingDetailsModel booking) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invoice'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.message, color: Color(0xFF25D366)),
              title: const Text('Send via WhatsApp'),
              subtitle: Text(
                'Send invoice PDF to ${booking.client.phone1}',
              ),
              onTap: () async {
                Navigator.of(ctx).pop();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
                try {
                  // Backend sends the invoice PDF directly to the customer's
                  // WhatsApp number via WhatsApp Business API
                  await getIt<SendInvoiceUseCase>()(booking.id, true);
                  if (context.mounted) Navigator.of(context).pop();
                  if (context.mounted) {
                    context.showSnackBar(
                      'Invoice sent to ${booking.client.phone1} via WhatsApp ✓',
                    );
                  }
                } catch (e) {
                  if (context.mounted) Navigator.of(context).pop();
                  if (context.mounted) {
                    context.showSnackBar('Failed to send invoice: $e',
                        isError: true);
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.print, color: AppColors.purple),
              title: const Text('Print'),
              subtitle: const Text('Download and open invoice PDF'),
              onTap: () async {
                Navigator.of(ctx).pop();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
                try {
                  final pdfBytes =
                      await getIt<GetInvoicePdfBytesUseCase>()(booking.id);
                  if (context.mounted) Navigator.of(context).pop();
                  if (kIsWeb) {
                    openPdfInNewTab(
                        pdfBytes, 'booking_invoice_${booking.id}.pdf');
                  } else {
                    final dir = await getTemporaryDirectory();
                    final file =
                        File('${dir.path}/booking_invoice_${booking.id}.pdf');
                    await file.writeAsBytes(pdfBytes);
                    await OpenFile.open(file.path);
                  }
                } catch (e) {
                  if (context.mounted) Navigator.of(context).pop();
                  if (context.mounted) {
                    context.showSnackBar('Failed to open invoice: $e',
                        isError: true);
                  }
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
  }

  String _formatCompletionDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'Unknown date';

    try {
      final date = dateStr.parseToDateTime();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final dateOnly = DateTime(date.year, date.month, date.day);

      if (dateOnly == today) {
        return 'Today';
      } else {
        return dateStr.formatToUiDate();
      }
    } catch (e) {
      return dateStr.formatToUiDate();
    }
  }
}
