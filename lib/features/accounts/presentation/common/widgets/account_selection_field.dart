import 'package:bookie_buddy_web/core/common/widgets/custom_drop_down_field.dart';
import 'package:bookie_buddy_web/core/constants/enums/account_type_enum.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/bloc/accounts_cubit/accounts_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ---------------------------------------------------------------------------
// Theme class
// ---------------------------------------------------------------------------

/// Controls the visual appearance of [AccountSelectionField].
///
/// Use the predefined themes or construct a custom one:
/// ```dart
/// // Predefined
/// AccountSelectionField(fieldTheme: AccountSelectionFieldTheme.standard)
/// AccountSelectionField(fieldTheme: AccountSelectionFieldTheme.compact)
///
/// // Custom
/// AccountSelectionField(
///   fieldTheme: AccountSelectionFieldTheme(
///     layout: AccountSelectionLayout.compact,
///     height: 48,
///     borderColor: Colors.blue,
///   ),
/// )
/// ```
class AccountSelectionFieldTheme {
  const AccountSelectionFieldTheme({
    this.layout = AccountSelectionLayout.standard,
    this.height,
    this.borderColor,
    this.borderRadius,
    this.backgroundColor = Colors.white,
    this.iconSize,
    this.textStyle,
    this.hintStyle,
    this.iconColor,
  });

  /// Compact inline field (h:42, grey border) matching ClientSearchNameField.
  static const compact = AccountSelectionFieldTheme(
    layout: AccountSelectionLayout.compact,
    height: 42,
    borderRadius: 8,
  );

  /// Default labelled dropdown matching other form fields.
  static const standard = AccountSelectionFieldTheme(
    layout: AccountSelectionLayout.standard,
  );

  final AccountSelectionLayout layout;

  /// Field height. Defaults: compact→42, standard→uses CustomDropDownField default.
  final double? height;

  /// Border colour. Defaults: compact→grey.300, standard→theme border.
  final Color? borderColor;

  /// Border radius. Defaults: compact→8, standard→theme radius.
  final double? borderRadius;

  final Color backgroundColor;

  /// Icon size. Defaults: compact→16, standard→24.
  final double? iconSize;

  /// Text style for the selected value / hint (compact layout only).
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  /// Icon colour. Defaults: compact→grey.600 / grey.400, standard→AppColors.purple.
  final Color? iconColor;
}

enum AccountSelectionLayout { standard, compact }

// ---------------------------------------------------------------------------
// Widget
// ---------------------------------------------------------------------------

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
///   fieldTheme: AccountSelectionFieldTheme.compact,
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
    this.fieldTheme = AccountSelectionFieldTheme.compact,
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

  final AccountSelectionFieldTheme fieldTheme;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChanged(match);
    });
  }

  void _onRetry(BuildContext context) {
    if (!context.mounted) return;
    context.read<AccountsCubit>().loadAccounts(forceRefresh: true);
  }

  bool get _isCompact =>
      widget.fieldTheme.layout == AccountSelectionLayout.compact;

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? context.screenWidth - 32;
    final label = widget.label ?? 'Payment Option';

    return BlocBuilder<AccountsCubit, AccountsState>(
      builder: (context, state) => state.when(
        initial: () => _RetryField(
          width: width,
          isError: false,
          hintText: 'Retry to load accounts',
          onRetry: () => _onRetry(context),
          theme: widget.fieldTheme,
          label: label,
        ),

        loading: () => _isCompact
            ? _CompactAccountField(
                selectedAccount: null,
                accounts: const [],
                onChanged: (_) {},
                label: label,
                isLoading: true,
                theme: widget.fieldTheme,
              )
            : CustomDropDownField<String>(
                hintText: 'Loading accounts...',
                width: width,
                prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
                onChanged: (_) {},
                items: const [],
                itemLabelBuilder: null,
              ),

        error: (message) => _RetryField(
          width: width,
          isError: true,
          hintText: 'Failed to load accounts',
          onRetry: () => _onRetry(context),
          theme: widget.fieldTheme,
          label: label,
        ),

        loaded: (accounts) {
          final filteredAccounts = widget.filterType == AccountFilterType.all
              ? accounts
              : accounts
                    .where(
                      (a) => a.accountType == widget.filterType.accountType,
                    )
                    .toList();
          _tryAutoSelect(filteredAccounts);

          if (_isCompact) {
            return _CompactAccountField(
              selectedAccount: widget.selectedAccount,
              accounts: filteredAccounts,
              onChanged: widget.onChanged,
              label: label,
              theme: widget.fieldTheme,
            );
          }

          return CustomDropDownField<AccountEntity>(
            hintText: 'Select Payment Option',
            label: label,
            menuHeight: MediaQuery.sizeOf(context).height * 0.3,
            width: width,
            enableFilter: true,
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

// ---------------------------------------------------------------------------
// Compact layout
// ---------------------------------------------------------------------------

class _CompactAccountField extends StatelessWidget {
  const _CompactAccountField({
    required this.selectedAccount,
    required this.accounts,
    required this.onChanged,
    required this.label,
    required this.theme,
    this.isLoading = false,
  });

  final AccountEntity? selectedAccount;
  final List<AccountEntity> accounts;
  final ValueChanged<AccountEntity?> onChanged;
  final String label;
  final AccountSelectionFieldTheme theme;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final height = theme.height ?? 42;
    final radius = theme.borderRadius ?? 8;
    final borderColor = theme.borderColor ?? Colors.grey.shade300;
    final iconSize = theme.iconSize ?? 16;
    final iconColor = theme.iconColor;
    final resolvedIconColor = selectedAccount != null
        ? (iconColor ?? Colors.grey.shade600)
        : (iconColor ?? Colors.grey.shade400);
    final effectiveTextStyle =
        theme.textStyle ?? const TextStyle(fontSize: 13, color: Colors.black87);
    final effectiveHintStyle =
        theme.hintStyle ?? TextStyle(fontSize: 13, color: Colors.grey.shade400);

    return InputDecorator(
      isEmpty: selectedAccount == null && !isLoading,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        prefixIcon: Icon(
          Icons.account_balance_wallet_outlined,
          size: iconSize,
          color: resolvedIconColor,
        ),
      ),
      child: PopupMenuButton<AccountEntity>(
        enabled: !isLoading,
        onSelected: onChanged,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        constraints: const BoxConstraints(maxHeight: 240),
        itemBuilder: (_) => accounts
            .map(
              (a) => PopupMenuItem<AccountEntity>(
                value: a,
                child: Text(a.accountName, style: effectiveTextStyle),
              ),
            )
            .toList(),
        child: SizedBox(
          height: height,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedAccount?.accountName ??
                      (isLoading ? 'Loading...' : ''),
                  style: selectedAccount != null
                      ? effectiveTextStyle
                      : effectiveHintStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 20,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Retry field
// ---------------------------------------------------------------------------

class _RetryField extends StatelessWidget {
  const _RetryField({
    required this.width,
    required this.onRetry,
    required this.isError,
    required this.hintText,
    required this.theme,
    required this.label,
  });

  final double width;
  final VoidCallback onRetry;
  final bool isError;
  final String hintText;
  final AccountSelectionFieldTheme theme;
  final String label;

  @override
  Widget build(BuildContext context) {
    if (theme.layout == AccountSelectionLayout.compact) {
      final height = theme.height ?? 42;
      final radius = theme.borderRadius ?? 8;
      final iconSize = theme.iconSize ?? 16;
      final borderColor = isError ? Colors.red.shade300 : Colors.grey.shade300;
      final contentColor = isError ? Colors.red.shade400 : Colors.grey.shade400;

      return GestureDetector(
        onTap: onRetry,
        child: InputDecorator(
          isEmpty: true,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(color: borderColor),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            prefixIcon: Icon(
              Icons.account_balance_wallet_outlined,
              size: iconSize,
              color: contentColor,
            ),
          ),
          child: SizedBox(
            height: height,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    hintText,
                    style: TextStyle(fontSize: 13, color: contentColor),
                  ),
                ),
                Icon(Icons.refresh, size: iconSize, color: contentColor),
              ],
            ),
          ),
        ),
      );
    }

    // Standard retry
    final flutterTheme = Theme.of(context);
    final decoration = flutterTheme.dropdownMenuTheme.inputDecorationTheme;
    final dropdownTheme = flutterTheme.inputDecorationTheme;
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
            color: (isError ? flutterTheme.colorScheme.error : dropdownColor)
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
                  color: isError
                      ? flutterTheme.colorScheme.error
                      : dropdownColor,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(
              Icons.refresh,
              color: isError ? flutterTheme.colorScheme.error : dropdownColor,
            ),
          ],
        ),
      ),
    );
  }
}
