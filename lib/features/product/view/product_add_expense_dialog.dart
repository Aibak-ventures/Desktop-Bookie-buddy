import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/features/product/view_model/cubit_add_expense/add_expense_cubit.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  final List<String> _categories = [
    "Salary",
    "Service",
    "Miscellaneous",
    'Other'
  ];
  String? _selectedCategory;
  bool _showCustomCategoryField = false;

  @override
  void initState() {
    super.initState();
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
    return AlertDialog(
      insetPadding: context.isMobile
          ? null
          : EdgeInsets.symmetric(
              horizontal: 0.2.widthR,
            ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Center(
        child: Text(
          widget.id == null ? 'Add Expense' : 'Edit Expense',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.mainServiceType.isDress &&
                  widget.variants != null &&
                  widget.variants!.isNotEmpty &&
                  widget.variants!.length > 1) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 55,
                  width: double.maxFinite,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.variants!.length,
                    itemBuilder: (context, index) {
                      final variant = widget.variants![index];
                      final isSelected = selectedVariant == variant;

                      return Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.purpleLight
                              : const Color(0xFFE8E4FF),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF6C5CE7)
                                : Colors.transparent,
                            width: isSelected ? 2 : 0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            variant.attribute,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF6C5CE7)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ).onTap(() {
                        setState(() {
                          selectedVariant = variant;
                        });
                      });
                    },
                  ),
                ),
              ],
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      prefixIcon: const Icon(Icons.calendar_month,
                          color: AppColors.purple),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Enter a date' : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: expenseController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  prefixIcon: const Icon(
                    Icons.currency_rupee,
                    color: AppColors.purple,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter an amount' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.view_list_sharp,
                    color: AppColors.purple,
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                initialValue: _selectedCategory,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      // style: const TextStyle(color: AppColors.purple),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                    _showCustomCategoryField = newValue == "Other";
                  });
                },
                hint: const Text(
                  "Select Category",
                  style: TextStyle(color: AppColors.purple),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.purple,
                ),
              ),
              if (_showCustomCategoryField) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: customCategoryController,
                  decoration: InputDecoration(
                    hintText: 'Enter Custom Category',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter a category'
                      : null,
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Description',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child:
                        Icon(Icons.note_alt_outlined, color: AppColors.purple),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.purple),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
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
                context.showSnackBar(
                  message,
                );
              },
            );
          },
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              orElse: () => false,
              submitted: () => true,
            );
            return CustomElevatedButton(
              onPressed: handleSubmit,
              text: widget.id == null ? 'Add Expense' : 'Update Expense',
              isLoading: isLoading,
            );
          },
        ),
      ],
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateController.text.isEmpty
          ? DateTime.now()
          : dateController.text.parseToDateTime(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(), // Restrict to current date or earlier
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
      // Check if the selected date is in the future
      if (pickedDate.isAfter(DateTime.now())) {
        // Show a snackbar or dialog to inform the user

        context.showSnackBar(
          'Not allowed to select future dates.',
          title: 'Date Error',
        );
      } else {
        // Update the date controller if the date is valid
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

      if (selectedVariant == null && (widget.variants?.length ?? 0) > 1) {
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
            // id: widget.id,
            // date: dateController.text.formatToUiDate(),
            // amount: int.parse(expenseController.text),
            // type: category,
            // description: descriptionController.text,
            // variantId: selectedVariant?.id ?? widget.variantId,
          );
    }
  }
}
