import 'package:bookie_buddy_web/core/constants/expense_categories.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/features/product/view_model/cubit_add_expense/add_expense_cubit.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';

class ProductAddExpenseDialog extends StatefulWidget {
  final int? id;
  final int variantId;
  final String? existingDate;
  final int? existingAmount;
  final String? existingType;
  final String? existingDescription;
  final MainServiceType mainServiceType;
  final List<ProductVariantModel>? variants;

  const ProductAddExpenseDialog({
    required this.variantId,
    required this.mainServiceType,
    this.variants,
    super.key,
    this.id,
    this.existingDate,
    this.existingAmount,
    this.existingType,
    this.existingDescription,
  });

  @override
  State<ProductAddExpenseDialog> createState() =>
      _ProductAddExpenseDialogState();
}

class _ProductAddExpenseDialogState extends State<ProductAddExpenseDialog> {
  final _formKey = GlobalKey<FormState>();

  final expenseController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final customCategoryController = TextEditingController();

  ProductVariantModel? selectedVariant;

  late List<String> _categories;
  String? _selectedCategory;
  bool _showCustomCategoryField = false;

  @override
  void initState() {
    super.initState();
    // Load categories based on service type
    _categories = ExpenseCategories.forService(widget.mainServiceType);

    if (widget.id != null) {
      dateController.text = widget.existingDate?.formatToUiDate() ?? '';
      expenseController.text = widget.existingAmount?.toString() ?? '';
      descriptionController.text = widget.existingDescription ?? '';
      selectedVariant = widget.variants?.first;
      if (_categories.contains(widget.existingType)) {
        _selectedCategory = widget.existingType;
      } else {
        _selectedCategory = "Other";
        customCategoryController.text = widget.existingType ?? '';
        _showCustomCategoryField = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditMode = widget.id != null;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final dialogWidth = screenWidth > 800 ? 600.0 : screenWidth * 0.9;
    final dialogHeight = screenHeight * 0.75;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Container(
        width: dialogWidth,
        height: dialogHeight,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.purple.withOpacity(0.05),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isEditMode ? Icons.edit_note : Icons.add_chart,
                    color: AppColors.purple,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isEditMode ? 'Edit Expense' : 'Add New Expense',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    tooltip: 'Close',
                  ),
                ],
              ),
            ),
            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.mainServiceType.isDress &&
                          widget.variants != null &&
                          widget.variants!.isNotEmpty &&
                          widget.variants!.length > 1) ...[
                        const Text(
                          'Select Variant',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.variants!.length,
                            itemBuilder: (context, index) {
                              final variant = widget.variants![index];
                              final isSelected = selectedVariant == variant;

                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedVariant = variant;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.purple
                                          : AppColors.purple.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.purple
                                            : Colors.transparent,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        variant.attribute,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColors.purple,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Grid for Date and Amount
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Date',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () => selectDate(context),
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: dateController,
                                      decoration: InputDecoration(
                                        hintText: 'Select Date',
                                        prefixIcon: const Icon(
                                            Icons.calendar_today,
                                            size: 20),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 16),
                                      ),
                                      validator: (value) =>
                                          value == null || value.isEmpty
                                              ? 'Required'
                                              : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: expenseController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Amount',
                                    prefixIcon: const Icon(Icons.currency_rupee,
                                        size: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Required'
                                          : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Select Category',
                          prefixIcon:
                              const Icon(Icons.category_outlined, size: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                        ),
                        initialValue: _selectedCategory,
                        items: _categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                            _showCustomCategoryField = newValue == "Other";
                          });
                        },
                      ),

                      if (_showCustomCategoryField) ...[
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: customCategoryController,
                          decoration: InputDecoration(
                            hintText: 'Enter Custom Category',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Required'
                              : null,
                        ),
                      ],
                      const SizedBox(height: 24),

                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: descriptionController,
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Add description (optional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Actions
                      BlocConsumer<AddExpenseCubit, AddExpenseState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            orElse: () {},
                            error: (error) => context.showSnackBar(
                              error,
                              isError: true,
                            ),
                            success: (message) {
                              context.pop();
                              context.showSnackBar(message);
                            },
                          );
                        },
                        builder: (context, state) {
                          final isLoading = state.maybeWhen(
                            orElse: () => false,
                            submitted: () => true,
                          );
                          return Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed:
                                      isLoading ? null : () => context.pop(),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Cancel'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: CustomElevatedButton(
                                  onPressed: handleSubmit,
                                  text: isEditMode
                                      ? 'Update Expense'
                                      : 'Add Expense',
                                  isLoading: isLoading,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateController.text.isEmpty
          ? DateTime.now()
          : dateController.text.parseToDateTime(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.purple,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      if (pickedDate.isAfter(DateTime.now())) {
        context.showSnackBar(
          'Not allowed to select future dates.',
          title: 'Date Error',
        );
      } else {
        setState(() {
          dateController.text = pickedDate.format();
        });
      }
    }
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final String category = _selectedCategory == "Other"
          ? customCategoryController.text
          : _selectedCategory ?? '';

      if (widget.mainServiceType.isDress &&
          selectedVariant == null &&
          (widget.variants?.length ?? 0) > 1) {
        context.showSnackBar(
          'Please select a variant',
          isError: true,
        );
        return;
      }

      context.read<AddExpenseCubit>().saveExpense(
            expense: ExpenseRequestModel(
              expenseId: widget.id,
              date: dateController.text.formatToUiDate(),
              amount: int.parse(expenseController.text),
              type: category,
              description: descriptionController.text,
              variantId: selectedVariant?.id ?? widget.variantId,
            ),
          );
    }
  }
}
