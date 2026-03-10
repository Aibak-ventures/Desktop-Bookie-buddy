import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_select_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/add_old_booking/view/widgets/add_old_booking_dates_section.dart';
import 'package:bookie_buddy_web/features/add_old_booking/view/widgets/add_old_booking_products_section.dart';
import 'package:bookie_buddy_web/features/add_old_booking/view_model/bloc_add_old_bookings/add_old_bookings_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddOldBookingScreen extends StatefulWidget {
  const AddOldBookingScreen({super.key});

  @override
  State<AddOldBookingScreen> createState() => _AddOldBookingScreenState();
}

class _AddOldBookingScreenState extends State<AddOldBookingScreen> {
  // key
  final formKey = GlobalKey<FormState>();

  // Date controllers
  final bookedDateController = TextEditingController();
  final pickUpDateController = TextEditingController();
  final returnDateController = TextEditingController();

  // Client controllers
  final nameController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();

  // other controllers
  final placeController = TextEditingController();
  final descriptionController = TextEditingController();

  // Product notifier
  final selectedProductsNotifier = ValueNotifier(<ProductSelectedModel>[]);

  @override
  void dispose() {
    // date controllers
    bookedDateController.dispose();
    pickUpDateController.dispose();
    returnDateController.dispose();

    // client controllers
    nameController.dispose();
    phone1Controller.dispose();
    phone2Controller.dispose();

    // other controllers
    placeController.dispose();
    descriptionController.dispose();

    // notifier
    selectedProductsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Old Booking'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: context.isMobile ? 16.padding : (40, 16).padding,
          children: [
            // dates
            AddOldBookingDatesSection(
              bookedDateController: bookedDateController,
              pickUpDateController: pickUpDateController,
              returnDateController: returnDateController,
            ),
            15.height,

            // client
            buildClientSection(),
            15.height,

            // products
            AddOldBookingProductsSection(
              selectedProductsNotifier: selectedProductsNotifier,
              pickUpDateController: pickUpDateController,
              returnDateController: returnDateController,
            ),

            20.height,

            Stack(
              children: [
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Add booking notes or special instructions',
                  prefixIcon: const SizedBox.shrink(),
                  maxLines: 3,
                  validator: (value) => AppInputValidators.isEmpty(value)
                      ? null
                      : AppInputValidators.address(value),
                ),
                Positioned(
                  top: 16,
                  left: 12,
                  child: Icon(
                    Icons.description,
                    color: AppColors.purple.lighten(0.2),
                  ),
                ),
              ],
            ),

            30.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: selectedProductsNotifier,
                    builder: (context, selectedProducts, child) {
                      final total = selectedProducts.fold(
                        0,
                        (pe, e) => pe + e.amount,
                      );
                      return Text(
                        'Total: ${total.toCurrency()}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.purple,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    // width: double.maxFinite,
                    height: 45.w,
                    child:
                        BlocConsumer<AddOldBookingsBloc, AddOldBookingsState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          orElse: () {},
                          failure: (message) => context.showSnackBar(
                            message,
                            isError: true,
                          ),
                          success: () {
                            // context.pop();
                            context.showSnackBar(
                              'Booking added successfully',
                            );

                            // clear all data
                            bookedDateController.clear();
                            pickUpDateController.clear();
                            returnDateController.clear();
                            nameController.clear();
                            phone1Controller.clear();
                            phone2Controller.clear();
                            placeController.clear();
                            descriptionController.clear();
                            selectedProductsNotifier.value = [];
                          },
                        );
                      },
                      builder: (context, state) {
                        final isLoading = state.maybeMap(
                          orElse: () => false,
                          submitting: (value) => true,
                        );
                        return ElevatedButton(
                          onPressed: () {
                            if (isLoading) return;
                            if (!formKey.currentState!.validate()) return;
                            final clientId = context
                                .read<ClientCubit>()
                                .getSelectedClient()
                                ?.id;
                            if (clientId == null) {
                              context.showSnackBar(
                                'Please select a client',
                                title: 'Client Error',
                                isError: true,
                              );
                              return;
                            }
                            if (selectedProductsNotifier.value.isEmpty) {
                              context.showSnackBar(
                                'Please select a product',
                                title: 'Product Error',
                                isError: true,
                              );
                              return;
                            }
                            final totalAmount =
                                selectedProductsNotifier.value.fold(
                              0,
                              (pe, e) => pe + e.amount,
                            );
                            final bookingRequest = RequestBookingModel(
                              bookedDate: bookedDateController.text.isEmpty
                                  ? null
                                  : bookedDateController.text.formatToUiDate(),
                              pickupDate:
                                  pickUpDateController.text.formatToUiDate(),
                              returnDate:
                                  returnDateController.text.formatToUiDate(),
                              clientId: clientId,
                              address: placeController.text.trim(),
                              description:
                                  descriptionController.text.trim().isEmpty
                                      ? null
                                      : descriptionController.text.trim(),
                              products: selectedProductsNotifier.value,
                              deliveryStatus: DeliveryStatus.returned,
                              paymentMethod: PaymentMethod.cash,
                              bookingStatus: BookingStatus.completed,
                              advanceAmount: totalAmount,
                            );

                            context.read<AddOldBookingsBloc>().add(
                                AddOldBookingsEvent.addBooking(bookingRequest));
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  backgroundColor: AppColors.white,
                                )
                              : const Text(
                                  'Save Booking',
                                  style: TextStyle(
                                    color: AppColors.white,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            20.height,
          ],
        ),
      ),
    );
  }

  Widget buildClientSection() {
    return Column(
      children: [
        ClientSelectWidget(
          isClientSearchEnabledNotifier: ValueNotifier(true),
          nameController: nameController,
          phone1Controller: phone1Controller,
          phone2Controller: phone2Controller,
          textSize: 16,
          spacing: 15,
        ),
        15.height,
        Stack(
          children: [
            CustomTextField(
              controller: placeController,
              keyboardType: TextInputType.streetAddress,
              hintText: 'Enter pickup/delivery location',
              prefixIcon: const SizedBox.shrink(),
              maxLines: 3,
              validator: AppInputValidators.address,
            ),
            Positioned(
              top: 16,
              left: 12,
              child: Icon(
                Icons.location_on,
                color: AppColors.purple.lighten(0.2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
