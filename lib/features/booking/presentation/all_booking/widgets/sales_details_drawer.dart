import 'dart:io';

import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_invoice_pdf_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/send_sale_invoice_usecase.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/core/common/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/save_sales_cubit/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/sales_details_bloc/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/sales_details_drawer_cubit/sales_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_sales_bloc/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/pages/edit_sales_screen.dart';
import 'package:bookie_buddy_web/utils/open_pdf_in_new_tab_stub.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SalesDetailsDrawer extends StatelessWidget {
  const SalesDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserModel?>(
      listenWhen: (previous, current) {
        // Only trigger when shop actually changes
        if (previous == null || current == null) return false;
        return previous.shopDetails.id != current.shopDetails.id;
      },
      listener: (context, user) {
        // Close the drawer when shop is switched
        context.read<SalesDetailsDrawerCubit>().closeDrawer();
      },
      child: BlocListener<SalesDetailsBloc, SalesDetailsState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (message, didPop, needRefresh) {
              context.showSnackBar(message);
              if (needRefresh) {
                context
                    .read<AllSalesBloc>()
                    .add(const AllSalesEvent.loadSales());
              }
              if (didPop) {
                context.read<SalesDetailsDrawerCubit>().closeDrawer();
              }
            },
            error: (message) {
              context.showSnackBar(message, isError: true);
            },
          );
        },
        child: BlocBuilder<SalesDetailsDrawerCubit, SalesDetailsDrawerState>(
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
                                      .read<SalesDetailsDrawerCubit>()
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
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, SalesDetailsDrawerState drawerState) {
    if (!drawerState.isOpen || drawerState.selectedSaleId == null) {
      return const SizedBox.shrink();
    }

    // Trigger fetch if not loaded? Or handled by listener?
    // Usually ui triggers fetch on open, or BlocBuilder handles it if event fired on open.
    // In BookingDetailsDrawer, CustomErrorWidget retry fires event.
    // Ideally, when drawer opens, we fire logic.
    // But here we rely on BlocBuilder.
    // We should assume the event was added when opening (or via listener).

    return BlocBuilder<SalesDetailsBloc, SalesDetailsState>(
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
                if (drawerState.selectedSaleId != null) {
                  context.read<SalesDetailsBloc>().add(
                        SalesDetailsEvent.fetchSaleDetails(
                          drawerState.selectedSaleId!,
                        ),
                      );
                }
              },
            ),
          ),
          loaded: (sale) => Column(
            key: ValueKey('sale_${sale.id}'),
            children: [
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sale ID & Status
                      _buildSaleHeader(sale),
                      const SizedBox(height: 16),

                      // Dates
                      _buildDatesSection(sale),
                      const SizedBox(height: 24),

                      // Item details
                      _buildItemDetails(sale),
                      const SizedBox(height: 24),

                      // Customer details - show if client exists OR if client_phone exists
                      if (sale.client != null ||
                          (sale.clientPhone != null &&
                              sale.clientPhone.toString().isNotEmpty)) ...[
                        _buildCustomerDetails(sale),
                        const SizedBox(height: 24),
                      ],

                      // Notes section (if description exists)
                      if (sale.description.isNotEmpty) ...[
                        _buildNotesSection(sale),
                        const SizedBox(height: 24),
                      ],

                      // Staff name section (if staff exists)
                      if (sale.staffName != null &&
                          sale.staffName!.isNotEmpty) ...[
                        _buildStaffSection(sale),
                        const SizedBox(height: 24),
                      ],

                      // Payment details
                      _buildPaymentDetails(sale),
                      const SizedBox(height: 80), // Space for sticky buttons
                    ],
                  ),
                ),
              ),
              // Sticky action buttons at bottom
              _buildStickyActionBar(context, sale),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSaleHeader(SaleDetailsModel sale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Invoice ID',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '#${sale.invoiceId}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildDatesSection(SaleDetailsModel sale) {
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
          Row(
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
                      'Time', // Changed from 'Created At' to 'Time'
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
        ],
      ),
    );
  }

  // Helper method to extract time from datetime string
  String _extractTime(String dateTimeStr) {
    try {
      // Assuming format like "31-12-2025 17:30:45" or similar
      final parts = dateTimeStr.split(' ');
      if (parts.length >= 2) {
        final timePart = parts[1];
        final timeComponents = timePart.split(':');
        if (timeComponents.length >= 2) {
          final hour = int.tryParse(timeComponents[0]) ?? 0;
          final minute = timeComponents[1];
          // Convert to 12-hour format
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

  Widget _buildItemDetails(SaleDetailsModel sale) {
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
          ...sale.products.map((item) {
            // Determine specifications label based on mainServiceType (same as booking details)
            // String specsLabel =
            //     item.mainServiceType?.quantityFieldLabel ?? 'Specifications';

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
                        // Show specifications based on main service type
                        if (item.mainServiceType == MainServiceType.dress) ...[
                          // For dress: show Size and Color
                          if (item.variantAttribute != null &&
                              item.variantAttribute!.isNotEmpty)
                            Text(
                              'Size : ${item.variantAttribute}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          if (item.color != null && item.color!.isNotEmpty)
                            Text(
                              'Colour : ${item.color}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ] else if (item.mainServiceType ==
                            MainServiceType.vehicle) ...[
                          // For vehicle: show Model and Category (Brand)
                          if (item.model != null && item.model!.isNotEmpty)
                            Text(
                              'Model : ${item.model}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          if (item.category != null &&
                              item.category!.isNotEmpty)
                            Text(
                              'Brand : ${item.category}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ] else if (item.mainServiceType ==
                            MainServiceType.gadgets) ...[
                          // For gadget: show Serial Number (variant) and Color
                          if (item.variantAttribute != null &&
                              item.variantAttribute!.isNotEmpty)
                            Text(
                              'Serial Number : ${item.variantAttribute}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          if (item.color != null && item.color!.isNotEmpty)
                            Text(
                              'Colour : ${item.color}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ] else if (item.mainServiceType ==
                            MainServiceType.equipment) ...[
                          // For equipment: show Category
                          if (item.category != null &&
                              item.category!.isNotEmpty)
                            Text(
                              'Category : ${item.category}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ] else ...[
                          // For others: show Category and Color
                          if (item.category != null &&
                              item.category!.isNotEmpty)
                            Text(
                              'Category : ${item.category}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          if (item.color != null && item.color!.isNotEmpty)
                            Text(
                              'Colour : ${item.color}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ],
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
                        '₹ ${item.subtotal}',
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

  Widget _buildCustomerDetails(SaleDetailsModel sale) {
    // Get phone number from client or clientPhone field
    final phone1 = _preferredPhone(
      sale.client?.phone1E164,
      sale.client?.phone1?.toString(),
      fallback: sale.clientPhone?.toString(),
    );
    final phone2 = _preferredPhone(
        sale.client?.phone2E164, sale.client?.phone2?.toString());
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
          // Only show name if it exists (not walk-in customer)
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
                final uri = Uri.parse('https://wa.me/${_waPhone(phone)}');
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

  String? _preferredPhone(String? e164Phone, String? rawPhone,
      {String? fallback}) {
    final candidates = [e164Phone, rawPhone, fallback];
    for (final value in candidates) {
      final cleaned = value?.trim();
      if (cleaned != null && cleaned.isNotEmpty && cleaned != '0') {
        return cleaned;
      }
    }
    return null;
  }

  String _waPhone(String phone) => phone.replaceAll(RegExp(r'[^0-9]'), '');

  Widget _buildNotesSection(SaleDetailsModel sale) {
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
          Row(
            children: [
              Icon(Icons.note_outlined, size: 16, color: Colors.grey.shade700),
              const SizedBox(width: 8),
              const Text(
                'Notes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            sale.description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade800,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffSection(SaleDetailsModel sale) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, size: 20, color: Colors.grey.shade700),
              const SizedBox(width: 12),
              const Text(
                'Staff',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            sale.staffName!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(SaleDetailsModel sale) {
    // Calculate subtotal from items
    final subtotal =
        sale.products.fold<int>(0, (sum, item) => sum + item.subtotal);

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
          const SizedBox(height: 12),
          // Payment Method row
          Row(
            children: [
              Text(
                'Payment method: ',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                sale.paymentMethod.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Subtotal from items
          _buildPaymentRow('Subtotal', '₹$subtotal'),
          const SizedBox(height: 8),
          // Discount
          if (sale.discountAmount > 0) ...[
            _buildPaymentRow('Discount', '- ₹${sale.discountAmount}',
                valueColor: Colors.red.shade600),
            const SizedBox(height: 8),
          ],
          const Divider(height: 24),
          _buildPaymentRow('Grand Total', '₹${sale.paidAmount}',
              isBold: true, fontSize: 15),
          // Note: Balance row removed as requested
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

  Widget _buildStickyActionBar(BuildContext context, SaleDetailsModel sale) {
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
      child: Row(
        children: [
          // Delete button
          _buildIconActionButton(
            context,
            icon: Icons.delete_outline,
            color: Colors.red,
            onTap: () {
              performSecureActionDialog(
                context,
                SecretPasswordLocations.bookingDelete,
                onSuccess: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Sale'),
                      content: const Text(
                          'Are you sure you want to delete this sale? This action cannot be undone.'),
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
                    context.read<SalesDetailsBloc>().add(
                          SalesDetailsEvent.deleteSale(sale.id),
                        );
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
            onTap: () {
              performSecureActionDialog(
                context,
                SecretPasswordLocations.bookingEdit,
                onSuccess: () async {
                  // Navigate to EditSalesScreen with sale details
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => SaveSalesCubit(
                            createSaleUseCase: getIt.get(),
                            updateSaleUseCase: getIt.get()),
                        child: EditSalesScreen(
                          saleDetails: sale,
                        ),
                      ),
                    ),
                  );

                  // If sale was updated, refresh the sales list
                  if (result == true && context.mounted) {
                    context
                        .read<AllSalesBloc>()
                        .add(const AllSalesEvent.loadSales());
                    // Refresh the drawer content
                    context.read<SalesDetailsBloc>().add(
                          SalesDetailsEvent.fetchSaleDetails(sale.id),
                        );
                  }
                },
              );
            },
          ),
          const SizedBox(width: 12),
          // Download Invoice
          _buildIconActionButton(
            context,
            icon: Icons.download_outlined,
            color: AppColors.purple,
            onTap: () => _openInvoicePdf(context, sale),
          ),
        ],
      ),
    );
  }

  Future<void> _openInvoicePdf(
    BuildContext context,
    SaleDetailsModel sale,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final getSaleInvoice = getIt<GetSaleInvoicePdfUseCase>();
      final pdfBytes = await getSaleInvoice(sale.id);
      if (context.mounted) Navigator.of(context).pop();

      if (kIsWeb) {
        openPdfInNewTab(pdfBytes, 'sales_invoice_${sale.id}.pdf');
        return;
      }

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/sales_invoice_${sale.id}.pdf');
      await file.writeAsBytes(pdfBytes);
      await OpenFile.open(file.path);
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        context.showSnackBar('Failed to open invoice: $e', isError: true);
      }
    }
  }

  void _showInvoiceActionsModal(BuildContext context, SaleDetailsModel sale) {
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
                'Send invoice PDF to ${sale.clientPhone}',
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
                  final sendSaleInvoice = getIt<SendSaleInvoiceUsecase>();
                  await sendSaleInvoice(
                    sale.id,
                    sendWhatsApp: true,
                  );
                  if (context.mounted) Navigator.of(context).pop();
                  if (context.mounted) {
                    context.showSnackBar(
                      'Invoice sent to ${sale.clientPhone} via WhatsApp',
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
                  final getSaleInvoice = getIt<GetSaleInvoicePdfUseCase>();
                  final pdfBytes = await getSaleInvoice(sale.id);
                  if (context.mounted) Navigator.of(context).pop();
                  if (kIsWeb) {
                    openPdfInNewTab(pdfBytes, 'sales_invoice_${sale.id}.pdf');
                  } else {
                    final dir = await getTemporaryDirectory();
                    final file =
                        File('${dir.path}/sales_invoice_${sale.id}.pdf');
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
