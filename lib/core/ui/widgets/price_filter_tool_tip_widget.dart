import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceFilterToolTipWidget extends StatelessWidget {
  const PriceFilterToolTipWidget({
    super.key,
    required this.isPriceFilterEnabled,
    required this.priceRangeNotifier,
    this.onCloseTap,
  });

  final ValueNotifier<bool> isPriceFilterEnabled;
  final ValueNotifier<RangeValues> priceRangeNotifier;
  final VoidCallback? onCloseTap;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: isPriceFilterEnabled,
        builder: (context, isPriceEnabled, child) => isPriceEnabled
            ? ValueListenableBuilder(
                valueListenable: priceRangeNotifier,
                builder: (context, pricerRange, child) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.purple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.purple),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.filter_list,
                            size: 16.sp,
                            color: AppColors.purple,
                          ),
                          8.width,
                          Expanded(
                            child: Text(
                              'Filter by price: ${pricerRange.start.toCurrency()} - ${pricerRange.end.toCurrency()}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.purple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: 2.padding,
                            decoration: BoxDecoration(
                              color: AppColors.purple.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 14.sp,
                              color: AppColors.purple,
                            ),
                          ).onTap(
                            () {
                              isPriceFilterEnabled.value = false;
                              onCloseTap?.call();
                            },
                          ),
                        ],
                      ),
                    ))
            : const SizedBox.shrink(),
      );
}
