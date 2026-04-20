import 'package:bookie_buddy_web/core/common/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/core/constants/enums/account_type_enum.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_balance_entity/account_balance_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountListTile extends StatelessWidget {
  const AccountListTile({
    super.key,
    required this.accountBalance,
    required this.onToggleActive,
    this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.canManageAccounts,
  });

  final AccountBalanceEntity accountBalance;
  final ValueChanged<bool> onToggleActive;
  final bool canManageAccounts;
  final VoidCallback? onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final account = accountBalance.account;
    final isBank = account.accountType == AccountType.bank;

    return GestureDetector(
      onTap: onTap,
      onLongPress: () {
        if (canManageAccounts) {
          showAccountActions(context, onEdit: onEdit, onDelete: onDelete);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: 10.radiusBorder,
          border: Border.all(color: AppColors.grey200),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Account icon
            Container(
              padding: 10.padding,
              decoration: BoxDecoration(
                color: isBank
                    ? AppColors.purpleLight
                    : AppColors.green.withValues(alpha: 0.1),
                borderRadius: 10.radiusBorder,
              ),
              child: Icon(
                isBank
                    ? Icons.account_balance_rounded
                    : Icons.account_balance_wallet_outlined,
                color: isBank ? AppColors.purple : AppColors.green,
                size: 22.sp,
              ),
            ),
            12.width,
            // Account details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          account.accountName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (account.isDefault) ...[
                        6.width,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.purple,
                            borderRadius: 4.radiusBorder,
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  3.height,
                  Text(
                    _buildSubtitle(),
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            8.width,
            // Balance + toggle
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  accountBalance.balance.toCurrency(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: accountBalance.balance.isNegative
                        ? AppColors.redTomato
                        : AppColors.purple,
                  ),
                ),
                SizedBox(
                  height: 28.h,
                  child: Transform.scale(
                    scale: 0.75,
                    child: Switch.adaptive(
                      value: account.isActive,
                      onChanged: (value) {
                        if (canManageAccounts) {
                          onToggleActive(value);
                        } else {
                          // If user can't manage accounts, revert the switch and show a snackbar
                          context.showSnackBar(
                            'You don\'t have permission to ${value ? 'activate' : 'deactivate'} accounts.',
                            isError: true,
                            title: 'Permission Denied',
                          );
                        }
                      },

                      activeTrackColor: canManageAccounts
                          ? AppColors.purple
                          : AppColors.grey600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _buildSubtitle() {
    final account = accountBalance.account;
    final parts = <String>[];

    if (account.description != null && account.description!.isNotEmpty) {
      parts.add(account.description!);
    }

    if (account.accountNumber != null && account.accountNumber!.isNotEmpty) {
      final number = account.accountNumber!;
      final masked =
          '****${number.substring(number.length < 4 ? 0 : number.length - 4)}';
      parts.add(masked);
    }

    if (parts.isEmpty) {
      return account.accountType == AccountType.bank
          ? 'Bank Account'
          : 'Cash Account';
    }

    return parts.join(' \u00B7 ');
  }

  void showAccountActions(
    BuildContext context, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header section - gives context to the sheet
            Text(
              'Account Settings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),

            // Edit Action
            _buildActionItem(
              context,
              icon: Icons.edit_rounded,
              label: 'Edit details',
              onTap: onEdit,
            ),

            // Delete Action
            _buildActionItem(
              context,
              icon: Icons.delete_outline_rounded,
              label: 'Delete account',
              isDestructive: true,
              onTap: onDelete,
            ),

            const SizedBox(height: 16), // Bottom breathing room
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            // Subtle background for destructive actions can look nice:
            color: isDestructive
                ? color.changeOpacity(0.05)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: color.changeOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountListTileShimmer extends StatelessWidget {
  const AccountListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: 10.radiusBorder,
      border: Border.all(color: AppColors.grey200),
    ),
    child: Row(
      children: [
        CustomShimmerBox(width: 42.w, height: 42.h, borderRadius: 10),
        12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomShimmerBox(width: 120.w, height: 14.h),
              6.height,
              CustomShimmerBox(width: 80.w, height: 11.h),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomShimmerBox(width: 70.w, height: 14.h),
            6.height,
            CustomShimmerBox(width: 36.w, height: 18.h, borderRadius: 9),
          ],
        ),
      ],
    ),
  );
}
