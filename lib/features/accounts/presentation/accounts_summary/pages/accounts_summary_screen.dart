import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/common/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/accounts_summary/cubit/accounts_summary_cubit.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/accounts_summary/widgets/account_list_tile.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/accounts_summary/widgets/accounts_summary_shimmer.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/accounts_summary/widgets/show_account_dialog.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/accounts_summary/widgets/total_balance_card.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/bloc/accounts_cubit/accounts_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountsSummaryScreen extends StatelessWidget {
  const AccountsSummaryScreen({super.key, required this.canManageAccounts});
  final bool canManageAccounts;
  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) {
      // load accounts again if have any changes were made in the accounts management screen
      if (didPop) {
        return;
      }

      // check for changes and reload accounts if needed
      if (context.read<AccountsSummaryCubit>().haveChanges) {
        context.read<AccountsCubit>().loadAccounts(forceRefresh: true);
      }

      context.pop();
    },
    child: Scaffold(
      appBar: AppBar(title: const Text('Accounts')),
      body: BlocConsumer<AccountsSummaryCubit, AccountsSummaryState>(
        listenWhen: (previous, current) =>
            previous != current &&
            current.maybeMap(
              orElse: () => false,
              loaded: (value) =>
                  value.status.isSuccess ||
                  value.status.isFailure ||
                  value.status.isPartiallyUpdating,
            ),
        listener: (context, state) {
          state.maybeMap(
            loaded: (value) {
              // show loading overlay when updating
              if (value.status.isPartiallyUpdating) {
                GlobalLoadingOverlay.show(context, text: 'Updating...');
              }
              // hide loading overlay
              if (value.status.isSuccess || value.status.isFailure) {
                GlobalLoadingOverlay.hide();
              }
              if (value.status.isSuccess && value.message != null) {
                context.showSnackBar(value.message!);
              }
              if (value.status.isFailure && value.message != null) {
                context.showSnackBar(value.message!, isError: true);
              }
            },
            orElse: () {},
          );
        },
        builder: (context, state) => state.when(
          loading: () => Padding(
            padding: 16.padding,
            child: const AccountsSummaryShimmer(),
          ),
          error: (message) => CustomErrorWidget(
            errorText: message,
            onRetry: () => _fetchData(context),
          ),
          loaded: (summary, _, __) => RefreshIndicator.adaptive(
            onRefresh: () async => _fetchData(context),
            child: ListView(
              padding: 16.padding,
              children: [
                // Total balance card
                TotalBalanceCard(totalBalance: summary.totalBalance),
                24.height,
                // Section header
                Text(
                  'MY ACCOUNTS',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey600,
                    letterSpacing: 0.8,
                  ),
                ),
                12.height,
                // Account list
                if (summary.accounts.isEmpty)
                  const EmptyDataWidget(
                    message: 'No accounts yet.\nTap + Add to create one.',
                    isShowIcon: false,
                  )
                else
                  ...summary.accounts.map((accountBalance) {
                    final account = accountBalance.account;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: AccountListTile(
                        accountBalance: accountBalance,
                        canManageAccounts: canManageAccounts,
                        onToggleActive: (isActive) {
                          context
                              .read<AccountsSummaryCubit>()
                              .toggleAccountStatus(
                                accountId: account.id,
                                isActive: isActive,
                              );
                        },

                        onEdit: () async {
                          final requestData = await AccountDialog.show(
                            context: context,
                            mode: AccountDialogMode.edit,
                            initialData: account,
                          );
                          if (requestData == null || context.mounted == false) {
                            return;
                          }
                          await context
                              .read<AccountsSummaryCubit>()
                              .updateAccount(
                                accountId: account.id,
                                account: requestData,
                              );
                        },
                        onDelete: () {
                          performSecureActionDialog(
                            context,
                            //TODO: support full time password
                            SecretPasswordLocations.ledgerView,
                            onSuccess: () async {
                              // get delete function to call inside the confirmation dialog
                              final deleteAccount = context
                                  .read<AccountsSummaryCubit>()
                                  .deleteAccount;
                              return _showDeleteAccountConfirmationDialog(
                                context: context,
                                deleteAccount: () {
                                  deleteAccount(accountId: account.id);
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  }),
                16.height,
                // Add new account button
                if (canManageAccounts)
                  _AddNewAccountButton(
                    onTap: () async {
                      final requestData = await AccountDialog.show(
                        context: context,
                      );
                      if (requestData == null || context.mounted == false) {
                        return;
                      }
                      await context.read<AccountsSummaryCubit>().createAccount(
                        account: requestData,
                      );
                    },
                  ),
                24.height,
              ],
            ),
          ),
        ),
      ),
    ),
  );

  void _fetchData(BuildContext context) =>
      context.read<AccountsSummaryCubit>().loadAccountsSummary();

  Future<void> _showDeleteAccountConfirmationDialog({
    required BuildContext context,
    required VoidCallback deleteAccount,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              Icons.delete_outline_rounded,
              color: colorScheme.error,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              'Delete Account',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete this account? This action cannot be undone.',
          style: TextStyle(fontSize: 14.sp, height: 1.4),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            style: TextButton.styleFrom(
              padding: (24, 12).padding,
              shape: RoundedRectangleBorder(borderRadius: 8.radiusBorder),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              deleteAccount();
            },
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              padding: (24, 12).padding,
              shape: RoundedRectangleBorder(borderRadius: 8.radiusBorder),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddNewAccountButton extends StatelessWidget {
  const _AddNewAccountButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.purpleLight.withValues(alpha: 0.4),
        borderRadius: 10.radiusBorder,
        border: Border.all(color: AppColors.purple.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: AppColors.purple, size: 20.sp),
          8.width,
          Text(
            'Add New Account',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.purple,
            ),
          ),
        ],
      ),
    ),
  );
}
