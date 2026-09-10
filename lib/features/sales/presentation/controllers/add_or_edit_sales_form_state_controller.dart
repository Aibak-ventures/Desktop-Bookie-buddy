import 'package:bookie_buddy_shared/core/core/common/entities/applied_tax_entity/applied_tax_entity.dart';
import 'package:bookie_buddy_shared/core/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/sales/presentation/common/helpers/sales_split_payment.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_shared/core/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_shared/core/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Add or Edit Sales screen controllers and keys
class AddOrEditSalesFormStateController {
  // Form key
  final formKey = GlobalKey<FormState>();

  final focusGuard = FocusNode(debugLabel: 'AddOrEditSalesFocusGuard');

  // Date
  final saleDateController = TextEditingController();

  // Client
  final clientPhoneController = TextEditingController();

  // Other
  final placeController = TextEditingController();
  final descriptionController = TextEditingController();
  final staffNameController = TextEditingController();

  // Amount
  final discountController = TextEditingController();

  // Notifiers
  final selectedProductsNotifier = ValueNotifier<List<ProductSelectedEntity>>(
    [],
  );

  final stockCountDecreaseNotifier = ValueNotifier<bool>(true);

  final selectedAccountNotifier = ValueNotifier<AccountEntity?>(null);

  final isSharingPdfToWhatsAppNotifier = ValueNotifier<bool>(false);

  // ---- Cash/bank split payment ----
  // Whether the sale's payable total is split across a cash and a
  // bank/UPI account instead of a single account. Locked once a sale
  // exists — see [isSplitToggleLocked] — so an existing single-payment
  // sale can't be turned into a split one (and vice versa) from the edit
  // screen; that avoids edge cases (e.g. a split left with one leg at 0)
  // that are deliberately out of scope.
  bool isSplitPayment = false;

  /// True once initialized for an existing sale — the split/merge toggle
  /// is hidden while this is true so a sale's payment shape can't change
  /// after creation.
  bool isSplitToggleLocked = false;

  final splitCashAmountController = TextEditingController();
  final splitBankAmountController = TextEditingController();
  AccountEntity? selectedCashAccount;
  AccountEntity? selectedBankAccount;

  // Original payment ids/account ids from the sale being edited — used as
  // fallbacks so an unchanged leg's account_id is still resolved and sent
  // (the backend rejects a payments entry missing account_id), and so an
  // unchanged leg updates its existing payment record instead of creating
  // a new one.
  int? _originalSinglePaymentId;
  int? _originalSingleAccountId;
  int? _originalCashPaymentId;
  int? _originalCashAccountId;
  int _originalCashAmount = 0;
  int? _originalBankPaymentId;
  int? _originalBankAccountId;
  int _originalBankAmount = 0;

  /// The account id each leg originally had — pass to
  /// [SplitAdvancePaymentFields.cashInitialAccountId]/
  /// `bankInitialAccountId` (and the single selector's `initialAccountId`)
  /// so an existing sale's picker(s) come up pre-selected instead of blank.
  int? get originalCashAccountId => _originalCashAccountId;
  int? get originalBankAccountId => _originalBankAccountId;
  int? get originalSingleAccountId => _originalSingleAccountId;

  /// Guards against listener feedback loops while auto-balancing the two
  /// split amount fields against each other.
  bool _isBalancingSplit = false;

  /// The last computed payable total the split fields were balanced
  /// against — used to detect an actual total change (vs. e.g. a text
  /// field only gaining/losing focus) so split amounts are cleared only
  /// when the total genuinely changes.
  int? _lastKnownTotal;

  // In single (non-split) mode there is no amount field at all — the sale
  // is always paid in full — so `cashAmount` has to fall back to the last
  // known payable total rather than the (always-empty) split text field,
  // or `buildPayments()` would see a zero total and drop the payment
  // entirely, silently ignoring an account change.
  SalesSplitPayment get salesSplitPayment => SalesSplitPayment(
    isSplit: isSplitPayment,
    cashAmount: isSplitPayment
        ? (splitCashAmountController.text.trim().toIntOrNull() ?? 0)
        : (_lastKnownTotal ?? 0),
    bankAmount: splitBankAmountController.text.trim().toIntOrNull() ?? 0,
    cashAccount: selectedCashAccount,
    bankAccount: selectedBankAccount,
    cashPaymentId: _originalCashPaymentId,
    bankPaymentId: _originalBankPaymentId,
    singlePaymentId: _originalSinglePaymentId,
  );

  /// True when the payment differs from what the sale being edited
  /// originally had — either leg's amount/account for a split sale, or the
  /// single account otherwise. Drives both the "nothing changed" gate in
  /// [buildRequest] and the edit screen's unsaved-changes check.
  bool get hasPaymentChanged {
    final split = salesSplitPayment;
    if (isSplitPayment) {
      return split.cashAmount != _originalCashAmount ||
          split.bankAmount != _originalBankAmount ||
          (selectedCashAccount?.id != null &&
              selectedCashAccount!.id != _originalCashAccountId) ||
          (selectedBankAccount?.id != null &&
              selectedBankAccount!.id != _originalBankAccountId);
    }
    return selectedAccountNotifier.value?.id != null &&
        selectedAccountNotifier.value!.id != _originalSingleAccountId;
  }

  /// Wire this to whichever split-amount field the user just edited so the
  /// other one is kept balanced to [total] automatically.
  void onSplitCashAmountChanged(int total) =>
      _autoBalance(edited: splitCashAmountController, total: total);

  void onSplitBankAmountChanged(int total) =>
      _autoBalance(edited: splitBankAmountController, total: total);

  void _autoBalance({
    required TextEditingController edited,
    required int total,
  }) {
    if (_isBalancingSplit) return;
    final other = edited == splitCashAmountController
        ? splitBankAmountController
        : splitCashAmountController;
    final safeTotal = total < 0 ? 0 : total;
    final editedAmount = edited.text.trim().toIntOrNull() ?? 0;
    final clamped = editedAmount.clamp(0, safeTotal);
    _isBalancingSplit = true;
    // Reclamp the edited field itself too, not just the other one — an
    // out-of-range typed value (e.g. exceeding the total) would otherwise
    // leave the two legs summing to something other than the total.
    if (clamped != editedAmount) edited.text = clamped.toString();
    other.text = (safeTotal - clamped).toString();
    _isBalancingSplit = false;
  }

  /// Call whenever the computed payable total may have changed (products,
  /// discount, tax). Clears both split amount fields only when the total
  /// actually changed from what they were last balanced against — never on
  /// an event that didn't actually move the total.
  void handleTotalMayHaveChanged(int total) {
    if (_lastKnownTotal != null && _lastKnownTotal != total) {
      splitCashAmountController.clear();
      splitBankAmountController.clear();
    }
    _lastKnownTotal = total;
  }

  void dispose() {
    saleDateController.dispose();
    // nameController.dispose();
    clientPhoneController.dispose();
    // phone2Controller.dispose();
    placeController.dispose();
    discountController.dispose();
    descriptionController.dispose();
    staffNameController.dispose();
    selectedProductsNotifier.dispose();
    // isClientSearchEnabledNotifier.dispose();
    stockCountDecreaseNotifier.dispose();
    selectedAccountNotifier.dispose();
    isSharingPdfToWhatsAppNotifier.dispose();
    splitCashAmountController.dispose();
    splitBankAmountController.dispose();
    focusGuard.dispose();
  }

  void setInitialValues(SaleDetailsEntity saleDetails, BuildContext context) {
    focusGuard.skipTraversal = true;
    saleDateController.text = saleDetails.saleDate.formatToUiDate();

    staffNameController.text = saleDetails.staffName ?? 'Staff Name';

    // nameController.text = saleDetails.client.name;
    // accountId is passed to AccountSelectionField via initialAccountId for auto-selection
    clientPhoneController.text = saleDetails.clientPhone.toString();
    // if (saleDetails.client.phone2 != null) {
    //   phone2Controller.text = saleDetails.client.phone2.toString();
    // }
    if (saleDetails.address.isNotNullOrEmpty) {
      placeController.text = saleDetails.address;
    }
    descriptionController.text = saleDetails.description;
    if (saleDetails.discountAmount > 0)
      discountController.text = saleDetails.discountAmount.toString();

    // context.read<ClientCubit>().selectClient(saleDetails.client);

    // isClientSearchEnabledNotifier.value = true;

    selectedProductsNotifier.value = saleDetails.products
        .map(
          (e) => ProductSelectedEntity(
            amount: e.price,
            quantity: e.quantity,
            // fabricLength: e.fabricLength,
            variant: ProductInfoEntity(
              id: e.id,
              productId: e.productId,
              variantId: e.variantId,
              name: e.name,
              productImage: e.image,
              thumbnailImage: e.thumbnailImage,
              fabricLength: 0,
              quantity: e.quantity,
              amount: e.price,
              category: e.category,
              color: e.color,
              mainServiceType: e.mainServiceType,
              model: e.model,
              variantAttribute: e.variantAttribute,
            ),
          ),
        )
        .toList();

    // Split/merge is locked for an existing sale — it stays editable only
    // in the payment shape it was created with.
    isSplitToggleLocked = true;
    final payments = saleDetails.payments;
    isSplitPayment = payments.length > 1;
    if (isSplitPayment) {
      // Classify by `paymentMethod` (cash vs UPI/bank) when the API sends
      // it; an account-name guess would be fragile (nothing stops an
      // account literally named e.g. "Bank of Cash Corp"), so when the
      // method is missing/ambiguous for both legs, fall back to a stable
      // positional assignment (first entry → cash slot, second → bank
      // slot) instead of guessing from the name.
      final cashIndex = payments.indexWhere((p) => p.paymentMethod.isCash);
      final bankIndex = payments.indexWhere((p) => !p.paymentMethod.isCash);
      final resolvedCashIndex = cashIndex != -1
          ? cashIndex
          : (bankIndex == 0 ? 1 : 0);
      final resolvedBankIndex = resolvedCashIndex == 0 ? 1 : 0;
      final cashLeg = payments[resolvedCashIndex];
      final bankLeg = payments[resolvedBankIndex];
      _originalCashAmount = cashLeg.amount;
      _originalBankAmount = bankLeg.amount;
      splitCashAmountController.text = _originalCashAmount.toString();
      splitBankAmountController.text = _originalBankAmount.toString();
      _originalCashPaymentId = cashLeg.id;
      _originalCashAccountId = cashLeg.accountId;
      _originalBankPaymentId = bankLeg.id;
      _originalBankAccountId = bankLeg.accountId;
    } else if (payments.isNotEmpty) {
      _originalSinglePaymentId = payments.first.id;
      _originalSingleAccountId = payments.first.accountId;
    }
  }

  /// The sale's payable total (products − discount + tax) from the current
  /// form values and the sale's frozen tax snapshot. Pure — does not touch
  /// the split fields; use [recomputePayableTotalAndClearSplitIfChanged] to
  /// also clear them on an actual change.
  int computePayableTotal(SaleDetailsEntity saleDetails) {
    final products = selectedProductsNotifier.value;
    final productTotal = products.fold<int>(
      0,
      (sum, p) => sum + (p.amount * p.quantity),
    );
    final discountAmount = discountController.text.trim().toIntOrNull() ?? 0;
    final taxSummary = saleDetails.appliedTaxes.calculateTaxSummary(
      productTotal: productTotal.toDouble(),
      discountAmount: discountAmount.toDouble(),
    );
    final total =
        productTotal - discountAmount + taxSummary.additionalTaxAmount.round();
    return total > 0 ? total : 0;
  }

  /// Recomputes the payable total and clears the split fields if it
  /// actually moved. Wire this to whatever listens for product/discount
  /// changes on the edit screen.
  int recomputePayableTotalAndClearSplitIfChanged(
    SaleDetailsEntity saleDetails,
  ) {
    final total = computePayableTotal(saleDetails);
    handleTotalMayHaveChanged(total);
    return total;
  }

  SalesRequestEntity? buildRequest({
    required BuildContext context,
    required SaleDetailsEntity? saleDetails,
  }) {
    if (!(formKey.currentState?.validate() ?? true)) {
      context.showSnackBar(
        'Please fill all required fields',
        title: 'Form Error',
        isError: true,
      );
      return null;
    }
    final isEditMode = saleDetails != null;
    final selectedStaff = context.read<StaffSearchCubit>().state.selectedStaff;
    if (isEditMode) {
      if (saleDetails.staffId != null && selectedStaff == null) {
        context.showSnackBar(
          'Please select a staff',
          title: 'Staff Required',
          isError: true,
        );
        return null;
      }
    } else {
      if (selectedStaff == null) {
        context.showSnackBar(
          'Please select a staff',
          title: 'Staff Required',
          isError: true,
        );
        return null;
      }
    }

    if (selectedProductsNotifier.value.isEmpty) {
      context.showSnackBar(
        'Select at least one product',
        title: 'Product Required',
        isError: true,
      );
      return null;
    }
    final totalAmount = selectedProductsNotifier.value.fold(
      0,
      (p, e) => p + (e.amount * e.quantity),
    );
    final discountAmount = discountController.text.trim().toIntOrNull() ?? 0;
    if (discountAmount >= totalAmount) {
      context.showSnackBar(
        'Discount cannot be greater than total amount',
        title: 'Amount Error',
        isError: true,
      );
      return null;
    }

    final split = salesSplitPayment;
    if (isSplitPayment) {
      if (!split.hasAmount) {
        context.showSnackBar(
          'Please enter cash and/or bank/UPI split amounts',
          title: 'Payment Required',
          isError: true,
        );
        return null;
      }
      // Defense in depth — the two fields should already sum to the total
      // by construction (auto-balanced on every edit), but guard against
      // this ever drifting (e.g. a future code path that edits them
      // directly) rather than silently sending a mismatched split.
      if (saleDetails != null &&
          split.total != computePayableTotal(saleDetails)) {
        context.showSnackBar(
          'Split amounts must add up to the total payable amount',
          title: 'Amount Error',
          isError: true,
        );
        return null;
      }
      if (split.cashAmount > 0 &&
          selectedCashAccount == null &&
          _originalCashAccountId == null) {
        context.showSnackBar(
          'Please select a cash account',
          title: 'Payment Option Required',
          isError: true,
        );
        return null;
      }
      if (split.bankAmount > 0 &&
          selectedBankAccount == null &&
          _originalBankAccountId == null) {
        context.showSnackBar(
          'Please select a bank/UPI account',
          title: 'Payment Option Required',
          isError: true,
        );
        return null;
      }
    } else if (selectedAccountNotifier.value?.id == null &&
        _originalSingleAccountId == null) {
      context.showSnackBar(
        'Please select a payment option',
        title: 'Payment Option Required',
        isError: true,
      );
      return null;
    }

    // Fetch original sale details from the ancestor widget
    final original = saleDetails;

    if (original != null) {
      // Current form values
      final currentSaleDate = saleDateController.text.formatToUiDate();
      // Compare sale date
      final saleDateChanged =
          currentSaleDate != original.saleDate.formatToUiDate();

      // Compare client
      final isClientPhoneChanged =
          clientPhoneController.text.trim() != original.clientPhone.toString();

      final isStaffChanged = selectedStaff?.id != original.staffId;

      // Compare address
      final addressChanged =
          placeController.text.trim() != (original.address.trim());

      // Compare description
      final descriptionChanged =
          descriptionController.text.trim() != original.description.trim();

      // Compare discount
      final discountAmount = discountController.text.trim().toIntOrNull() ?? 0;
      final discountChanged = discountAmount != original.discountAmount;
      final paymentChanged = hasPaymentChanged;

      // Compare products (id + variantId + quantity + amount)
      bool productsChanged = false;
      final newProducts = selectedProductsNotifier.value;
      if (newProducts.length != original.products.length) {
        productsChanged = true;
      } else {
        for (final p in newProducts) {
          ProductSaleInfoEntity? match;
          for (final op in original.products) {
            if (op.id == p.variant.id && op.variantId == p.variant.variantId) {
              match = op;
              break;
            }
          }

          if (match == null ||
              match.quantity != p.quantity ||
              match.price != p.amount) {
            productsChanged = true;
            break;
          }
        }
      }

      debugPrint('isProductsChanged: $productsChanged');

      // If nothing changed -> pop with snackbar
      if (!(saleDateChanged ||
          isClientPhoneChanged ||
          addressChanged ||
          descriptionChanged ||
          discountChanged ||
          paymentChanged ||
          isStaffChanged ||
          productsChanged)) {
        context
          ..pop()
          ..showSnackBar('Nothing to change');
        return null;
      }

      // CRITICAL FIX: Always send all products when any field has changed
      // This ensures the backend receives the complete product list.
      // Payments work the same way: whenever anything changed, every entry
      // is resent with its account_id resolved (falling back to the leg's
      // original account when the user didn't touch it) — never omitted,
      // since the backend rejects a payments entry missing account_id.
      return SalesRequestEntity(
        id: original.id,
        saleDate: saleDateChanged ? currentSaleDate : null,
        staffId: isStaffChanged ? selectedStaff?.id : null,
        clientPhone: isClientPhoneChanged
            ? clientPhoneController.text.trim()
            : null,
        address: addressChanged ? placeController.text.trim() : null,
        // Send all current products if products changed OR if any other field changed
        // This prevents partial updates that might clear products
        products: newProducts.isNotEmpty ? newProducts : null,

        description: descriptionChanged
            ? descriptionController.text.trim()
            : null,
        discountAmount: discountChanged ? discountAmount : null,

        payments: split.buildPayments(
          singleAccount: selectedAccountNotifier.value,
          singleAccountIdFallback: _originalSingleAccountId,
          cashAccountIdFallback: _originalCashAccountId,
          bankAccountIdFallback: _originalBankAccountId,
        ),
      );
    }
    return SalesRequestEntity(
      saleDate: saleDateController.text.formatToUiDate(),
      staffId: selectedStaff?.id,
      clientPhone: clientPhoneController.text.trim(),
      address: placeController.text.trim(),
      products: selectedProductsNotifier.value,
      stockCountDecrease: stockCountDecreaseNotifier.value,
      description: descriptionController.text.trim(),
      discountAmount: discountAmount,
      // Not sent — sales have no partial-payment/credit workflow, so the
      // backend always settles a created sale as fully paid on its own
      // (same as mobile, which never sends this field either). Computing
      // it client-side risks silently drifting from whatever the backend
      // actually does with discount/tax ordering.
      payments: split.buildPayments(
        singleAccount: selectedAccountNotifier.value,
      ),
      sendPdfToWhatsApp: isSharingPdfToWhatsAppNotifier.value,
    );
  }
}
