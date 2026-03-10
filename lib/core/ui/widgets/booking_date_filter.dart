import 'package:bookie_buddy_web/core/constants/enums/invoice_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_custom_bottom_sheet.dart';
import 'package:bookie_buddy_web/utils/app_date_utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///Bottom Sheet for Filter (Dialog on Web)
Future<void> showDateFilterBottomSheet({
  required BuildContext context,
  double initialChildSize = 0.5,
  required Function(DateTime? startDate, DateTime? endDate) onDateFilterChanged,
  DateTime? initialStartDate,
  DateTime? initialEndDate,

  //
  bool isGeneratePdf = false,
  bool showCheckboxOptions = false,
  List<CheckboxOption>? checkboxOptions,
  Function(List<CheckboxOption>)? onCheckboxChanged,
  String? title,
  void Function(bool, DateTime?, DateTime?)? onApplyButtonPressed,
  String? buttonText,
}) async {
  // Show dialog on web, bottom sheet on mobile
  if (kIsWeb) {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            child: Padding(
              padding: 24.padding,
              child: BookingDateFilter(
                buttonText: buttonText,
                isGeneratePdf: isGeneratePdf,
                onDateFilterChanged: (startDate, endDate) {
                  onDateFilterChanged(startDate, endDate);
                  // Don't auto-close if checkboxes are shown
                  if (!showCheckboxOptions) {
                    Navigator.pop(context);
                  }
                },
                initialStartDate: initialStartDate,
                initialEndDate: initialEndDate,
                showCheckboxOptions: showCheckboxOptions,
                checkboxOptions: checkboxOptions,
                onCheckboxChanged: onCheckboxChanged,
                title: title,
                onApplyFilter: onApplyButtonPressed,
              ),
            ),
          ),
        ),
      ),
    );
  } else {
    await showCustomBottomSheet(
      context,
      initialChildSize: initialChildSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: 16.padding,
            child: BookingDateFilter(
              buttonText: buttonText,
              isGeneratePdf: isGeneratePdf,
              onDateFilterChanged: (startDate, endDate) {
                onDateFilterChanged(startDate, endDate);
                // Don't auto-close if checkboxes are shown
                if (!showCheckboxOptions) {
                  Navigator.pop(context);
                }
              },
              initialStartDate: initialStartDate,
              initialEndDate: initialEndDate,
              showCheckboxOptions: showCheckboxOptions,
              checkboxOptions: checkboxOptions,
              onCheckboxChanged: onCheckboxChanged,
              title: title,
              onApplyFilter: onApplyButtonPressed,
            ),
          ),
        ],
      ),
    );
  }
}

///Date Filter
class BookingDateFilter extends StatefulWidget {
  final Function(DateTime? startDate, DateTime? endDate) onDateFilterChanged;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  //
  final bool isGeneratePdf;
  final bool showCheckboxOptions;
  final List<CheckboxOption>? checkboxOptions;
  final Function(List<CheckboxOption>)? onCheckboxChanged;
  final String? title;
  final void Function(bool isExcel, DateTime? startDate, DateTime? endDate)?
      onApplyFilter;
  final String? buttonText;

  const BookingDateFilter({
    required this.onDateFilterChanged,
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    this.checkboxOptions,
    this.onCheckboxChanged,
    this.showCheckboxOptions = false,
    this.title,
    this.onApplyFilter,
    this.buttonText,
    required this.isGeneratePdf,
  });

  @override
  State<BookingDateFilter> createState() => _BookingDateFilterState();
}

class _BookingDateFilterState extends State<BookingDateFilter> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateFilterType _filterType = DateFilterType.range;
  List<CheckboxOption> _checkboxOptions = [];
  var selectedRadioGroupValueNotifier = ValueNotifier<InvoiceType>(
    InvoiceType.pdf,
  );

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;

    _checkboxOptions =
        widget.checkboxOptions?.map(CheckboxOption.copy).toList() ?? [];
  }

  @override
  void dispose() {
    selectedRadioGroupValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: kIsWeb ? EdgeInsets.zero : 16.padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: kIsWeb
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.date_range, color: AppColors.purple, size: 20.sp),
                8.width,
                Text(
                  widget.isGeneratePdf ? 'Select Date' : 'Filter by Date',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                if (_startDate != null || _endDate != null)
                  TextButton(
                    onPressed: _clearFilter,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      minimumSize: const Size(60, 36),
                    ),
                    child: Text(
                      'Clear',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                if (kIsWeb && !widget.showCheckboxOptions)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Filter Type Selection
            Row(
              children: [
                Expanded(
                  child: _FilterTypeChip(
                    label: 'Single Date',
                    isSelected: _filterType == DateFilterType.single,
                    onTap: () =>
                        setState(() => _filterType = DateFilterType.single),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _FilterTypeChip(
                    label: 'Date Range',
                    isSelected: _filterType == DateFilterType.range,
                    onTap: () =>
                        setState(() => _filterType = DateFilterType.range),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Date Selection
            if (_filterType == DateFilterType.single)
              _buildSingleDateSelector()
            else
              _buildDateRangeSelector(),

            // Quick Filter Options
            const SizedBox(height: 16),
            Text(
              widget.isGeneratePdf ? 'Quick Selection' : 'Quick Filters',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _QuickFilterChip(
                  label: 'Today',
                  isSelected: _startDate == _endDate &&
                      _startDate == AppDateUtils.today(),
                  onTap: () => _setQuickFilter(
                      AppDateUtils.today(), AppDateUtils.today()),
                ),
                _QuickFilterChip(
                  label: 'This Week',
                  isSelected: _startDate == AppDateUtils.weekStart() &&
                      _endDate == AppDateUtils.weekEnd(),
                  onTap: () => _setQuickFilter(
                    AppDateUtils.weekStart(),
                    AppDateUtils.weekEnd(),
                  ),
                ),
                _QuickFilterChip(
                  label: 'This Month',
                  isSelected: _startDate == AppDateUtils.monthStart() &&
                      _endDate == AppDateUtils.monthEnd(),
                  onTap: () => _setQuickFilter(
                    AppDateUtils.monthStart(),
                    AppDateUtils.monthEnd(),
                  ),
                ),
                _QuickFilterChip(
                  label: 'Last 7 Days',
                  isSelected: _startDate == AppDateUtils.last7Days() &&
                      _endDate == AppDateUtils.today(),
                  onTap: () => _setQuickFilter(
                    AppDateUtils.last7Days(),
                    AppDateUtils.today(),
                  ),
                ),
                _QuickFilterChip(
                  label: 'Last 30 Days',
                  isSelected: _startDate == AppDateUtils.last30Days() &&
                      _endDate == AppDateUtils.today(),
                  onTap: () => _setQuickFilter(
                    AppDateUtils.last30Days(),
                    AppDateUtils.today(),
                  ),
                ),
              ],
            ),

            // Checkbox Options (conditionally shown)
            if (widget.showCheckboxOptions) ...[
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Select type',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder(
                valueListenable: selectedRadioGroupValueNotifier,
                builder: (context, selectedValue, _) => RadioGroup(
                  onChanged: (value) {
                    if (value != null)
                      selectedRadioGroupValueNotifier.value = value;
                  },
                  groupValue: selectedValue,
                  child: Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: RadioListTile.adaptive(
                          value: InvoiceType.pdf,
                          title: const Text('PDF'),
                          selected: selectedValue == InvoiceType.pdf,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile.adaptive(
                          value: InvoiceType.excel,
                          title: const Text('Excel'),
                          selected: selectedValue == InvoiceType.excel,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title ?? 'Checkbox Options',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _checkboxOptions.map(_buildCheckboxTile).toList(),
              ),

              // Apply Button when checkboxes are shown
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onCheckboxChanged?.call(_checkboxOptions);
                    widget.onApplyFilter?.call(
                      selectedRadioGroupValueNotifier.value ==
                          InvoiceType.excel,
                      _startDate,
                      _endDate,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(widget.buttonText ?? 'Apply Filters'),
                ),
              ),
            ],
          ],
        ),
      );

  //?====================================================?//

  Widget _buildCheckboxTile(CheckboxOption option) => CheckboxListTile(
        dense: true,
        title: Text(option.label, style: TextStyle(fontSize: 14.sp)),
        subtitle: option.subtitle != null
            ? Text(
                option.subtitle!,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              )
            : null,
        value: option.isSelected,
        onChanged: (value) {
          setState(() {
            option.isSelected = value ?? false;

            final isPending = option.id == LedgerType.pendings.value;
            final isSecurity = option.id == LedgerType.security.value;
            final isBookings = option.id == LedgerType.bookings.value;
            final isSales = option.id == LedgerType.sales.value;
            final isPaymentsOrExpenses =
                option.id == LedgerType.payments.value ||
                    option.id == LedgerType.expense.value;

            if (isPending && option.isSelected) {
              // unselect everything except 'pending'
              for (final option in _checkboxOptions) {
                if (option.id != LedgerType.pendings.value)
                  option.isSelected = false;
              }
            } else if (isSecurity && option.isSelected) {
              // unselect everything except 'security'
              for (final option in _checkboxOptions) {
                if (option.id != LedgerType.security.value)
                  option.isSelected = false;
              }
            } else if (isBookings && option.isSelected) {
              // unselect everything except 'bookings'
              for (final option in _checkboxOptions) {
                if (option.id != LedgerType.bookings.value)
                  option.isSelected = false;
              }
            } else if (isSales && option.isSelected) {
              // unselect everything except 'sales'
              for (final option in _checkboxOptions) {
                if (option.id != LedgerType.sales.value)
                  option.isSelected = false;
              }
            } else if (isPaymentsOrExpenses && option.isSelected) {
              // unselect pending and security if payments/expenses selected
              for (final option in _checkboxOptions) {
                if (option.id == LedgerType.pendings.value ||
                    option.id == LedgerType.security.value ||
                    option.id == LedgerType.bookings.value ||
                    option.id == LedgerType.sales.value) {
                  option.isSelected = false;
                }
              }
            }
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        activeColor: AppColors.purple,
      );

  Widget _buildSingleDateSelector() => GestureDetector(
        onTap: () => _selectSingleDate(context),
        child: Container(
          padding: 12.padding,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
              const SizedBox(width: 12),
              Text(
                _startDate?.format() ?? 'Select Date',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: _startDate != null ? Colors.black : Colors.grey,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      );

  Widget _buildDateRangeSelector() => Column(
        children: [
          // Start Date
          GestureDetector(
            onTap: () => _selectStartDate(context),
            child: Container(
              padding: 12.padding,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 20, color: Colors.grey),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From Date',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      Text(
                        _startDate?.format() ?? 'Select Start Date',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color:
                              _startDate != null ? Colors.black : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // End Date
          GestureDetector(
            onTap: () => _selectEndDate(context),
            child: Container(
              padding: 12.padding,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 20, color: Colors.grey),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To Date',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      Text(
                        _endDate?.format() ?? 'Select End Date',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: _endDate != null ? Colors.black : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      );

  Future<void> _selectSingleDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _startDate = date;
        _endDate = date;
      });
      widget.onDateFilterChanged(_startDate, _endDate);
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: _endDate ?? DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _startDate = date);
      if (_endDate != null) {
        widget.onDateFilterChanged(_startDate, _endDate);
      }
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _endDate = date);
      if (_startDate != null) {
        widget.onDateFilterChanged(_startDate, _endDate);
      }
    }
  }

  void _setQuickFilter(DateTime start, DateTime end) {
    setState(() {
      _startDate = start;
      _endDate = end;
      _filterType = DateFilterType.range;
    });
    widget.onDateFilterChanged(_startDate, _endDate);
  }

  void _clearFilter() {
    setState(() {
      _startDate = null;
      _endDate = null;
    });
    widget.onDateFilterChanged(null, null);
  }
}

class _FilterTypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterTypeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.purple : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.purple : Colors.grey.shade300,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ),
      );
}

class _QuickFilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const _QuickFilterChip({
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.purple : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: isSelected ? AppColors.white : Colors.grey.shade700,
            ),
          ),
        ),
      );
}

// 3. Enum for filter types
enum DateFilterType { single, range }

// Checkbox option model
class CheckboxOption {
  final String label;
  final String? subtitle;
  final String id;
  bool isSelected;

  CheckboxOption({
    required this.label,
    required this.id,
    this.subtitle,
    this.isSelected = false,
  });

  static CheckboxOption copy(CheckboxOption option) => CheckboxOption(
        label: option.label,
        id: option.id,
        subtitle: option.subtitle,
        isSelected: option.isSelected,
      );
}
