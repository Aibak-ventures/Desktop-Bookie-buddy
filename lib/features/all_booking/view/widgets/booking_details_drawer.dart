import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_booking_details_drawer/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_root.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_payment_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_modal.dart';
import 'package:bookie_buddy_web/features/edit_booking/view/edit_new_booking_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/src/di/injection.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/generate_booking_pdf.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetailsDrawer extends StatelessWidget {
  const BookingDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingDetailsDrawerCubit, BookingDetailsDrawerState>(
      builder: (context, drawerState) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          right: drawerState.isOpen ? 0 : -650,
          top: 0,
          bottom: 0,
          width: 470,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Text(
                        //   'Booking Details',
                        //   style: TextStyle(
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.grey.shade800,
                        //   ),
                        // ),
                        IconButton(
                          icon: const Icon(Icons.close),
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
        );
      },
    );
  }

  Widget _buildContent(
      BuildContext context, BookingDetailsDrawerState drawerState) {
    if (!drawerState.isOpen || drawerState.selectedBookingId == null) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
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
          loaded: (booking) => SingleChildScrollView(
            key: ValueKey('booking_${booking.id}_${booking.actualPaidAmount}'),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Booking ID
                _buildBookingId(booking),
                const SizedBox(height: 16),

                // Delivery Status
                _buildDeliveryStatus(context, booking),
                const SizedBox(height: 24),

                // Dates & time
                _buildDatesSection(booking),
                const SizedBox(height: 24),

                // Item details
                _buildItemDetails(booking),
                const SizedBox(height: 24),

                // Customer details
                _buildCustomerDetails(booking),
                const SizedBox(height: 24),

                // Payment details
                _buildPaymentDetails(booking),
                const SizedBox(height: 32),

                // Action buttons
                _buildActionButtons(context, booking),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookingId(BookingDetailsModel booking) {
    return Column(
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
    );
  }

  Widget _buildDeliveryStatus(
      BuildContext context, BookingDetailsModel booking) {
    final status = booking.deliveryStatus ?? DeliveryStatus.booked;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        PopupMenuButton<DeliveryStatus>(
          offset: const Offset(0, 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onSelected: (DeliveryStatus newStatus) {
            context.read<AllBookingBloc>().add(
                  AllBookingEvent.updateDeliveryStatus(
                    bookingId: booking.id,
                    deliveryStatus: newStatus,
                  ),
                );
            // Refresh the booking details
            context.read<BookingDetailsBloc>().add(
                  BookingDetailsEvent.fetchBookingDetails(booking.id),
                );
          },
          itemBuilder: (context) => DeliveryStatus.values.map((s) {
            return PopupMenuItem<DeliveryStatus>(
              value: s,
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: status.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  status.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: status.color,
                  ),
                ),
                const SizedBox(width: 8),
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
    );
  }

  Widget _buildDatesSection(BookingDetailsModel booking) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
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
                        color: Colors.black54,
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
                      _formatDate(booking.returnDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
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
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
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
                            'Size : ${item.variantAttribute}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        if (item.color != null)
                          Text(
                            'colour : ${item.color}',
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
            );
          }).toList(),
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
          _buildDetailRow('Name', booking.client.name),
          const SizedBox(height: 12),
          _buildPhoneRow('Phone 1', booking.client.phone1.toString()),
          if (booking.client.phone2 != null) ...[
            const SizedBox(height: 12),
            _buildPhoneRow('Phone 2', booking.client.phone2!.toString()),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
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
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
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
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child: Icon(Icons.phone, size: 18, color: Colors.grey.shade600),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () async {
                final uri = Uri.parse('https://wa.me/$phone');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child:
                  Icon(Icons.message, size: 18, color: Colors.green.shade600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentDetails(BookingDetailsModel booking) {
    final productTotal = booking.bookedItems.fold<int>(
      0,
      (sum, item) => sum + (item.amount ?? 0),
    );
    final additionalTotal = booking.additionalCharges?.fold<int>(
          0,
          (sum, charge) => sum + (charge.amount ?? 0),
        ) ??
        0;
    final totalAmount = booking.totalAmount;
    final paid = booking.actualPaidAmount;
    final balance = totalAmount - paid;

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
            'Payment details',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildPaymentRow('Security amount', '₹${booking.paidAmount}'),
          const SizedBox(height: 8),
          _buildPaymentRow('Product total', '₹$productTotal'),
          const SizedBox(height: 8),
          _buildPaymentRow('Additional amount', '₹$additionalTotal'),
          const Divider(height: 24),
          _buildPaymentRow('Total amount', '₹$totalAmount',
              isBold: true, fontSize: 15),
          const SizedBox(height: 8),
          _buildPaymentRow('Paid', '₹$paid',
              valueColor: Colors.green.shade600, fontSize: 14),
          const SizedBox(height: 8),
          _buildPaymentRow('Balance', '₹$balance',
              valueColor: Colors.red.shade600, isBold: true, fontSize: 15),
        ],
      ),
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

      String dateLabel;
      if (dateOnly == today) {
        dateLabel = 'Today';
      } else if (dateOnly == tomorrow) {
        dateLabel = 'Tomorrow';
      } else {
        dateLabel = dateStr.formatToUiDate();
      }

      final time =
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'pm' : 'am'}';
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

  Widget _buildActionButtons(
      BuildContext context, BookingDetailsModel booking) {
    return Row(
      children: [
        // Delete button
        _buildIconActionButton(
          context,
          icon: Icons.delete_outline,
          color: Colors.red,
          onTap: () async {
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
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
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
        ),
        const SizedBox(width: 12),
        // Edit button
        _buildIconActionButton(
          context,
          icon: Icons.edit_outlined,
          color: AppColors.purple,
          onTap: () async {
            // Close the drawer first
            context.read<BookingDetailsDrawerCubit>().closeDrawer();
            
            // Navigate to the new edit booking screen with necessary providers
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => ServiceBloc(repository: getIt()),
                    ),
                    BlocProvider(
                      create: (_) => ClientCubit(repository: getIt()),
                    ),
                    BlocProvider(
                      create: (_) => StaffSearchCubit(repository: getIt()),
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
            }
          },
        ),
        const SizedBox(width: 12),
        // Download Invoice
        _buildIconActionButton(
          context,
          icon: Icons.download_outlined,
          color: AppColors.purple,
          onTap: () async {
            final user = context.read<UserCubit>().state;
            final shop = user?.shopDetails;

            if (shop == null) {
              context.showSnackBar('Shop info not found', isError: true);
              return;
            }

            // Generate Booking PDF
            await GenerateBookingPdf.shareInvoice(
              context: context,
              bookingDetails: booking,
              shopDetails: shop,
            );
          },
        ),
        const Spacer(),
        // Mark as Completed button
        ElevatedButton(
          onPressed: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Mark as Completed'),
                content: const Text(
                    'Are you sure you want to mark this booking as completed?'),
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
            backgroundColor: AppColors.purple,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Mark as Completed',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
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
}
