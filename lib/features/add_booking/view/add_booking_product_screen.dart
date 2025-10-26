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
import 'package:bookie_buddy_web/features/add_booking/view/widgets/selected_product_in_add_booking.dart';
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Content Area (70%)
        Expanded(
          flex: 7,
          child: Container(
            padding: const EdgeInsets.all(32),
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
                // Header section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.blue.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select Products & Services',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Choose products and configure additional details for your booking',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Add Products Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.add_circle_outline, color: Colors.purple.shade600, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Add Products',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => _navigateToProductSelection(context, bookingData),
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text('Browse Products'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Selected Products Section
                BlocBuilder<AddBookingProductsCubit, AddBookingProductsState>(
                  builder: (context, state) {
                    return state.products.isEmpty
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 48,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No products selected yet',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Click "Browse Products" to add items to your booking',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Selected Products (${state.products.length})',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  constraints: const BoxConstraints(maxHeight: 300),
                                  child: _buildSelectedProductSection(context, state.products),
                                ),
                              ],
                            ),
                          );
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Additional Details Section
                BlocBuilder<AddBookingProductsCubit, AddBookingProductsState>(
                  builder: (context, state) {
                    final products = state.products;
                    final isVehicle = products.any(
                      (p) => p.variant.mainServiceType.isVehicle == true,
                    );
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Additional Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Vehicle locations (if applicable)
                          if (isVehicle) ...[
                            Text(
                              'Vehicle Locations',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: locationStartController,
                                    label: 'Start Location',
                                    hintText: 'Location',
                                    prefixIcon: const Icon(Icons.place_outlined),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) => AppInputValidators.basicText(
                                      value,
                                      isRequired: false,
                                      fieldName: 'Place',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CustomTextField(
                                    controller: locationFromController,
                                    label: 'Pickup Location',
                                    hintText: 'Location',
                                    prefixIcon: const Icon(Icons.place_outlined),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) => AppInputValidators.basicText(
                                      value,
                                      isRequired: false,
                                      fieldName: 'Place',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CustomTextField(
                                    controller: locationToController,
                                    label: 'Destination',
                                    hintText: 'Location',
                                    prefixIcon: const Icon(Icons.place_outlined),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) => AppInputValidators.basicText(
                                      value,
                                      isRequired: false,
                                      fieldName: 'Place',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                          ],
                          
                          // Description
                          CustomTextField(
                            controller: descriptionController,
                            label: 'Description (Optional)',
                            hintText: 'Any additional notes or requirements',
                            minLines: 3,
                            maxLines: 5,
                            textInputAction: TextInputAction.newline,
                            validator: (value) => AppInputValidators.basicText(
                              value,
                              isRequired: false,
                              fieldName: 'Description',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(width: 24),
        
        // Sidebar (30%)
        Expanded(
          flex: 3,
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
                  'Booking Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Booking details summary
                _buildBookingSummaryCard(context, bookingData),
                
                const SizedBox(height: 24),
                
                // Product count and total
                BlocBuilder<AddBookingProductsCubit, AddBookingProductsState>(
                  builder: (context, state) {
                    final total = state.products.fold<int>(
                      0,
                      (prev, element) => prev + element.amount,
                    );
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Products:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                '${state.products.length} items',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              Text(
                                '₹$total',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 32),
                
                // Action buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () => _handleNext(context),
                        icon: const Icon(Icons.arrow_forward, size: 20),
                        label: const Text('Continue to Payment'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, size: 20),
                        label: const Text('Back'),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingSummaryCard(BuildContext context, RequestBookingModel bookingData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Service ID:', '${bookingData.serviceId ?? 'N/A'}'),
          _buildSummaryRow('Pickup Date:', bookingData.pickupDate ?? 'Not set'),
          _buildSummaryRow('Return Date:', bookingData.returnDate ?? 'Not set'),
          if (bookingData.pickupTime != null)
            _buildSummaryRow('Pickup Time:', bookingData.pickupTime!.format(context)),
          if (bookingData.returnTime != null)
            _buildSummaryRow('Return Time:', bookingData.returnTime!.format(context)),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProductSelection(BuildContext context, RequestBookingModel bookingData) async {
    try {
      final currentProducts = context.read<AddBookingProductsCubit>().state.products;
      
      final result = await Navigator.of(context).push<List<ProductSelectedModel>>(
        MaterialPageRoute(
          builder: (context) => SelectProductScreen(
            serviceId: bookingData.serviceId ?? 0,
            pickupDate: bookingData.pickupDate ?? '',
            returnDate: bookingData.returnDate ?? '',
            pickupTime: bookingData.pickupTime,
            returnTime: bookingData.returnTime,
            preSelectedData: currentProducts,
            useAvailableProductsApi: true,
            isSales: false,
          ),
        ),
      );
      
      if (result != null && result.isNotEmpty) {
        context.read<AddBookingProductsCubit>().setAll(result);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open product selection. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
                  builder: (context, state) {
                    print('MobileLayout: Building with ${state.products.length} products');
                    return state.products.isEmpty
                        ? const SizedBox.shrink()
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Products (${state.products.length})',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                _buildSelectedProductSection(
                                  context,
                                  state.products,
                                ),
                              ],
                            ),
                          );
                  },
                ),

                // add product container
                Container(
                  margin: 16.padding,
                  padding: 20.padding,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () => _navigateToProductSelection(context, bookingData),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.purple.shade600,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add Products',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Browse and select products for your booking',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                        hintText: 'Add any special notes or requirements',
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
            final currentProducts = context.read<AddBookingProductsCubit>().state.products;
            print('Current products before navigation: ${currentProducts.length}');
            
            // Use MaterialPageRoute to directly navigate to SelectProductScreen
            final result = await Navigator.of(context).push<List<ProductSelectedModel>>(
              MaterialPageRoute(
                builder: (context) => SelectProductScreen(
                  serviceId: bookingData.serviceId ?? 0,
                  pickupDate: bookingData.pickupDate ?? '',
                  returnDate: bookingData.returnDate ?? '',
                  pickupTime: bookingData.pickupTime,
                  returnTime: bookingData.returnTime,
                  preSelectedData: currentProducts,
                  useAvailableProductsApi: true,
                  isSales: false,
                ),
              ),
            );
            
            if (result != null && result.isNotEmpty) {
              print('Navigation returned ${result.length} products');
              for (int i = 0; i < result.length; i++) {
                print('Returned product $i: ${result[i].variant.name}');
              }
              context.read<AddBookingProductsCubit>().setAll(result);
              print('Updated products after navigation: ${result.length}');
            } else {
              print('Navigation returned empty or null result');
            }
          } catch (e) {
            print('Navigation error: $e');
            // Fallback: show a snackbar with error
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Unable to open product selection. Please try again.'),
                  backgroundColor: Colors.red,
                ),
              );
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
                      'Add More Products',
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
  ) {
    print('_buildSelectedProductSection: Building with ${products.length} products');
    for (int i = 0; i < products.length; i++) {
      print('Product $i: ${products[i].variant.name}');
    }
    
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxHeight: 400,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          print('Building product card for: ${product.variant.name}');
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: SelectedProductInAddBooking(
              selected: product,
              serviceId: product.variant.productId,
              selectedProductsNotifier: products,
              onRemove: () {
                context
                    .read<AddBookingProductsCubit>()
                    .removeByVariantId(product.variant.variantId);
              },
            ),
          );
        },
      ),
    );
  }
}