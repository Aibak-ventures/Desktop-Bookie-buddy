import 'dart:developer';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/product_simple_details_tile.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
// import 'package:bookie_buddy_web/features/add_booking/view_model/cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/view_model/cubit_save_sales/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/add_or_edit_sales_screen.dart';
import 'package:bookie_buddy_web/features/sale_details/view/widgets/generate_sale_details_pdf.dart';
import 'package:bookie_buddy_web/features/sale_details/view/widgets/sale_details_details_column.dart';
import 'package:bookie_buddy_web/features/sale_details/view/widgets/sale_details_payment_details_row.dart';
import 'package:bookie_buddy_web/features/sale_details/view/widgets/sale_details_section.dart';
import 'package:bookie_buddy_web/features/sale_details/view_model/bloc_sale_details/sale_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaleDetailsScreen extends StatelessWidget {
  const SaleDetailsScreen({super.key, required this.saleId});
  final int saleId;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Sale Details'),
          actions: [
            BlocBuilder<SaleDetailsBloc, SaleDetailsState>(
              builder: (context, state) {
                final sale = state.maybeWhen(
                  orElse: () => null,
                  loaded: (s, _) => s,
                );
                final isLoading = sale == null;
                return IconButton(
                  icon: const Icon(Icons.share),
                  onPressed:
                      isLoading //if the data is loading the function is disabled
                          ? null
                          : () async {
                              final shopData =
                                  context.read<UserCubit>().state?.shopDetails;
                              if (shopData == null) {
                                context.showSnackBar(
                                  'Shop data not available',
                                  isError: true,
                                );

                                return;
                              }
                              try {
                                await GenerateSaleDetailsPdf.shareInvoice(
                                  context: context,
                                  saleDetails: sale,
                                  shopDetails: shopData,
                                );
                              } catch (e, stack) {
                                log(e.toString(), stackTrace: stack);
                                context.showSnackBar(
                                  'Failed to generate PDF: $e',
                                  isError: true,
                                );
                              }
                            },
                );
              },
            ),
            BlocBuilder<SaleDetailsBloc, SaleDetailsState>(
              builder: (context, state) {
                final sale = state.maybeWhen(
                  orElse: () => null,
                  loaded: (s, _) => s,
                );
                return PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      onTap: () async {
                        if (sale == null) {
                          debugPrint(
                              'sale is null, returning from edit action');
                          return;
                        }
                        await performSecureActionDialog(
                          context,
                          SecretPasswordLocations.bookingEdit,
                          onSuccess: () async {
                            StaffModel? existingStaff;
                            if (sale.staffId != null) {
                              existingStaff = StaffModel(
                                id: sale.staffId!,
                                name: sale.staffName ?? 'Staff Name',
                                phoneNumber: '',
                              );
                            }
                            context
                              ..read<StaffSearchCubit>().clearSelectedStaff()
                              ..read<StaffSearchCubit>().getAllStaffs(
                                sale.staffId,
                                existingStaff,
                              )
                              ..read<ClientCubit>().clearSelected();
                            final result = await context.push(
                              BlocProvider(
                                create: (context) =>
                                    SaveSalesCubit(repository: getIt.get()),
                                child: AddOrEditSalesScreen(saleDetails: sale),
                              ),
                            );

                            if (result == true) {
                              context.read<SaleDetailsBloc>().add(
                                    SaleDetailsEvent.getSaleDetails(
                                        saleId: sale.id),
                                  );
                            }
                          },
                        );
                      },
                      child: const Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.edit_outlined, color: AppColors.purple),
                          Text('Edit'),
                        ],
                      ),
                    ),

                    // delete
                    PopupMenuItem<int>(
                      value: 1,
                      onTap: () async {
                        if (sale == null) {
                          debugPrint(
                            'booking is null, returning from delete action',
                          );
                          return;
                        }
                        await performSecureActionDialog(
                          context,
                          SecretPasswordLocations.bookingDelete,
                          onSuccess: () async {
                            await showDeleteSaleDialog(context, sale.id);
                          },
                        );
                      },
                      child: const Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.delete_outline,
                              color: AppColors.redTomato),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<SaleDetailsBloc, SaleDetailsState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (error) {
                context.showSnackBar(error, isError: true);
              },
              loaded: (saleDetails, isDeleted) {
                if (isDeleted) {
                  context
                    ..pop(true)
                    ..showSnackBar('Sale deleted successfully');
                }
              },
            );
          },
          builder: (context, state) => state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error) => CustomErrorWidget(
              errorText: error,
              onRetry: () {
                context.read<SaleDetailsBloc>().add(
                      SaleDetailsEvent.getSaleDetails(saleId: saleId),
                    );
              },
            ),
            loaded: (saleDetails, _) => ListView(
              padding: 16.padding,
              children: [
                SaleDetailsSection(
                  title: 'Client Details',
                  padding: 18.padding,
                  trailing: Flexible(
                    child: Container(
                      padding: 8.padding,
                      decoration: BoxDecoration(
                        color: AppColors.purpleLightShade,
                        borderRadius: 5.radiusBorder,
                      ),
                      child: Text(
                        'ID: ${saleDetails.invoiceId}',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  SaleDetailsDetailsColumn(
                    label: 'Phone number',
                    value: saleDetails.clientPhone??'N/A',
                  ),

                  // if (saleDetails.address.isNotNullOrEmpty)
                  SaleDetailsDetailsColumn(
                    label: 'Place',
                    value: saleDetails?.address?? 'N/A',
                  ),
                ],
              ),
                ),
                15.height,
                SaleDetailsSection(
                  title: 'Product Details',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        itemCount: saleDetails.products.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = saleDetails.products[index];

                          return Column(
                            children: [
                              ProductSimpleDetailsTile(
                                mainServiceType: product.mainServiceType,
                                amount: product.price,
                                name: product.name,
                                quantity: product.quantity,
                                category: product.category,
                                color: product.color,
                                image: product.image,
                                model: product.model,
                                variantAttribute: product.variantAttribute,
                              ),
                            ],
                          );
                        },
                      ),
                      if (saleDetails.description.isNotNullOrEmpty) ...[
                        Padding(
                          padding: 16.paddingHorizontal,
                          child: const Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            bottom: 20.w,
                          ),
                          child: SaleDetailsDetailsColumn(
                            label: 'Note',
                            value: saleDetails.description,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                15.height,
                SaleDetailsSection(
                  title: 'Dates',
                  padding: 18.padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SaleDetailsDetailsColumn(
                        label: 'Sale date',
                        value: saleDetails.saleDate.formatToUiDate(),
                      ),
                      if (saleDetails.createdAt.isNotNullOrEmpty)
                        SaleDetailsDetailsColumn(
                          label: 'Time',
                          value: saleDetails.createdAt.formatToUiTime(),
                        ),
                    ],
                  ),
                ),
                15.height,
                SaleDetailsSection(
                  title: 'Payment Details',
                  padding: 18.padding,
                  child: Column(
                    spacing: 10,
                    children: [
                      SaleDetailsPaymentDetailsRow(
                        title: 'Payment Method',
                        amount: 0,
                        trailing: saleDetails.paymentMethod.name,
                      ),
                      const Divider(),
                      SaleDetailsPaymentDetailsRow(
                        title: 'Subtotal',
                        amount: saleDetails.totalAmount,
                      ),
                      SaleDetailsPaymentDetailsRow(
                        title: 'Discount',
                        amount: saleDetails.discountAmount,
                      ),
                      SaleDetailsPaymentDetailsRow(
                        title: 'Grand Total',
                        amount: saleDetails.totalAmount -
                            saleDetails.discountAmount,
                        isTotal: true,
                      ),
                      // SaleDetailsPaymentDetailsRow(
                      //   title: 'Paid',
                      //   amount: saleDetails.paidAmount,
                      // ),
                    ],
                  ),
                ),
                15.height,
                SaleDetailsSection(
                  title: 'Other Details',
                  padding: 18.padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SaleDetailsDetailsColumn(
                        label: 'Staff name',
                        value: saleDetails.staffName ?? 'N/A',
                      ),
                    ],
                  ),
                ),
                25.height,
              ],
            ),
          ),
        ),
      );
}

Future<void> showDeleteSaleDialog(BuildContext context, int saleId) async {
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this sale?'),
      actions: [
        // Cancel button
        TextButton(
          onPressed: context.pop, // Closes the dialog
          child: const Text('Cancel'),
        ),
        // Confirm Delete button
        ElevatedButton(
          onPressed: () {
            context.read<SaleDetailsBloc>().add(
                  SaleDetailsEvent.deleteSale(saleId: saleId),
                );
            context.pop(); // Closes the dialog
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Delete', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
