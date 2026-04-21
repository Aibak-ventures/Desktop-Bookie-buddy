import 'dart:io';

import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_booking_invoice_pdf_bytes_usecase.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_new_booking/pages/edit_new_booking_screen.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_edit_new_booking/pages/old_edit_new_booking_screen.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/selected_products_cubit/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/open_pdf_in_new_tab.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

/// Sticky action bar at the bottom of [BookingDetailsDrawer].
///
/// Contains delete, edit, download, complete actions and the invoice modal.
class BookingDetailsActionBar extends StatelessWidget {
  final BookingDetailsEntity booking;

  const BookingDetailsActionBar({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: _buildActionButtons(context),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final isCompleted = booking.bookingStatus == BookingStatus.completed;
    final isCancelled = booking.deliveryStatus == DeliveryStatus.cancelled;
    final isCompletedButCancelled = isCompleted && isCancelled;

    return Row(
      children: [
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
                        'Are you sure you want to delete this booking? This action cannot be undone.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
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
                  context.read<BookingDetailsDrawerCubit>().closeDrawer();

                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (_) =>
                                ServiceBloc(getShopServices: getIt()),
                          ),
                          BlocProvider(
                            create: (_) => ClientCubit(
                              getClients: getIt(),
                              getClientById: getIt(),
                            ),
                          ),
                          BlocProvider(
                            create: (_) => StaffSearchCubit(getStaffs: getIt()),
                          ),
                          BlocProvider(create: (_) => SelectedProductsCubit()),
                        ],
                        child: OldEditNewBookingScreen(
                          bookingDetails: booking,
                          bookingId: booking.id,
                        ),
                      ),
                    ),
                  );

                  if (result == true && context.mounted) {
                    context.read<BookingDetailsBloc>().add(
                      BookingDetailsEvent.fetchBookingDetails(booking.id),
                    );
                    final allBookingBloc = context.read<AllBookingBloc>();
                    allBookingBloc.state.mapOrNull(
                      loaded: (s) => allBookingBloc.add(
                        AllBookingEvent.loadBookings(
                          status: s.status,
                          startDate: s.startDate,
                          endDate: s.endDate,
                          searchQuery: s.searchQuery,
                        ),
                      ),
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
          onTap: () => _openInvoicePdf(context, booking),
        ),
        const SizedBox(width: 12),
        // Delete button for completed bookings
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
                        'Are you sure you want to delete this booking? This action cannot be undone.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
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
        if (isCompleted)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isCompletedButCancelled || isCancelled
                    ? const Color(0xFFFFEBEE)
                    : const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isCompletedButCancelled || isCancelled
                      ? const Color(0xFFF44336)
                      : const Color(0xFF4CAF50),
                ),
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
        if (!isCompleted) const Spacer(),
        // Mark as Completed / Complete cancelled work
        if (!isCompleted)
          ElevatedButton(
            onPressed: () async {
              if (!isCancelled) {
                final balance =
                    booking.totalAmount -
                    booking.actualPaidAmount -
                    (booking.discountAmount ?? 0);

                if (balance > 0) {
                  context.showSnackBar(
                    'Cannot mark as completed. Payment is still pending (Balance: ₹$balance).',
                    isError: true,
                  );
                  return;
                }

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
                  title: Text(
                    isCancelled
                        ? 'Complete Cancelled Work'
                        : 'Mark as Completed',
                  ),
                  content: Text(
                    isCancelled
                        ? 'Are you sure you want to complete this cancelled booking?'
                        : 'Are you sure you want to mark this booking as completed?',
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
              backgroundColor: isCancelled
                  ? Colors.red.shade600
                  : AppColors.purple,
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

  String _formatCompletionDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'Unknown date';
    try {
      final date = dateStr.parseToDateTime();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final dateOnly = DateTime(date.year, date.month, date.day);
      if (dateOnly == today) return 'Today';
      return dateStr.formatToUiDate();
    } catch (e) {
      return dateStr.formatToUiDate();
    }
  }

  Future<void> _openInvoicePdf(
    BuildContext context,
    BookingDetailsEntity booking,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final getBookingInvoice = getIt<GetBookingInvoicePdfBytesUseCase>();
      final pdfBytes = await getBookingInvoice(booking.id);
      if (context.mounted) Navigator.of(context).pop();

      if (kIsWeb) {
        openPdfInNewTab(pdfBytes, 'booking_invoice_${booking.id}.pdf');
        return;
      }

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/booking_invoice_${booking.id}.pdf');
      await file.writeAsBytes(pdfBytes);
      await OpenFile.open(file.path);
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        context.showSnackBar('Failed to open invoice: $e', isError: true);
      }
    }
  }
}
