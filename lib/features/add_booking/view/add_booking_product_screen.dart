import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_other_details_model/booking_other_details_model.dart';
import 'package:bookie_buddy_web/core/navigation/app_routes.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_client_details_screen.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/cubit_add_booking_products/add_booking_products_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddBookingProductScreen extends StatelessWidget {
  AddBookingProductScreen({required this.addBookingModel, super.key});

  final RequestBookingModel addBookingModel;

  final locationStartController = TextEditingController();
  final locationFromController = TextEditingController();
  final locationToController = TextEditingController();
  final descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bookingData = addBookingModel;
    final isWeb = context.screenWidth > 768;
    
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          handlePop(didPop, result, context),
      child: Scaffold(
        backgroundColor: isWeb ? const Color(0xFFF5F7FA) : null,
        appBar: AppBar(
          title: const Text('Add Products'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isWeb ? 1000 : double.infinity,
                ),
                padding: isWeb
                    ? const EdgeInsets.all(40)
                    : const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: isWeb ? _buildWebLayout(context, bookingData) : _buildMobileLayout(context, bookingData),
                ),
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context, RequestBookingModel bookingData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Products & Services',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose products and configure additional details for your booking',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Selected products section
        BlocBuilder<AddBookingProductsCubit, AddBookingProductsState>(
          builder: (context, state) => state.products.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Products',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSelectedProductSection(context, state.products),
                    ],
                  ),
                ),
        ),

        // Add product section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Products',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              _addProductContainerBuilder(context, bookingData),
            ],
          ),
        ),
        
        const SizedBox(height: 24),

        // Vehicle locations and description section
        BlocBuilder<AddBookingProductsCubit, AddBookingProductsState>(
          builder: (context, state) {
            final products = state.products;
            final isVehicle = products.any(
              (p) => p.variant.mainServiceType.isVehicle == true,
            );
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Vehicle locations (left side)
                if (isVehicle)
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vehicle Locations',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: locationStartController,
                            label: 'Start Location',
                            hintText: 'Location',
                            prefixIcon: const Icon(Icons.place_outlined),
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                AppInputValidators.basicText(
                                  value,
                                  isRequired: false,
                                  fieldName: 'Place',
                                ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: locationFromController,
                            label: 'Pickup Location',
                            hintText: 'Location',
                            prefixIcon: const Icon(Icons.place_outlined),
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                AppInputValidators.basicText(
                                  value,
                                  isRequired: false,
                                  fieldName: 'Place',
                                ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: locationToController,
                            label: 'Destination',
                            hintText: 'Location',
                            prefixIcon: const Icon(Icons.place_outlined),
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                AppInputValidators.basicText(
                                  value,
                                  isRequired: false,
                                  fieldName: 'Place',
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                if (isVehicle) const SizedBox(width: 24),
                
                // Description section (right side)
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Additional Details',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: descriptionController,
                          label: 'Description (Optional)',
                          hintText: 'Any additional notes or requirements',
                          minLines: 4,
                          maxLines: 6,
                          textInputAction: TextInputAction.newline,
                          validator: (value) => AppInputValidators.basicText(
                            value,
                            isRequired: false,
                            fieldName: 'Description',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        
        const SizedBox(height: 40),
        
        // Next button
        Center(
          child: SizedBox(
            width: 300,
            child: CustomElevatedButton(
              text: 'Continue to Payment',
              onPressed: () => _handleNext(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, RequestBookingModel bookingData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: context.isMobile ? null : 40.paddingHorizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                15.height,
                BlocBuilder<
                  AddBookingProductsCubit,
                  AddBookingProductsState
                >(
                  builder: (context, state) => state.products.isEmpty
                      ? const SizedBox.shrink()
                      : _buildSelectedProductSection(
                          context,
                          state.products,
                        ),
                ),

                // add product container
                _addProductContainerBuilder(context, bookingData),
                0.01.heightCustom,

                BlocBuilder<
                  AddBookingProductsCubit,
                  AddBookingProductsState
                >(
                  builder: (context, state) {
                    final products = state.products;
                    final isVehicle = products.any(
                      (p) => p.variant.mainServiceType.isVehicle == true,
                    );
                    if (!isVehicle) return const SizedBox.shrink();
                    return Padding(
                      padding: 16.paddingHorizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 15,
                        children: [
                          // locations
                          Text(
                            'Locations',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          CustomTextField(
                            controller: locationStartController,
                            label: 'Start Location',
                            hintText: 'Location',
                            prefixIcon: const Icon(Icons.place_outlined),
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                AppInputValidators.basicText(
                                  value,
                                  isRequired: false,
                                  fieldName: 'Place',
                                ),
                          ),
                          CustomTextField(
                            controller: locationFromController,
                            label: 'Pickup Location',
                            hintText: 'Location',
                            prefixIcon: const Icon(Icons.place_outlined),
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                AppInputValidators.basicText(
                                  value,
                                  isRequired: false,
                                  fieldName: 'Place',
                                ),
                          ),
                          CustomTextField(
                            controller: locationToController,
                            label: 'Destination',
                            hintText: 'Location',
                            prefixIcon: const Icon(Icons.place_outlined),
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                AppInputValidators.basicText(
                                  value,
                                  isRequired: false,
                                  fieldName: 'Place',
                                ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                Padding(
                  padding: 16.padding,
                  child: Stack(
                    children: [
                      CustomTextField(
                        controller: descriptionController,
                        label: 'Description (Optional)',
                        hintText: 'Description',
                        maxLines: 4,
                        minLines: 4,
                        textInputAction: TextInputAction.newline,
                        validator: (value) => AppInputValidators.basicText(
                          value,
                          isRequired: false,
                          fieldName: 'Description',
                        ),
                      ),
                    ],
                  ),
                ),

                // Padding to avoid keyboard overlap
                context.mediaQuery.viewInsets.bottom > 0
                    ? 0.35.heightCustom
                    : 0.1.heightCustom,
              ],
            ),
          ),
        ),
        Padding(
          padding: context.isMobile ? 16.padding : (40, 20).padding,
          child: CustomElevatedButton(
            width: double.infinity,
            onPressed: () => _handleNext(context),
            text: 'Next',
          ),
        ),
      ],
    );
  }

  void _handleNext(BuildContext context) async {
    final products = context
        .read<AddBookingProductsCubit>()
        .state
        .products;
    if (products.isEmpty) {
      CustomSnackBar(
        message: 'Please select at least one product',
      );
      return;
    }

    final total = products.fold(
      0,
      (int prev, element) => prev + element.amount,
    );
    if (total <= 0) {
      CustomSnackBar(
        message: 'Product amount total must be greater than 0',
      );
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
     final addBookingProductsState = context.read<AddBookingProductsCubit>().state;

await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AddBookingClientDetailsScreen(
      addBookingModel: addBookingModel.copyWith(
        products: addBookingProductsState.products,
        description: descriptionController.text.trim(),
        otherDetails: BookingOtherDetailsModel(
          locationStart: locationStartController.text.nullIfEmpty,
          locationFrom: locationFromController.text.nullIfEmpty,
          locationTo: locationToController.text.nullIfEmpty,
        ),
      ),
    ),
  ),
);


    } catch (e) {
      // Fallback navigation if GoRouter fails
      if (context.mounted) {
        await context.pushNamed(
          AppRoutes.addBookingDetails.name,
          extra: {
            'add_booking_model': addBookingModel.copyWith(
              products: context
                  .read<AddBookingProductsCubit>()
                  .state
                  .products,
              description: descriptionController.text.trim(),
              otherDetails: BookingOtherDetailsModel(
                locationStart:
                    locationStartController.text.nullIfEmpty,
                locationFrom:
                    locationFromController.text.nullIfEmpty,
                locationTo: locationToController.text.nullIfEmpty,
              ),
            ),
          },
        );
      }
    }
  }

  void handlePop(bool didPop, dynamic result, BuildContext context) async {
    if (didPop) {
      return;
    }
    final selectedProducts = context
        .read<AddBookingProductsCubit>()
        .state
        .products;
    if (selectedProducts.isEmpty) {
      NavigatorX(context).pop(); 

      return;
    }
    final result = await showDiscardDialog(context);
    if (result ?? false) {
      NavigatorX(context).pop();
    }
  }

  Container _addProductContainerBuilder(
    BuildContext context,
    RequestBookingModel bookingData,
  ) => Container(
    margin: 16.padding,
    padding: 30.padding,
    alignment: Alignment.center,
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: 5.radiusBorder,
        side: BorderSide(color: AppColors.grey400),
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.purpleLightShade,
        borderRadius: BorderRadius.circular(5),
      ),
      child: MaterialButton(
        onPressed: () async {
          try {
            final result = await GoRouter.of(context).pushNamed(
              AppRoutes.selectProducts.name,
              extra: {
                'selected_products': context
                    .read<AddBookingProductsCubit>()
                    .state
                    .products,
                'pickup_date_time': bookingData.pickupDate,
                'return_date_time': bookingData.returnDate,
              },
            );

            if (result != null && result is List<ProductSelectedModel>) {
              context
                  .read<AddBookingProductsCubit>()
                  .setAll(result);
            }
          } catch (e) {
            // Fallback navigation if GoRouter fails
            if (context.mounted) {
              final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SelectProductScreen(
      serviceId: bookingData.serviceId ?? 0, // provide a default value if null
      pickupDate: bookingData.pickupDate ?? '',
      returnDate: bookingData.returnDate??'',
      availabilityCheckOnly: false, // default or pass if needed
      pickupTime: bookingData.pickupTime,
      returnTime: bookingData.returnTime,
      preSelectedData: context.read<AddBookingProductsCubit>().state.products,
      useAvailableProductsApi: true, // default or pass if needed
      isSales: false, // default or pass if needed
    ),
  ),
);


              if (result != null && result is List<ProductSelectedModel>) {
                context
                    .read<AddBookingProductsCubit>()
                    .setAll(result);
              }
            }
          }
        },
        splashColor: AppColors.grey300,
        elevation: 0,
        padding: EdgeInsets.zero,
        child: Container(
          padding: 10.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: 8.padding,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: AppColors.purple,
                        size: 18.sp,
                      ),
                    ),
                    8.width,
                    Text(
                      'Add Service',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.purple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.purple,
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _buildSelectedProductSection(
    BuildContext context,
    List<ProductSelectedModel> products,
  ) => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ...products.map(
        //   (product) => Container(
        //     margin: 3.paddingVertical,
        //     child: SelectedProductInAddBooking(selected: ,
        //       product: product,
        //       onRemove: () {
        //         log('removing product from cubit ${product.id}');
        //         context
        //             .read<AddBookingProductsCubit>()
        //             .re(product);
        //       },
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}