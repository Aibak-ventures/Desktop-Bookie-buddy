import 'package:bookie_buddy_web/core/common/widgets/custom_drop_down_field.dart';
import 'package:bookie_buddy_web/core/constants/enums/account_type_enum.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/bloc/accounts_cubit/accounts_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A reusable account selector backed by [AccountsCubit].
///
/// Calls [AccountsCubit.loadAccounts] on first build (cached after first load).
/// Shows a retry button on error. Renders a [CustomDropDownField] when loaded.
///
/// Usage:
/// ```dart
/// AccountSelectionField(
///   selectedAccount: _selectedAccount,
///   onChanged: (account) => setState(() => _selectedAccount = account),
/// )
/// ```
class AccountSelectionField extends StatefulWidget {
  const AccountSelectionField({
    super.key,
    required this.selectedAccount,
    required this.onChanged,
    this.initialAccountId,
    this.initialAutoSelect = true,
    this.width,
    this.label,
    this.filterType = AccountFilterType.all,
  });

  /// Currently selected account (controlled externally).
  final AccountEntity? selectedAccount;

  /// Called when the user picks a different account.
  final ValueChanged<AccountEntity?> onChanged;

  /// If set and [selectedAccount] is null, auto-selects the account
  /// matching this ID once the list loads (useful for edit screens).
  final int? initialAccountId;

  final bool initialAutoSelect;

  final double? width;

  final String? label;

  final AccountFilterType filterType;

  @override
  State<AccountSelectionField> createState() => _AccountSelectionFieldState();
}

class _AccountSelectionFieldState extends State<AccountSelectionField> {
  bool _didAutoSelect = false;

  @override
  void initState() {
    super.initState();
    context.read<AccountsCubit>().loadAccounts();
  }

  AccountEntity? getDefaultAccount(List<AccountEntity> accounts) =>
      accounts.firstWhereOrNull((a) => a.isDefault);

  void _tryAutoSelect(List<AccountEntity> accounts) {
    if (_didAutoSelect ||
        widget.selectedAccount != null ||
        widget.initialAutoSelect == false) {
      return;
    }
    _didAutoSelect = true;
    final match = widget.initialAccountId != null
        ? accounts.firstWhereOrNull((a) => a.id == widget.initialAccountId) ??
              getDefaultAccount(accounts)
        : getDefaultAccount(accounts);
    if (match == null) return;
    debugPrint(
      'AccountSelectionField: Auto-selecting account \'${match.accountName}\' (ID: ${match.id})',
    );
    // Schedule after build to avoid setState-during-build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChanged(match);
    });
  }

  void _onRetry(BuildContext context) {
    if (!context.mounted) return;
    context.read<AccountsCubit>().loadAccounts(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? context.screenWidth - 32;

    return BlocBuilder<AccountsCubit, AccountsState>(
      builder: (context, state) => state.when(
        //
        initial: () => _RetryField(
          width: width,
          isError: false,
          hintText: 'Retry to load accounts',
          onRetry: () => _onRetry(context),
        ),

        //
        loading: () => CustomDropDownField<String>(
          hintText: 'Loading accounts...',
          width: width,
          prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
          onChanged: (_) {},
          items: const [],
          itemLabelBuilder: null,
        ),

        //
        error: (message) => _RetryField(
          width: width,
          isError: true,
          hintText: 'Failed to load accounts',
          onRetry: () => _onRetry(context),
        ),

        //
        loaded: (accounts) {
          final filteredAccounts = widget.filterType == AccountFilterType.all
              ? accounts
              : accounts
                    .where(
                      (account) =>
                          account.accountType == widget.filterType.accountType,
                    )
                    .toList();
          _tryAutoSelect(filteredAccounts);
          return CustomDropDownField<AccountEntity>(
            hintText: 'Select Payment Option',
            label: widget.label ?? 'Payment Option',
            menuHeight: MediaQuery.sizeOf(context).height * 0.3,
            width: width,
            prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
            selectedValue: widget.selectedAccount,
            onChanged: widget.onChanged,
            items: filteredAccounts,
            itemLabelBuilder: (account) => account.accountName,
          );
        },
      ),
    );
  }
}

/// Shown when the account fetch fails. Matches the shape of [CustomDropDownField]
/// but displays a tappable retry affordance.
class _RetryField extends StatelessWidget {
  const _RetryField({
    required this.width,
    required this.onRetry,
    required this.isError,
    required this.hintText,
  });

  final double width;
  final VoidCallback onRetry;
  final bool isError;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final decoration = theme.dropdownMenuTheme.inputDecorationTheme;
    final dropdownTheme = theme.inputDecorationTheme;
    final dropdownColor = dropdownTheme.border?.borderSide.color ?? Colors.grey;
    return GestureDetector(
      onTap: onRetry,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            decoration?.enabledBorder is OutlineInputBorder
                ? (decoration!.enabledBorder as OutlineInputBorder)
                      .borderRadius
                      .topLeft
                      .x
                : 8,
          ),
          border: Border.all(
            color: (isError ? theme.colorScheme.error : dropdownColor)
                .withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.purple,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                hintText,
                style: TextStyle(
                  color: isError ? theme.colorScheme.error : dropdownColor,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(
              Icons.refresh,
              color: isError ? theme.colorScheme.error : dropdownColor,
            ),
          ],
        ),
      ),
    );
  }
}
