import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/expense_model/expense_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_list_tile.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_wallet_expense/wallet_expense_bloc.dart';
import 'package:bookie_buddy_web/features/product/view/product_add_expense_dialog.dart';
import 'package:bookie_buddy_web/features/product/view_model/cubit_add_expense/add_expense_cubit.dart';
import 'package:bookie_buddy_web/features/save_expense/view/add_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LedgerExpenseGroupContainer extends StatelessWidget {
  const LedgerExpenseGroupContainer({
    required this.day,
    required this.expenses,
    super.key,
  });
  final String day;
  final List<ExpenseModel> expenses;
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.grey600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          ...expenses.map(
            (expense) => LedgerListTile(
              onTap: null, // Disable tap to prevent navigation
              icon: const Icon(Icons.currency_rupee),
              content: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        expense.type == null || (expense.type?.isEmpty ?? true)
                            ? 'Expense'
                            : expense.type!,
                      ),
                      if (expense.productId != null)
                        Container(
                          padding: 1.padding,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.purple),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 12,
                            color: AppColors.purple,
                          ),
                        ),
                    ],
                  ),
                  if (expense.description != null &&
                      expense.description!.isNotEmpty)
                    Text(
                      expense.description!,
                      maxLines: 2,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                ],
              ),
              amount: expense.expense,
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                enabled: expense.isDeleted != null && !expense.isDeleted!,
                onSelected: (value) {
                  if (value == 'edit') {
                    if (expense.productId != null) {
                      final mainService = _getMainServiceType(
                        context,
                        expense.serviceId,
                      );
                      showDialog(
                        context: context,
                        builder: (context) => BlocProvider(
                          create: (context) =>
                              AddExpenseCubit(repository: getIt.get()),
                          child: ProductAddExpenseDialog(
                            id: expense.id,
                            mainServiceType: mainService,
                            variantId: expense.variantId ?? expense.productId!,
                            existingAmount: expense.expense,
                            existingDate: expense.date,
                            existingDescription: expense.description,
                            existingType: expense.type,
                          ),
                        ),
                      ).then((_) {
                        context.read<WalletExpenseBloc>().add(
                              const WalletExpenseEvent.loadExpense(),
                            );
                      });
                      ;
                      return;
                    }
                    context.push(AddExpenseScreen(expense: expense)).then((_) {
                      context.read<WalletExpenseBloc>().add(
                            const WalletExpenseEvent.loadExpense(),
                          );
                    });
                  } else if (value == 'delete') {
                    showDeleteExpenseDialog(
                      context: context,
                      onDeletePressed: () {
                        context.read<WalletExpenseBloc>().add(
                              WalletExpenseEvent.deleteExpense(
                                expenseId: expense.id,
                                variantId: expense.variantId,
                              ),
                            );

                        context.pop();
                      },
                    );
                  }
                },
                itemBuilder: (BuildContext context) => const [
                  PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
                  PopupMenuItem<String>(value: 'delete', child: Text('Delete')),
                ],
              ),
            ),
          ),
        ],
      );

  MainServiceType _getMainServiceType(BuildContext context, serviceId) {
    try {
      final services = context.read<ServiceBloc>().getServices();
      debugPrint('services: $services');

      final mainService = MainServiceType.fromServiceList(services, serviceId);
      return mainService;
    } catch (e) {
      debugPrint('Error getting main service type: $e');
      rethrow;
    }
  }

  Future showDeleteExpenseDialog({
    required BuildContext context,
    required VoidCallback onDeletePressed,
  }) async =>
      showDialog(
        context: context,
        builder: (dialogCtx) => AlertDialog(
          title: const Text('Delete Expense'),
          content: const Text('Are you sure you want to delete this expense?'),
          actions: [
            TextButton(
              onPressed: () => dialogCtx.pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: onDeletePressed,
              child: const Text('Delete',
                  style: TextStyle(color: AppColors.white)),
            ),
          ],
        ),
      );
}

class LedgerExpenseGroupShimmer extends StatelessWidget {
  const LedgerExpenseGroupShimmer({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header shimmer (summaryDay + Share button)
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: CustomShimmerBox(
              width: 100,
              height: 14,
              borderRadius: 6,
            ), // summaryDay shimmer
          ),
          10.height,

          /// 3 Ledger List Tile Shimmers (you can adjust how many based on need)
          ...List.generate(3, (index) => const LedgerListTileShimmer()),
        ],
      );
}
