import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/widgets/responsive_widget.dart';
import 'package:bookie_buddy_web/features/add_booking/models/add_booking_model/add_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_client_details_screen.dart';
import 'package:bookie_buddy_web/features/add_booking/view/widgets/selected_product_in_add_booking.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBookingProductScreen extends StatelessWidget {
  AddBookingProductScreen({
    required this.addBookingModel,
    required this.selectedProductsNotifier,
    super.key,
  });

  final AddBookingModel addBookingModel;
  // final List<ProductSelectedModel> selectedProducts;

  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;

  final locationStartController = TextEditingController();
  final locationFromController = TextEditingController();
  final locationToController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bookingData = addBookingModel;
    final isDesktop = kIsWeb || 
        Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.linux;

    return Scaffold(
      backgroundColor: isDesktop ? const Color(0xFFF5F7FA) : null,
      appBar: AppBar(
        title: const Text('Add Products'),
        backgroundColor: isDesktop ? Colors.white : null,
        elevation: isDesktop ? 0.5 : null,
      ),
      body: ResponsiveWidget(
        mobile: _buildMobileLayout(context, bookingData),
        tablet: _buildWebLayout(context, bookingData),
        desktop: _buildWebLayout(context, bookingData),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, AddBookingModel bookingData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                ValueListenableBuilder(
                  valueListenable: selectedProductsNotifier,
                  builder: (context, products, child) => products.isEmpty
                      ? const SizedBox.shrink()
                      : _buildSelectedProductSection(),
                ),
                _addProductContainerBuilder(context, bookingData),
                const SizedBox(height: 16),
                if ((selectedProductsNotifier.value.firstOrNull?.variant
                        .mainServiceType.isVehicle) ?? false)
                  _buildLocationFields(context),
                _buildDescriptionField(context),
                SizedBox(
                  height: context.mediaQuery.viewInsets.bottom > 0 
                      ? MediaQuery.of(context).size.height * 0.35
                      : MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: _buildNextButton(context),
        ),
      ],
    );
  }

  Widget _buildWebLayout(BuildContext context, AddBookingModel bookingData) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8F9FF),
            const Color(0xFFF0F4FF),
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1200),
          margin: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header Section
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF667eea),
                          const Color(0xFF764ba2),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.add_business_outlined,
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
                                'Add Products & Services',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Configure your booking details and select products',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content Section
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column - Product Selection
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product Selection',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1a1a1a),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ValueListenableBuilder(
                                  valueListenable: selectedProductsNotifier,
                                  builder: (context, products, child) => products.isEmpty
                                      ? _buildWebEmptyState(context, bookingData)
                                      : _buildSelectedProductSection(),
                                ),
                                const SizedBox(height: 24),
                                _buildWebAddProductCard(context, bookingData),
                              ],
                            ),
                          ),
                          const SizedBox(width: 32),
                          // Right Column - Details
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if ((selectedProductsNotifier.value.firstOrNull?.variant
                                        .mainServiceType.isVehicle) ?? false) ...[
                                  _buildWebLocationSection(context),
                                  const SizedBox(height: 24),
                                ],
                                _buildWebDescriptionSection(context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Footer Section
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ValueListenableBuilder(
                            valueListenable: selectedProductsNotifier,
                            builder: (context, products, child) {
                              final total = products.fold(0, (int prev, element) => prev + element.amount);
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Total Amount: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: const Color(0xFF6b7280),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '₹${total.toString()}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF667eea),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 24),
                        SizedBox(
                          width: 200,
                          child: _buildNextButton(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebEmptyState(BuildContext context, AddBookingModel bookingData) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF667eea).withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 48,
              color: const Color(0xFF667eea),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No Products Selected',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start by adding products to your booking',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWebAddProductCard(BuildContext context, AddBookingModel bookingData) {
    return ValueListenableBuilder(
      valueListenable: selectedProductsNotifier,
      builder: (context, products, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF667eea),
                const Color(0xFF764ba2),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667eea).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                final result = await context.push(SelectProductScreen(
                  serviceId: bookingData.serviceId!,
                  preSelectedData: selectedProductsNotifier.value,
                  pickupDate: bookingData.pickupDate!,
                  returnDate: bookingData.returnDate!,
                  pickupTime: bookingData.pickupTime,
                  returnTime: bookingData.returnTime,
                ));
                if (result != null) {
                  selectedProductsNotifier.value =
                      List<ProductSelectedModel>.from(result);
                }
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products.isEmpty ? 'Add Products' : 'Add More Products',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            products.isEmpty 
                                ? 'Browse and select products for your booking'
                                : 'Continue adding more products to your selection',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWebLocationSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: const Color(0xFF667eea),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Location Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1a1a1a),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: locationStartController,
            label: 'Start Location',
            hintText: 'Enter start location',
            prefixIcon: const Icon(Icons.trip_origin),
            validator: (value) => AppInputValidators.basicText(
              value,
              isRequired: false,
              fieldName: 'Start Location',
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: locationFromController,
            label: 'Pickup Location',
            hintText: 'Enter pickup location',
            prefixIcon: const Icon(Icons.location_on),
            validator: (value) => AppInputValidators.basicText(
              value,
              isRequired: false,
              fieldName: 'Pickup Location',
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: locationToController,
            label: 'Destination',
            hintText: 'Enter destination',
            prefixIcon: const Icon(Icons.flag),
            validator: (value) => AppInputValidators.basicText(
              value,
              isRequired: false,
              fieldName: 'Destination',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebDescriptionSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: const Color(0xFF667eea),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Additional Notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1a1a1a),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: descriptionController,
            hintText: 'Add any additional notes or requirements...',
            maxLines: 6,
            minLines: 4,
            validator: (value) => AppInputValidators.basicText(
              value,
              isRequired: false,
              fieldName: 'Description',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Locations',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: locationStartController,
            label: 'Start Location',
            hintText: 'Location',
            prefixIcon: const Icon(Icons.place_outlined),
            validator: (value) => AppInputValidators.basicText(
              value,
              isRequired: false,
              fieldName: 'Place',
            ),
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: locationFromController,
            label: 'Pickup Location',
            hintText: 'Location',
            prefixIcon: const Icon(Icons.place_outlined),
            validator: (value) => AppInputValidators.basicText(
              value,
              isRequired: false,
              fieldName: 'Place',
            ),
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: locationToController,
            label: 'Destination',
            hintText: 'Location',
            prefixIcon: const Icon(Icons.place_outlined),
            validator: (value) => AppInputValidators.basicText(
              value,
              isRequired: false,
              fieldName: 'Place',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          CustomTextField(
            controller: descriptionController,
            hintText: 'Add Description here...',
            prefixIcon: const SizedBox.shrink(),
            maxLines: 30,
            minLines: 4,
            validator: (value) => AppInputValidators.basicText(
              value,
              isRequired: false,
              fieldName: 'Description',
            ),
          ),
          Positioned(
            top: 16,
            left: 12,
            child: Icon(
              Icons.edit_note_rounded,
              color: AppColors.purple.lighten(0.2),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return CustomElevatedButton(
      width: double.infinity,
      onPressed: () async {
        if (selectedProductsNotifier.value.isEmpty) {
          CustomSnackBar(message: 'Please select at least one product');
          return;
        }

        final total = selectedProductsNotifier.value
            .fold(0, (int prev, element) => prev + element.amount);
        if (total <= 0) {
          CustomSnackBar(
            message: 'Product amount total must be greater than 0',
            isError: true,
          );
          return;
        }

        context.push(
          AddBookingClientDetailsScreen(
            addBookingModel: addBookingModel.copyWith(
              products: selectedProductsNotifier.value,
              description: descriptionController.text.trim(),
              locationStart: locationStartController.text.trim(),
              locationFrom: locationFromController.text.trim(),
              locationTo: locationToController.text.trim(),
            ),
          ),
        );
      },
      text: 'Next',
    );
  }

  Container _addProductContainerBuilder(
      BuildContext context, AddBookingModel bookingData) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(30),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: AppColors.grey400,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.purpleLightShade,
          borderRadius: BorderRadius.circular(5),
        ),
        width: MediaQuery.of(context).size.width * 0.5,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          children: [
            const Icon(
              Icons.add,
              color: AppColors.purple,
            ),
            ValueListenableBuilder(
              valueListenable: selectedProductsNotifier,
              builder: (context, value, child) {
                return Text(
                  value.isEmpty ? 'Add products' : 'Add more',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.purple,
                  ),
                );
              },
            ),
          ],
        ),
      ).onTap(
        () async {
          final result = await context.push(SelectProductScreen(
            serviceId: bookingData.serviceId!,
            preSelectedData: selectedProductsNotifier.value,
            pickupDate: bookingData.pickupDate!,
            returnDate: bookingData.returnDate!,
            pickupTime: bookingData.pickupTime,
            returnTime: bookingData.returnTime,
          ));
          if (result != null) {
            selectedProductsNotifier.value =
                List<ProductSelectedModel>.from(result);
          }
        },
      ),
    );
  }

  Widget _buildSelectedProductSection() {
    return Column(
      children: selectedProductsNotifier.value.map((selected) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: SelectedProductInAddBooking(
            serviceId: addBookingModel.serviceId,
            selected: selected,
            onRemove: () {
              selectedProductsNotifier.value = selectedProductsNotifier.value
                  .where((item) => item != selected)
                  .toList();
            },
            selectedProductsNotifier: selectedProductsNotifier,
          ),
        );
      }).toList(),
    );
  }
}
