/// A customizable date filter widget with support for single date, date range,
/// quick filters, checkboxes, and export options (PDF/Excel).
///
/// Features:
/// - Single date or date range selection
/// - Quick filter presets (Today, This Week, Last 7 Days, etc.)
/// - Optional checkbox filters with custom selection strategies
/// - Optional PDF/Excel export type selection
/// - Fully customizable through callbacks and options
///
/// Example usage:
/// ```dart
/// showDateFilterBottomSheet(
///   context: context,
///   onDateFilterChanged: (start, end) => _applyDateFilter(start, end),
///   showCheckboxOptions: true,
///   checkboxOptions: [
///     CheckboxOption(id: 'sales', label: 'Sales'),
///     CheckboxOption(id: 'expenses', label: 'Expenses'),
///   ],
///   selectionStrategy: ExclusiveCheckboxStrategy(['sales']),
/// );
/// ```
import 'package:bookie_buddy_web/core/common/widgets/show_custom_bottom_sheet.dart';
import 'package:bookie_buddy_web/core/constants/app_constants.dart';
import 'package:bookie_buddy_web/core/constants/enums/ledger_enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/app_date_utils.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shows a bottom sheet with date filtering options.
///
/// Parameters:
/// - [context]: BuildContext for showing the bottom sheet
/// - [onDateFilterChanged]: Callback when dates change (auto-closes if no checkboxes)
/// - [initialStartDate], [initialEndDate]: Pre-selected dates
/// - [isGeneratePdf]: Shows export type selection (PDF/Excel)
/// - [showCheckboxOptions]: Shows additional checkbox filters
/// - [checkboxOptions]: List of checkbox options to display
/// - [onCheckboxChanged]: Callback when checkboxes change
/// - [selectionStrategy]: Strategy for handling checkbox selection logic
/// - [title]: Custom title for checkbox section
/// - [onApplyButtonPressed]: Callback for Apply button (when checkboxes shown)
/// - [buttonText]: Custom text for Apply button
/// - [initialChildSize]: Initial size of bottom sheet (0.0 to 1.0)
Future<void> showDateFilterBottomSheet({
  required BuildContext context,
  double initialChildSize = 0.5,
  required void Function(DateTime? startDate, DateTime? endDate)
  onDateFilterChanged,
  DateTime? initialStartDate,
  DateTime? initialEndDate,
  bool isGeneratePdf = false,
  bool showCheckboxOptions = false,
  List<CheckboxOption>? checkboxOptions,
  Function(List<CheckboxOption> checkboxes)? onCheckboxChanged,
  CheckboxSelectionStrategy? selectionStrategy,
  String? title,
  void Function(bool, DateTime?, DateTime?)? onApplyButtonPressed,
  String? buttonText,
}) async {
  await showCustomBottomSheet(
    context,
    initialChildSize: initialChildSize,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: 16.padding,
          child: CustomDateFilterWidget(
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
            selectionStrategy: selectionStrategy,
            title: title,
            onApplyFilter: onApplyButtonPressed,
          ),
        ),
      ],
    ),
  );
}

Future<void> showDateFilterDialog({
  required BuildContext context,
  double initialChildSize = 0.5,
  required void Function(DateTime? startDate, DateTime? endDate)
  onDateFilterChanged,
  DateTime? initialStartDate,
  DateTime? initialEndDate,
  bool isGeneratePdf = false,
  bool showCheckboxOptions = false,
  List<CheckboxOption>? checkboxOptions,
  Function(List<CheckboxOption> checkboxes)? onCheckboxChanged,
  CheckboxSelectionStrategy? selectionStrategy,
  String? title,
  void Function(bool, DateTime?, DateTime?)? onApplyButtonPressed,
  String? buttonText,
}) async {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: CustomDateFilterWidget(
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
              selectionStrategy: selectionStrategy,
              title: title,
              onApplyFilter: onApplyButtonPressed,
            ),
          ),
        ),
      ),
    ),
  );
}

/// Main date filter widget with configurable options.
///
/// Provides a comprehensive date filtering UI with:
/// - Single date or date range selection
/// - Quick filter shortcuts
/// - Optional checkbox filters with custom selection strategies
/// - Optional PDF/Excel export type selection
class CustomDateFilterWidget extends StatefulWidget {
  /// Callback when date filter changes (called on every date selection)
  final Function(DateTime? startDate, DateTime? endDate) onDateFilterChanged;

  /// Initial start date for the filter
  final DateTime? initialStartDate;

  /// Initial end date for the filter
  final DateTime? initialEndDate;

  /// Whether to show PDF/Excel export type selection
  final bool isGeneratePdf;

  /// Whether to show checkbox options section
  final bool showCheckboxOptions;

  /// List of checkbox options to display
  final List<CheckboxOption>? checkboxOptions;

  /// Callback when checkbox selection changes
  final Function(List<CheckboxOption>)? onCheckboxChanged;

  /// Strategy for handling checkbox selection logic (mutual exclusivity, etc.)
  final CheckboxSelectionStrategy? selectionStrategy;

  /// Custom title for the checkbox section
  final String? title;

  /// Callback for the Apply button (called with isExcel, startDate, endDate)
  final void Function(bool isExcel, DateTime? startDate, DateTime? endDate)?
  onApplyFilter;

  /// Custom text for the Apply button
  final String? buttonText;

  const CustomDateFilterWidget({
    required this.onDateFilterChanged,
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    this.checkboxOptions,
    this.onCheckboxChanged,
    this.selectionStrategy,
    this.showCheckboxOptions = false,
    this.title,
    this.onApplyFilter,
    this.buttonText,
    required this.isGeneratePdf,
  });

  @override
  State<CustomDateFilterWidget> createState() => _CustomDateFilterWidgetState();
}

class _CustomDateFilterWidgetState extends State<CustomDateFilterWidget> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateFilterType _filterType = DateFilterType.range;
  List<CheckboxOption> _checkboxOptions = [];
  late final ValueNotifier<InvoiceType> _selectedExportType;
  late final CheckboxSelectionStrategy _selectionStrategy;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
    _selectedExportType = ValueNotifier<InvoiceType>(InvoiceType.pdf);

    // Copy checkbox options to avoid mutating the original list
    _checkboxOptions =
        widget.checkboxOptions?.map(CheckboxOption.copy).toList() ?? [];

    // Use provided strategy or default to a generic checkbox strategy
    _selectionStrategy = widget.selectionStrategy ?? DefaultCheckboxStrategy();
  }

  @override
  void dispose() {
    _selectedExportType.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: 16.padding,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
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
        _buildHeader(),
        const SizedBox(height: 12),
        _buildFilterTypeSelector(),
        const SizedBox(height: 16),

        // Date Selection
        if (_filterType == DateFilterType.single)
          _buildSingleDateSelector()
        else
          _buildDateRangeSelector(),
        const SizedBox(height: 16),
        _buildQuickFilters(),

        // Optional checkbox and export options
        if (widget.showCheckboxOptions) ...[
          const SizedBox(height: 20),
          const Divider(),
          if (widget.isGeneratePdf) ...[
            const SizedBox(height: 16),
            _buildExportTypeSelector(),
          ],
          const SizedBox(height: 16),
          _buildCheckboxOptionsSection(),
          const SizedBox(height: 16),
          _buildApplyButton(),
        ],
      ],
    ),
  );

  //?====================================================?//
  //? Builder Methods
  //?====================================================?//

  /// Builds the header with title and clear button
  Widget _buildHeader() => Row(
    children: [
      Icon(Icons.date_range, color: AppColors.purple, size: 20.sp),
      8.width,
      Text(
        widget.isGeneratePdf ? 'Select Date' : 'Filter by Date',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
      const Spacer(),
      if (_startDate != null ||
            _endDate != null ||
            _checkboxOptions.any((option) => option.isSelected))
        TextButton(
          onPressed: _clearFilter,
          child: Text(
            'Clear',
            style: TextStyle(color: Colors.red, fontSize: 12.sp),
          ),
        ),
    ],
  );

  /// Builds the filter type selector (Single Date / Date Range)
  Widget _buildFilterTypeSelector() => Row(
    children: [
      Expanded(
        child: _FilterTypeChip(
          label: 'Single Date',
          isSelected: _filterType == DateFilterType.single,
          onTap: () => setState(() => _filterType = DateFilterType.single),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: _FilterTypeChip(
          label: 'Date Range',
          isSelected: _filterType == DateFilterType.range,
          onTap: () => setState(() => _filterType = DateFilterType.range),
        ),
      ),
    ],
  );

  /// Builds the quick filter chips
  Widget _buildQuickFilters() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
        children: widget.isGeneratePdf
            ? _quickSelectionDates
            : _quickFilterDates,
      ),
    ],
  );

  // Quick filter chips for date range selection for common filters
  List<_QuickFilterChip> get _quickFilterDates => [
    _QuickFilterChip(
      label: 'Today',
      isSelected: _startDate == _endDate && _startDate == AppDateUtils.today(),
      onTap: () => _setQuickFilter(AppDateUtils.today(), AppDateUtils.today()),
    ),
    _QuickFilterChip(
      label: 'This Week',
      isSelected:
          _startDate == AppDateUtils.thisWeekStart() &&
          _endDate == AppDateUtils.thisWeekEnd(),
      onTap: () => _setQuickFilter(
        AppDateUtils.thisWeekStart(),
        AppDateUtils.thisWeekEnd(),
      ),
    ),
    _QuickFilterChip(
      label: 'This Month',
      isSelected:
          _startDate == AppDateUtils.thisMonthStart() &&
          _endDate == AppDateUtils.thisMonthEnd(),
      onTap: () => _setQuickFilter(
        AppDateUtils.thisMonthStart(),
        AppDateUtils.thisMonthEnd(),
      ),
    ),
    _QuickFilterChip(
      label: 'Last Month',
      isSelected:
          _startDate == AppDateUtils.lastMonthStart() &&
          _endDate == AppDateUtils.lastMonthEnd(),
      onTap: () => _setQuickFilter(
        AppDateUtils.lastMonthStart(),
        AppDateUtils.lastMonthEnd(),
      ),
    ),
    _QuickFilterChip(
      label: 'Last 7 Days',
      isSelected:
          _startDate == AppDateUtils.last7Days() &&
          _endDate == AppDateUtils.today(),
      onTap: () =>
          _setQuickFilter(AppDateUtils.last7Days(), AppDateUtils.today()),
    ),
    _QuickFilterChip(
      label: 'Last 30 Days',
      isSelected:
          _startDate == AppDateUtils.last30Days() &&
          _endDate == AppDateUtils.today(),
      onTap: () =>
          _setQuickFilter(AppDateUtils.last30Days(), AppDateUtils.today()),
    ),
  ];

  // Separate quick selection chips for PDF generation
  List<_QuickFilterChip> get _quickSelectionDates => [
    _QuickFilterChip(
      label: 'Today',
      isSelected: _startDate == _endDate && _startDate == AppDateUtils.today(),
      onTap: () => _setQuickFilter(AppDateUtils.today(), AppDateUtils.today()),
    ),

    _QuickFilterChip(
      label: 'This Month',
      isSelected:
          _startDate == AppDateUtils.thisMonthStart() &&
          _endDate == AppDateUtils.thisMonthEnd(),
      onTap: () => _setQuickFilter(
        AppDateUtils.thisMonthStart(),
        AppDateUtils.thisMonthEnd(),
      ),
    ),
    _QuickFilterChip(
      label: 'Last Month',
      isSelected:
          _startDate == AppDateUtils.lastMonthStart() &&
          _endDate == AppDateUtils.lastMonthEnd(),
      onTap: () => _setQuickFilter(
        AppDateUtils.lastMonthStart(),
        AppDateUtils.lastMonthEnd(),
      ),
    ),
    _QuickFilterChip(
      label: 'This Quarter',
      isSelected:
          _startDate == AppDateUtils.thisQuarterStart() &&
          _endDate == AppDateUtils.thisQuarterEnd(),
      onTap: () => _setQuickFilter(
        AppDateUtils.thisQuarterStart(),
        AppDateUtils.thisQuarterEnd(),
      ),
    ),
    _QuickFilterChip(
      label: 'This Year',
      isSelected:
          _startDate == AppDateUtils.thisYearStart() &&
          _endDate == AppDateUtils.thisYearEnd(),
      onTap: () => _setQuickFilter(
        AppDateUtils.thisYearStart(),
        AppDateUtils.thisYearEnd(),
      ),
    ),
  ];

  /// Builds the export type selector (PDF / Excel)
  Widget _buildExportTypeSelector() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
        valueListenable: _selectedExportType,
        builder: (context, selectedValue, _) => RadioGroup(
          onChanged: (value) {
            if (value != null) _selectedExportType.value = value;
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
    ],
  );

  /// Builds the checkbox options section
  Widget _buildCheckboxOptionsSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.title ?? 'Filter Options',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 8),
      ..._checkboxOptions.map(_buildCheckboxTile).toList(),
    ],
  );

  /// Builds a single checkbox tile with strategy-based selection logic
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
        final newValue = value ?? false;
        // Use strategy pattern to handle selection logic
        _selectionStrategy.handleSelection(option, newValue, _checkboxOptions);
      });
      widget.onCheckboxChanged?.call(_checkboxOptions);
    },
    controlAffinity: ListTileControlAffinity.leading,
    contentPadding: EdgeInsets.zero,
    activeColor: AppColors.purple,
  );

  /// Builds the apply button
  Widget _buildApplyButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: _handleApplyButtonPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(widget.buttonText ?? 'Apply Filters'),
    ),
  );

  //?====================================================?//
  //? Event Handlers
  //?====================================================?//

  /// Handles apply button press
  void _handleApplyButtonPressed() {
    widget.onCheckboxChanged?.call(_checkboxOptions);
    widget.onApplyFilter?.call(
      _selectedExportType.value == InvoiceType.excel,
      _startDate,
      _endDate,
    );
  }

  //?====================================================?//
  //? Date Selector Builders
  //?====================================================?//

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
              const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
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
                      color: _startDate != null ? Colors.black : Colors.grey,
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
              const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
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

  //?====================================================?//
  //? Date Selection Methods
  //?====================================================?//

  Future<void> _selectSingleDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: AppConstants.defaultStartDate,
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

  //?====================================================?//
  //? Helper Methods
  //?====================================================?//

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
      for (final option in _checkboxOptions) {
        option.isSelected = false;
      }
    });
    widget.onDateFilterChanged(null, null);
    widget.onCheckboxChanged?.call(_checkboxOptions);
  }
}

//?====================================================?//
//? Reusable UI Components
//?====================================================?//

/// A chip widget for selecting filter type (Single Date / Date Range)
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

/// A chip widget for quick filter presets (Today, This Week, etc.)
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

//?====================================================?//
//? Enums & Models
//?====================================================?//

/// Filter type for date selection
enum DateFilterType {
  /// Single date selection
  single,

  /// Date range selection (start and end date)
  range,
}

/// Represents a checkbox option with label, id, and selection state
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

  /// Creates a copy of the checkbox option
  static CheckboxOption copy(CheckboxOption option) => CheckboxOption(
    label: option.label,
    id: option.id,
    subtitle: option.subtitle,
    isSelected: option.isSelected,
  );
}

//?====================================================?//
//? Checkbox Selection Strategies
//?====================================================?//

/// Abstract strategy for handling checkbox selection logic.
///
/// Implement this to define custom selection behavior (e.g., mutual exclusivity,
/// group selection, conditional selection).
abstract class CheckboxSelectionStrategy {
  /// Handles the selection of a checkbox option.
  ///
  /// Parameters:
  /// - [option]: The checkbox option being selected/deselected
  /// - [newValue]: The new selection state (true = selected, false = deselected)
  /// - [allOptions]: List of all checkbox options for context
  void handleSelection(
    CheckboxOption option,
    bool newValue,
    List<CheckboxOption> allOptions,
  );

  factory CheckboxSelectionStrategy.defaultStrategy() =>
      DefaultCheckboxStrategy();

  factory CheckboxSelectionStrategy.exclusiveStrategy([
    List<String>? exclusiveIds,
  ]) => ExclusiveCheckboxStrategy(exclusiveIds);
}

/// Default strategy - allows multiple selections without restrictions
class DefaultCheckboxStrategy implements CheckboxSelectionStrategy {
  @override
  void handleSelection(
    CheckboxOption option,
    bool newValue,
    List<CheckboxOption> allOptions,
  ) {
    option.isSelected = newValue;
  }
}

/// Strategy for mutually exclusive checkboxes (only one can be selected)
class ExclusiveCheckboxStrategy implements CheckboxSelectionStrategy {
  final List<String>? exclusiveIds;

  /// Creates an exclusive strategy.
  ///
  /// If [exclusiveIds] is provided, only those IDs are mutually exclusive.
  /// Otherwise, all checkboxes are mutually exclusive.
  ExclusiveCheckboxStrategy([this.exclusiveIds]);

  @override
  void handleSelection(
    CheckboxOption option,
    bool newValue,
    List<CheckboxOption> allOptions,
  ) {
    option.isSelected = newValue;

    final isOptionInExclusiveGroup =
        exclusiveIds == null || exclusiveIds!.contains(option.id);

    if (newValue && isOptionInExclusiveGroup) {
      // Deselect all other options in the exclusive group
      for (final other in allOptions) {
        if (other.id != option.id) {
          if (exclusiveIds == null || exclusiveIds!.contains(other.id)) {
            other.isSelected = false;
          }
        }
      }
    }
  }
}
