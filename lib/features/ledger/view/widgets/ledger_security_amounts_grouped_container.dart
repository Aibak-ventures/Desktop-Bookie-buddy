import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_security_amount_model/ledger_security_amount_model.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_security_amount_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LedgerSecurityAmountsGroupedContainer extends StatelessWidget {
  const LedgerSecurityAmountsGroupedContainer({
    super.key,
    required this.groupedDate,
    required this.securityAmounts,
  });

  final String groupedDate;
  final List<LedgerSecurityAmountModel> securityAmounts;

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
                // if (securityAmounts
                //     .isNotEmpty) // Only show share button if payments exist
                //   Container(
                //     decoration: BoxDecoration(
                //       color: AppColors.purpleLightShade,
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //     padding: 8.padding,
                //     child: Row(
                //       spacing: 4,
                //       children: [
                //         Icon(
                //           Icons.share_outlined,
                //           size: 18.sp,
                //           semanticLabel: 'Share',
                //         ),
                //         Text(
                //           'Share',
                //           style: TextStyle(
                //             fontSize: 14.sp,
                //             color: AppColors.black,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ).onTap(
                //     () async {
                //       final date = groupedDate.formatToUiDate();

                //       final user = context.read<UserCubit>().state!;
                //       await shareLedgerInvoice(
                //         context: context,
                //         user: user,
                //         fromDate: date,
                //         toDate: date,
                //         includeExpense: false,
                //         includePayments: false,
                //         includePendings: true,
                //         includeSecurity: false,
                //         includeBookings: false,
                //         isExcel: false,
                //       );
                //     },
                //   ),
              ],
            ),
          ),
          ...securityAmounts.map((securityAmount) {
            final date = securityAmount.date.parseToDateTime();
            return LedgerSecurityAmountListTile(
              securityAmountModel: securityAmount,
              date: date,
            );
          })
        ],
      );
}
