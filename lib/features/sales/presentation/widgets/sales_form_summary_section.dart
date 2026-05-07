import 'package:bookie_buddy_web/core/common/widgets/expandable_summary_tile.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/save_sales_cubit/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/sales/presentation/controllers/add_or_edit_sales_form_state_controller.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Summary panel + Update Sale button for [EditSalesScreen].
class SalesFormSummarySection extends StatelessWidget {
  final AddOrEditSalesFormStateController formController;
  final Listenable totalAmountListener;
  final VoidCallback onSave;

  const SalesFormSummarySection({
    super.key,
    required this.formController,
    required this.totalAmountListener,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 242, 254),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          ListenableBuilder(
            listenable: totalAmountListener,
            builder: (context, _) {
              final products = formController.selectedProductsNotifier.value;
              final discountAmount =
                  formController.discountController.text.trim().toIntOrNull() ??
                  0;
              final productTotal = products.fold<int>(
                0,
                (sum, p) => sum + (p.amount * p.variant.quantity),
              );
              final totalPayable = productTotal - discountAmount;

              final fields = <SummaryField>[
                SummaryField(
                  label: 'Product total',
                  value: productTotal.toCurrency(),
                ),
                if (discountAmount > 0)
                  SummaryField(
                    label: 'Discount',
                    value: '- ${discountAmount.toCurrency()}',
                    color: const Color(0xFFD30000),
                  ),
                SummaryField(
                  label: 'Total',
                  value: (totalPayable > 0 ? totalPayable : 0).toCurrency(),
                  labelStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color(0xFF3E3E3E),
                  ),
                  valueStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: Color(0xFF3E3E3E),
                  ),
                ),
              ];

              return ExpandableSummaryTile(
                totalLabel: 'Total Payable Amount',
                totalValue: (totalPayable > 0 ? totalPayable : 0).toCurrency(),
                fields: fields,
              );
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 39,
            child: BlocConsumer<SaveSalesCubit, SaveSalesState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  success: (_) {
                    context.showSnackBar('Sale updated successfully!');
                    Navigator.of(context).pop(true);
                  },
                  failure: (msg) => context.showSnackBar(msg, isError: true),
                );
              },
              builder: (context, state) {
                final isSaving = state.maybeMap(
                  orElse: () => false,
                  saving: (_) => true,
                );
                return ElevatedButton(
                  onPressed: isSaving ? null : onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6132E4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    disabledBackgroundColor: Colors.grey.shade400,
                  ),
                  child: isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Update Sale',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
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
}
