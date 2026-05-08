import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/account_type_enum.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_request_entity/account_request_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AccountDialogMode { add, edit }

/// Shows the account dialog and returns a filled [AccountRequestEntity] on save,
/// or null if the user dismisses it.
///
/// ```dart
/// final result = await showAccountDialog(
///   context: context,
///   mode: AccountDialogMode.add,
/// );
/// if (result != null) {
///   context.read<AccountBloc>().add(AccountAdded(result));
/// }
/// ```
class AccountDialog extends StatefulWidget {
  const AccountDialog({super.key, required this.mode, this.initialData});

  final AccountDialogMode mode;
  final AccountEntity? initialData;

  @override
  State<AccountDialog> createState() => _AccountDialogState();

  static Future<AccountRequestEntity?> show({
    required BuildContext context,
    AccountDialogMode mode = AccountDialogMode.add,
    AccountEntity? initialData,
  }) {
    return showDialog<AccountRequestEntity>(
      context: context,
      builder: (_) => AccountDialog(mode: mode, initialData: initialData),
    );
  }
}

class _AccountDialogState extends State<AccountDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _numberCtrl;
  late final TextEditingController _descCtrl;

  // patch-only toggles (only sent on PATCH / edit)
  late bool _isActive;
  late bool _isDefault;

  bool get _isEditMode => widget.mode == AccountDialogMode.edit;

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    _nameCtrl = TextEditingController(text: d?.accountName ?? '');
    _numberCtrl = TextEditingController(text: d?.accountNumber ?? '');
    _descCtrl = TextEditingController(text: d?.description ?? '');
    _isActive = d?.isActive ?? true;
    _isDefault = d?.isDefault ?? false;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _numberCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final AccountRequestEntity requestData;

    if (_isEditMode) {
      final isNameChanged =
          _nameCtrl.text.trim() != widget.initialData?.accountName;
      final isNumberChanged =
          _numberCtrl.text.trim() != widget.initialData?.accountNumber;
      final isDescChanged =
          _descCtrl.text.trim() != widget.initialData?.description;
      final isActiveChanged = _isActive != widget.initialData?.isActive;
      final isDefaultChanged = _isDefault != widget.initialData?.isDefault;
      requestData = AccountRequestEntity(
        accountName: isNameChanged ? _nameCtrl.text.trim() : null,
        accountNumber: isNumberChanged ? _numberCtrl.text.trim() : null,
        description: isDescChanged ? _descCtrl.text.trim() : null,
        accountType:
            widget.initialData?.accountType ??
            AccountType.bank, // default to bank if not provided
        isActive: isActiveChanged ? _isActive : null,
        isDefault: isDefaultChanged ? _isDefault : null,
      );
    } else {
      // add mode
      requestData = AccountRequestEntity(
        accountName: _nameCtrl.text.trim(),
        accountNumber: _numberCtrl.text.trim().isEmpty
            ? null
            : _numberCtrl.text.trim(),
        description: _descCtrl.text.trim().isEmpty
            ? null
            : _descCtrl.text.trim(),
      );
    }
    Navigator.of(context).pop(requestData);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Header ─────────────────────────────────────────────────
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _isEditMode
                            ? Icons.edit_outlined
                            : Icons.account_balance_wallet_outlined,
                        size: 20,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isEditMode ? 'Edit account' : 'Add account',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            _isEditMode
                                ? 'Update your financial account details'
                                : 'Link a new financial account',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 20),
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Close',
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                const _DialogDivider(),
                const SizedBox(height: 20),

                // ── Account name (required) ─────────────────────────────────
                const _FieldLabel(label: 'Account name', required: true),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: _nameCtrl,
                  textCapitalization: TextCapitalization.words,
                  hintText: 'e.g. Federal/SBI Account',
                  prefixIcon: const Icon(Icons.label_outline),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Account name is required';
                    }
                    if (v.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // ── Account number (optional) ───────────────────────────────
                const _FieldLabel(label: 'Account number', required: false),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: _numberCtrl,
                  keyboardType: TextInputType.number,
                  textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  hintText: 'Optional',
                  prefixIcon: const Icon(Icons.tag_outlined),
                  validator: null,
                ),

                const SizedBox(height: 16),

                // ── Description (optional) ──────────────────────────────────
                const _FieldLabel(label: 'Description', required: false),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: _descCtrl,
                  maxLines: 3,
                  minLines: 2,
                  hintText: 'Optional — add any notes about this account',
                  validator: null,
                ),

                if (_isEditMode) ...[
                  const SizedBox(height: 20),
                  const _DialogDivider(),
                  const SizedBox(height: 8),
                  Text(
                    'Status & defaults',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _ToggleTile(
                    title: 'Active',
                    subtitle: 'Account is available for transactions',
                    value: _isActive,
                    icon: Icons.check_circle_outline,
                    onChanged: (v) => setState(() => _isActive = v),
                  ),
                  _ToggleTile(
                    title: 'Default account',
                    subtitle: 'Mark as the preferred account',
                    value: _isDefault,
                    icon: Icons.bookmark_outline,
                    onChanged: (v) => setState(() => _isDefault = v),
                  ),
                ],

                const SizedBox(height: 24),

                // ── Actions ─────────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(_isEditMode ? 'Save changes' : 'Add account'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Supporting private widgets ─────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.required});

  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        if (required) ...[
          const SizedBox(width: 3),
          Text(
            '*',
            style: TextStyle(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final IconData icon;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(title, style: theme.textTheme.bodyMedium),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      value: value,
      onChanged: onChanged,
      dense: true,
    );
  }
}

class _DialogDivider extends StatelessWidget {
  const _DialogDivider();

  @override
  Widget build(BuildContext context) => Divider(
    height: 1,
    thickness: 0.5,
    color: Theme.of(context).colorScheme.outlineVariant,
  );
}
