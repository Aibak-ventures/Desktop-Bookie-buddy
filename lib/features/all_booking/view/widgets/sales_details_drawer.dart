import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/add_or_edit_sales_screen.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/new_sales_screen.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/view_model/cubit_save_sales/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/all_booking/view/widgets/generate_sales_pdf.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_sales_details/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_sales_details_drawer/sales_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_sales/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/sale_details/view/edit_sales_screen/edit_sales_screen.dart';
import 'package:bookie_buddy_web/src/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class SalesDetailsDrawer extends StatelessWidget {
  const SalesDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalesDetailsBloc, SalesDetailsState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (message, didPop, needRefresh) {
            context.showSnackBar(message);
            if (needRefresh) {
              context.read<AllSalesBloc>().add(const AllSalesEvent.loadSales());
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
          );
        },
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
          loaded: (sale) => SingleChildScrollView(
            key: ValueKey('sale_${sale.id}'),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                if (sale.staffName != null && sale.staffName!.isNotEmpty) ...[
                  _buildStaffSection(sale),
                  const SizedBox(height: 24),
                ],

                // Payment details
                _buildPaymentDetails(sale),
                const SizedBox(height: 32),

                // Action buttons
                _buildActionButtons(context, sale),
              ],
            ),
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
            String specsLabel =
                item.mainServiceType?.quantityFieldLabel ?? 'Specifications';

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
                        // Show variant for multi-variant products, or category/model for others
                        if (item.mainServiceType.isMultiVariantProductType) ...[
                          // For multi-variant products (dresses, costumes, gadgets), show variant
                          if (item.variantAttribute != null &&
                              item.variantAttribute!.isNotEmpty)
                            Text(
                              '$specsLabel : ${item.variantAttribute}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ] else ...[
                          // For non-multi-variant products (vehicles, equipment), show category and model
                          if (item.category != null &&
                              item.category!.isNotEmpty)
                            Text(
                              'Category : ${item.category}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          if (item.model != null && item.model!.isNotEmpty)
                            Text(
                              'Model : ${item.model}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ],
                        // Always show color if it exists
                        if (item.color != null && item.color!.isNotEmpty)
                          Text(
                            'Colour : ${item.color}',
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
    final phone1 =
        sale.client?.phone1?.toString() ?? sale.clientPhone.toString();
    final phone2 = sale.client?.phone2?.toString();
    final name = sale.client?.name;

    if (phone1.isEmpty) return const SizedBox.shrink();

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
          _buildPaymentRow('Grand Total', '₹${sale.totalAmount}',
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

  Widget _buildActionButtons(BuildContext context, SaleDetailsModel sale) {
    return Row(
      children: [
        // Delete button
        IconButton.outlined(
          onPressed: () async {
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
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
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
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          style: IconButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade300),
            padding: const EdgeInsets.all(12),
          ),
        ),
        const SizedBox(width: 12),
        // Edit button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              // Navigate to EditSalesScreen with sale details
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (_) =>
                        SaveSalesCubit(repository: getIt<SalesRepository>()),
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
              }
            },
            icon: const Icon(Icons.edit),
            label: const Text('Edit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Download Invoice
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              final user = context.read<UserCubit>().state;
              final shop = user?.shopDetails;

              if (shop == null) {
                context.showSnackBar('Shop info not found', isError: true);
                return;
              }

              await GenerateSalesPdf.shareInvoice(
                context: context,
                saleDetails: sale,
                shopDetails: shop,
              );
            },
            icon: const Icon(Icons.download),
            label: const Text('Download Invoice'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
