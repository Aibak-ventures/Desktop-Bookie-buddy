import 'dart:developer';

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/expense_categories.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/expense_model/expense_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_drop_down_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/product_search_field_widget.dart';
import 'package:bookie_buddy_web/core/utils/responsive_helper.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_product_search/product_search_cubit.dart';
import 'package:bookie_buddy_web/core/widgets/responsive_widget.dart';
import 'package:bookie_buddy_web/features/main/view/bottom_bar_screen.dart';
import 'package:bookie_buddy_web/features/product/view/widgets/variant_size_type_text_field.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';
import 'package:bookie_buddy_web/features/save_expense/view_model/cubit_save_expense/save_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExpenseScreen extends StatefulWidget {
  final ExpenseModel? expense;

  const AddExpenseScreen({super.key, this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  final expenseController = TextEditingController();
  final descriptionController = TextEditingController();
  var _categories = <String>[
    'Food',
    'Vehicle',
    "Petrol",
    "Tea & Water",
    "Salary",
    'Other'
  ];
  String? _selectedCategory;
  final productNameController = TextEditingController();
  final dateController = TextEditingController();
  final customCategoryController = TextEditingController();
  bool _showCustomCategoryField = false;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;

  final variantSelectedNotifier = ValueNotifier<int?>(null);

  final productScrollController = ScrollController();

@override
void initState() {
  super.initState();
  productScrollController.addListener(_onScrollProductNames);

  if (widget.expense != null) {
    final e = widget.expense!;

    dateController.text = e.date.formatToUiDate();
    expenseController.text = e.expense.toString();
    descriptionController.text = e.description ?? '';

    // CATEGORY
    if (_categories.contains(e.type)) {
      _selectedCategory = e.type;
    } else {
      _selectedCategory = "Other";
      customCategoryController.text = e.type ?? '';
      _showCustomCategoryField = true;
    }

    // 🔥 PAYMENT METHOD FIX
    if (e.paymentMethod != null) {
      _selectedPaymentMethod =
          e.paymentMethod == 'upi' ? PaymentMethod.gPay : PaymentMethod.cash;
    }
  }
}


  void _onScrollProductNames() {
    if (productScrollController.hasClients &&
        productScrollController.position.pixels >=
            productScrollController.position.maxScrollExtent - 50) {
      // final cubit = context.read<ProductSearchCubit>();
      // final isLoadNext = cubit.state.searchQuery.isNotEmpty &&
      //     cubit.state.nextPageUrl != null &&
      //     cubit.state.isLoading;

      // if (isLoadNext) {
      //   log('loading next event called');
      //   cubit.loadNexData();
      // }
    }
    // log('position: ${productScrollController.position.pixels}, max: ${productScrollController.position.maxScrollExtent}');
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final String category = _selectedCategory == "Other"
          ? customCategoryController.text
          : _selectedCategory ?? '';

      final selectedProduct =
          context.read<ProductSearchCubit>().state.selectedProduct;

      final oldExpense = widget.expense;
      final ExpenseRequestModel expense;
      if (oldExpense != null) {
        // Edit expense
        expense = ExpenseRequestModel(
          expenseId: oldExpense.id,
          variantId:
              selectedProduct != null ? variantSelectedNotifier.value : null,
          date: oldExpense.date.formatToUiDate() != dateController.text
              ? dateController.text.formatToUiDate()
              : null,
          amount: oldExpense.expense != expenseController.text.trim().toInt()
              ? expenseController.text.trim().toInt()
              : null,
          type: oldExpense.type != category ? category : null,
          description:
              oldExpense.description != descriptionController.text.trim()
                  ? descriptionController.text.trim()
                  : null,
          paymentMethod: oldExpense.type != (_selectedPaymentMethod.isUpi 
              ? _selectedPaymentMethod.upiValue 
              : _selectedPaymentMethod.value)
              ? (_selectedPaymentMethod.isUpi 
                  ? _selectedPaymentMethod.upiValue 
                  : _selectedPaymentMethod.value)
              : null,
        );
        // expense = {
        //   if (oldExpense.date.formatToUiDate() != dateController.text)
        //     "date": dateController.text.formatToUiDate(),
        //   if (oldExpense.expense != expenseController.text.trim().toInt())
        //     "expense": expenseController.text.trim().toInt(),
        //   if (oldExpense.type != category) "type": category,
        //   if (oldExpense.description != descriptionController.text.trim())
        //     "description": descriptionController.text,
        // };
      } else {
        // Add new expense
        expense = ExpenseRequestModel(
          variantId:
              selectedProduct != null ? variantSelectedNotifier.value : null,
          date: dateController.text.formatToUiDate(),
          amount: expenseController.text.trim().toInt(),
          type: category,
          description: descriptionController.text,
          paymentMethod: _selectedPaymentMethod.isUpi 
              ? _selectedPaymentMethod.upiValue 
              : _selectedPaymentMethod.value,
        );
        // expense = {
        //   "product_variant": variantSelectedNotifier.value,
        //   "date": dateController.text.formatToUiDate(),
        //   "expense": expenseController.text.trim().toInt(),
        //   "type": category,
        //   "description": descriptionController.text,
        // };
      }
      final oldExp = ExpenseRequestModel(
        expenseId: oldExpense?.id,
        variantId: oldExpense?.variantId,
        amount: oldExpense?.expense,
        date: oldExpense?.date,
        description: oldExpense?.description,
        type: oldExpense?.type,
      );
      if (oldExp == expense) {
        context.showSnackBar(
          'No changes made',
        );
        return;
      }
      print(expense);
      context.read<SaveExpenseCubit>().saveExpense(
            expense: expense,
          );
    }
  }

  @override
  void dispose() {
    // dateController.dispose();
    // customCategoryController.dispose();
    // expenseController.dispose();
    // descriptionController.dispose();
    productScrollController.dispose();
    variantSelectedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.expense != null;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          ResponsiveHelper.isDesktop(context) ? const Color(0xFFF8F9FA) : null,
      appBar: ResponsiveHelper.isMobile(context)
          ? AppBar(
              automaticallyImplyLeading: !isEdit ? false : true,
              title: Text(!isEdit ? 'Add Expense' : 'Edit Expense'),
            )
          : null,
      body: ResponsiveWidget(
        mobile: _buildMobileLayout(context, isEdit),
        tablet: _buildTabletLayout(context, isEdit),
        desktop: _buildDesktopLayout(context, isEdit),
        largeDesktop: _buildDesktopLayout(context, isEdit),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isEdit) {
    return MediaQuery(
      data: context.mediaQuery.copyWith(
        alwaysUse24HourFormat: false,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: 16.padding,
                child: _buildForm(context, isEdit),
              ),
            ),
          ),
          _buildSubmitButton(context, isEdit),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, bool isEdit) {
    return MediaQuery(
      data: context.mediaQuery.copyWith(
        alwaysUse24HourFormat: false,
      ),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF8F9FA),
                Color(0xFFE9ECEF),
              ],
            ),
          ),
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 40.h,
                ),
                child: Column(
                  children: [
                    Text(
                      !isEdit ? 'Add New Expense' : 'Edit Expense',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      !isEdit
                          ? 'Track your expenses and manage your budget effectively'
                          : 'Update your expense details',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Form Section
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  margin: EdgeInsets.symmetric(horizontal: 40.w),
                  padding: EdgeInsets.all(32.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildForm(context, isEdit),
                      SizedBox(height: 32.h),
                      _buildSubmitButton(context, isEdit, isInCard: true),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isEdit) {
    return MediaQuery(
      data: context.mediaQuery.copyWith(
        alwaysUse24HourFormat: false,
      ),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF8F9FA),
                Color(0xFFE9ECEF),
              ],
            ),
          ),
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 80.w,
                  vertical: 60.h,
                ),
                child: Column(
                  children: [
                    Text(
                      !isEdit ? 'Add New Expense' : 'Edit Expense',
                      style: TextStyle(
                        fontSize: 42.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      !isEdit
                          ? 'Track your expenses and manage your budget effectively'
                          : 'Update your expense details',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Form Section
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  margin: EdgeInsets.symmetric(horizontal: 80.w),
                  padding: EdgeInsets.all(48.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildForm(context, isEdit),
                      SizedBox(height: 40.h),
                      _buildSubmitButton(context, isEdit, isInCard: true),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, bool isEdit) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: ResponsiveHelper.getValue(
          context,
          mobile: 15.h,
          tablet: 20.h,
          desktop: 24.h,
        ),
        children: [
          if (!isEdit)
            BlocConsumer<ProductSearchCubit, ProductSearchState>(
              listener: (context, state) {
                // state.when(
                //   initial: (suggestions, selectedProduct, searchQuery,
                //       nextPageUrl, isLoading) {
                //     if (selectedProduct != null) {
                //       productNameController.text = selectedProduct.name;
                //       variantSelectedNotifier.value =
                //           selectedProduct.variants.first.id;
                //       log(selectedProduct.toString());
                //       context.hideKeyboard();
                //     }
                //   },
                // );
                final selectedProduct = state.selectedProduct;
                if (selectedProduct != null) {
                  productNameController.text = selectedProduct.name;
                  variantSelectedNotifier.value =
                      selectedProduct.variants.first.id;
                  log(selectedProduct.toString());
                  context.hideKeyboard();

                  _categories = ExpenseCategories.forService(
                    selectedProduct.mainServiceType,
                  );
                }
              },
              builder: (context, state) {
                final isSelectedProduct = state.selectedProduct != null;

                return Column(
                  children: [
                    ProductSearchFieldWidget(
                      nameController: productNameController,
                      scrollController: productScrollController,
                    ),
                    if (isSelectedProduct &&
                        state.selectedProduct!.mainServiceType.isDress &&
                        !VariantSizeType.isFreeSize(
                          state.selectedProduct!.variants.first.attribute,
                        ) &&
                        state.selectedProduct!.variants.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        height: 65.h,
                        child: ValueListenableBuilder(
                            valueListenable: variantSelectedNotifier,
                            builder: (context, selectedId, child) {
                              return ListView.builder(
                                padding: 10.paddingOnly(top: true),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:
                                    state.selectedProduct!.variants.length,
                                itemBuilder: (context, index) {
                                  final variant =
                                      state.selectedProduct!.variants[index];
                                  final isSelected = variant.id == selectedId;
                                  return Padding(
                                    padding: 12.paddingOnly(right: true),
                                    child: Container(
                                      width: 55,
                                      height: 55,
                                      decoration: BoxDecoration(
                                        color: AppColors.purpleLight,
                                        shape: BoxShape.circle,
                                        border: isSelected
                                            ? BoxBorder.all(
                                                color: AppColors.purple,
                                              )
                                            : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          variant.attribute,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ),
                                    ).onTap(
                                      () {
                                        variantSelectedNotifier.value =
                                            variant.id;
                                      },
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                  ],
                );
              },
            ),

          CustomTextField(
            ignorePointers: true,
            controller: dateController,
            hintText: 'Select Date',
            prefixIcon: const Icon(Icons.calendar_month),
            validator: (value) =>
                value == null || value.isEmpty ? 'Enter a date' : null,
          ).onTap(
            () => selectDate(context),
          ),
          CustomTextField(
            controller: expenseController,
            hintText: 'Amount',
            keyboardType: TextInputType.number,
            prefixIcon: const Icon(Icons.currency_rupee),
            validator: AppInputValidators.amount,
          ),

          // Payment Method Selector
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getValue(
                      context,
                      mobile: 14.sp,
                      tablet: 15.sp,
                      desktop: 16.sp,
                    ),
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildPaymentMethodOption(
                      PaymentMethod.cash,
                      Icons.money,
                      'Cash',
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildPaymentMethodOption(
                      PaymentMethod.gPay,
                      Icons.account_balance_wallet,
                      'UPI',
                    ),
                  ),
                ],
              ),
            ],
          ),

          // category dropdown
          CustomDropDownField<String>(
            hintText: "Select Category",
            prefixIcon: const Icon(
              Icons.category_outlined,
            ),
            selectedValue: _selectedCategory,
            onChanged: (newValue) {
              setState(() {
                _selectedCategory = newValue;
                _showCustomCategoryField = newValue == "Other";
              });
            },
            items: _categories,
          ),
          if (_showCustomCategoryField) ...[
            CustomTextField(
              hintText: 'Enter Custom Category',
              controller: customCategoryController,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter a category' : null,
            ),
          ],
          Stack(
            children: [
              CustomTextField(
                hintText: 'Description',
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                prefixIcon: const SizedBox.shrink(),
                minLines: 4,
                maxLines: 25,
                validator: (value) => null,
              ),
              Positioned(
                top: 16,
                left: 12,
                child: Icon(
                  Icons.description_outlined,
                  color: AppColors.purple.lighten(0.2),
                ),
              ),
            ],
          ),

          if (context.isKeyboardVisible) 0.35.heightCustom,
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, bool isEdit,
      {bool isInCard = false}) {
    return BlocConsumer<SaveExpenseCubit, SaveExpenseState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (error) {
            CustomSnackBar(message: error);
          },
          success: (message) {
            // clear selected product and variant
            context.read<ProductSearchCubit>().clearSelected();
            // context
            //     .read<ProductSearchCubit>()
            //     .add(const ProductSearchEvent.clearSelected());
            variantSelectedNotifier.value = null;

            if (isEdit && context.mounted) {
              Navigator.pop(context); // Pop only in edit screen
            } else {
              context.pushAndRemoveUntil(const BottomBarScreen());
            }

            CustomSnackBar(
              message: message,
              isError: false,
            );

            dateController.clear();
            customCategoryController.clear();
            expenseController.clear();
            descriptionController.clear();
          },
        );
      },
      builder: (context, state) {
        final isMobile = ResponsiveHelper.isMobile(context);
        final isLoading = state.maybeWhen(
          orElse: () => false,
          submitted: () => true,
        );

        return Container(
          width: isInCard ? null : double.infinity,
          padding: isInCard
              ? EdgeInsets.zero
              : EdgeInsets.only(
                  left: isMobile ? 16.w : 40.w,
                  right: isMobile ? 16.w : 40.w,
                  bottom: 100.h,
                ),
          child: CustomElevatedButton(
            width: isInCard
                ? ResponsiveHelper.getValue(
                    context,
                    mobile: double.infinity,
                    tablet: 200.w,
                    desktop: 250.w,
                  )
                : double.infinity,
            isLoading: isLoading,
            onPressed: handleSubmit,
            icon: const Icon(Icons.add),
            text: !isEdit ? 'Add Expense' : 'Edit Expense',
          ),
        );
      },
    );
  }

  Widget _buildPaymentMethodOption(
    PaymentMethod method,
    IconData icon,
    String label,
  ) {
    final isSelected = _selectedPaymentMethod == method;
    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = method),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ResponsiveHelper.getValue(
            context,
            mobile: 16.h,
            tablet: 18.h,
            desktop: 20.h,
          ),
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.purple.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.purple : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.purple : Colors.grey.shade600,
              size: ResponsiveHelper.getValue(
                context,
                mobile: 24.sp,
                tablet: 26.sp,
                desktop: 28.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(
                fontSize: ResponsiveHelper.getValue(
                  context,
                  mobile: 14.sp,
                  tablet: 15.sp,
                  desktop: 16.sp,
                ),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.purple : Colors.grey.shade700,
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
    );
    if (pickedDate != null) {
      print(pickedDate);
      setState(
        () {
          dateController.text = pickedDate.format();
        },
      );
    }
  }
}
