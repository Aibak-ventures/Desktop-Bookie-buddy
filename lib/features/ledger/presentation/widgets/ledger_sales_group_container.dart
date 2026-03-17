import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_sale_model/ledger_sale_model.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/widgets/generate_statement_pdf.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/widgets/ledger_list_tile.dart';
import 'package:bookie_buddy_web/features/sales/presentation/pages/sale_details_screen.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sale_details_bloc/sale_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LedgerSalesGroupContainer extends StatelessWidget {
  const LedgerSalesGroupContainer({
    super.key,
    required this.groupedDate,
    required this.sales,
  });

  final String groupedDate;
  final List<LedgerSaleModel> sales;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  groupedDate.getDateHeading(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.grey600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (sales
                    .isNotEmpty) // Only show share button if payments exist
                  Builder(
                    builder: (builderContext) => Container(
                      decoration: BoxDecoration(
                        color: AppColors.purpleLightShade,
                        borderRadius: 5.radiusBorder,
                      ),
                      padding: 8.padding,
                      child: Row(
                        spacing: 4,
                        children: [
                          Icon(
                            Icons.share_outlined,
                            size: 18.sp,
                            semanticLabel: 'Share',
                          ),
                          Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ).onTap(() async {
                      final date = groupedDate.formatToUiDate();

                      final user = builderContext.read<UserCubit>().state!;
                      await LedgerPDFService.shareLedgerInvoice(
                        context: builderContext,
                        user: user,
                        fromDate: date,
                        toDate: date,
                        includeSales: true,
                        isExcel: false,
                      );
                    }),
                  ),
              ],
            ),
          ),
          ...sales.map((sale) {
            final paymentMethod = sale.paymentMethods.firstOrNull;
            return LedgerListTile(
              onTap: () {
                context.read<SaleDetailsBloc>().add(
                      SaleDetailsEvent.getSaleDetails(saleId: sale.saleId),
                    );
                context.push(SaleDetailsScreen(saleId: sale.saleId));
              },
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (paymentMethod != null)
                    paymentMethod.isCash ? AppAssets.cash : AppAssets.upi,
                  Text(
                    sale.createdAt.formatToUiTime(),
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey600),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(sale.clientName),
                  Text(
                    'Items: ${sale.products}',
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              trailing: Expanded(
                child: Column(
                  children: [
                    Text(
                      sale.totalAmount.toCurrency(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Text(
                    //   'Total',
                    //   style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                    // ),
                  ],
                ),
              ),
            );
          }),
        ],
      );
}

class LedgerSalesListTileShimmer extends StatelessWidget {
  const LedgerSalesListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) => LedgerListTile(
        icon: Column(
          children: [
            CustomShimmerBox(width: 40.w, height: 12.sp),
            4.height,
            CustomShimmerBox(width: 30.w, height: 10.sp),
          ],
        ),
        content: Column(
          children: [
            CustomShimmerBox(width: 100.w, height: 14.sp),
            8.height,
            CustomShimmerBox(width: 160.w, height: 12.sp),
          ],
        ),
        trailing: Expanded(
          child: Column(
            children: [CustomShimmerBox(width: 50.w, height: 18.sp)],
          ),
        ),
      );
}
