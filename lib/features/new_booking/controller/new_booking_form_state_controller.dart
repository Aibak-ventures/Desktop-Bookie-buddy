// import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
// import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
// import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
// import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
// import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
// import 'package:bookie_buddy_web/features/new_booking/models/document_file_model.dart';
// import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// /// Form state controller for New Booking screen
// /// Manages all form controllers, notifiers, and validation logic
// class NewBookingFormStateController {
//   // Form key
//   final formKey = GlobalKey<FormState>();

//   // Date controllers
//   final pickupDateController = TextEditingController();
//   final returnDateController = TextEditingController();
//   final coolingPeriodDateController = TextEditingController();

//   // Time controllers
//   final pickupTimeController = TextEditingController();
//   final returnTimeController = TextEditingController();

//   // Staff
//   final staffNameController = TextEditingController();

//   // Client
//   final clientNameController = TextEditingController();
//   final clientPhone1Controller = TextEditingController();
//   final clientPhone2Controller = TextEditingController();
//   final clientAddressController = TextEditingController();

//   // Location (for delivery services)
//   final startLocationController = TextEditingController();
//   final pickupLocationController = TextEditingController();
//   final destinationLocationController = TextEditingController();

//   // Payment
//   final advanceAmountController = TextEditingController();
//   final securityAmountController = TextEditingController();
//   final discountAmountController = TextEditingController();

//   // Other
//   final descriptionController = TextEditingController();
//   final runningKilometersController = TextEditingController();

//   // Notifiers
//   final selectedProductsNotifier =
//       ValueNotifier<List<ProductSelectedModel>>([]);
//   final stockCountDecreaseNotifier = ValueNotifier<bool>(true);
//   final additionalChargesNotifier =
//       ValueNotifier<List<AdditionalChargesModel>>([]);
//   final documentsNotifier = ValueNotifier<List<DocumentFile>>([]);
//   final paymentMethodNotifier = ValueNotifier(PaymentMethod.gPay);
//   final isClientSearchEnabledNotifier = ValueNotifier<bool>(false);
//   final sendPdfToWhatsAppNotifier = ValueNotifier<bool>(true);

//   // Time
//   TimeOfDay? pickupTime;
//   TimeOfDay? returnTime;

//   void dispose() {
//     // Dates
//     pickupDateController.dispose();
//     returnDateController.dispose();
//     coolingPeriodDateController.dispose();

//     // Time
//     pickupTimeController.dispose();
//     returnTimeController.dispose();

//     // Staff
//     staffNameController.dispose();

//     // Client
//     clientNameController.dispose();
//     clientPhone1Controller.dispose();
//     clientPhone2Controller.dispose();
//     clientAddressController.dispose();

//     // Location
//     startLocationController.dispose();
//     pickupLocationController.dispose();
//     destinationLocationController.dispose();

//     // Payment
//     advanceAmountController.dispose();
//     securityAmountController.dispose();
//     discountAmountController.dispose();

//     // Other
//     descriptionController.dispose();
//     runningKilometersController.dispose();

//     // Notifiers
//     selectedProductsNotifier.dispose();
//     stockCountDecreaseNotifier.dispose();
//     additionalChargesNotifier.dispose();
//     documentsNotifier.dispose();
//     paymentMethodNotifier.dispose();
//     isClientSearchEnabledNotifier.dispose();
//     sendPdfToWhatsAppNotifier.dispose();
//   }

//   /// Build a request object from the form state
//   RequestBookingModel? buildRequest({
//     required BuildContext context,
//   }) {
//     // Validate form
//     if (!(formKey.currentState?.validate() ?? true)) {
//       context.showSnackBar(
//         'Please fill all required fields',
//         title: 'Form Error',
//         isError: true,
//       );
//       return null;
//     }

//     // Validate staff
//     final selectedStaff = context.read<StaffSearchCubit>().state.selectedStaff;
//     if (selectedStaff == null) {
//       context.showSnackBar(
//         'Please select a staff',
//         title: 'Staff Required',
//         isError: true,
//       );
//       return null;
//     }

//     // Validate products
//     if (selectedProductsNotifier.value.isEmpty) {
//       context.showSnackBar(
//         'Select at least one product',
//         title: 'Product Required',
//         isError: true,
//       );
//       return null;
//     }

//     // Validate at least one product has price > 0
//     final hasProductWithPrice =
//         selectedProductsNotifier.value.any((p) => p.amount > 0);
//     if (!hasProductWithPrice) {
//       context.showSnackBar(
//         'At least one product must have a price greater than 0',
//         isError: true,
//       );
//       return null;
//     }

//     // Build request
//     try {
//       return RequestBookingModel(
//         pickupDate: pickupDateController.text,
//         returnDate: returnDateController.text,
//         coolingPeriodDate: coolingPeriodDateController.text.isNullOrEmpty
//             ? null
//             : coolingPeriodDateController.text,
//         pickupTime: pickupTimeController.text.isNullOrEmpty
//             ? null
//             : pickupTimeController.text,
//         returnTime: returnTimeController.text.isNullOrEmpty
//             ? null
//             : returnTimeController.text,
//         staffId: selectedStaff.id,
//         clientName: clientNameController.text.trim(),
//         phone1: clientPhone1Controller.text.trim().isNullOrEmpty
//             ? null
//             : int.tryParse(clientPhone1Controller.text.trim()),
//         phone2: clientPhone2Controller.text.trim().isNullOrEmpty
//             ? null
//             : int.tryParse(clientPhone2Controller.text.trim()),
//         address: clientAddressController.text.trim().isNullOrEmpty
//             ? null
//             : clientAddressController.text.trim(),
//         advanceAmount: advanceAmountController.text.trim().isNullOrEmpty
//             ? null
//             : int.tryParse(advanceAmountController.text.trim()),
//         securityAmount: securityAmountController.text.trim().isNullOrEmpty
//             ? null
//             : int.tryParse(securityAmountController.text.trim()),
//         discountAmount: discountAmountController.text.trim().isNullOrEmpty
//             ? null
//             : int.tryParse(discountAmountController.text.trim()),
//         description: descriptionController.text.trim().isNullOrEmpty
//             ? null
//             : descriptionController.text.trim(),
//         paymentMethod: paymentMethodNotifier.value,
//         products: selectedProductsNotifier.value,
//         additionalCharges: additionalChargesNotifier.value,
//         documents: documentsNotifier.value,
//         locationStart: startLocationController.text.trim().isNullOrEmpty
//             ? null
//             : startLocationController.text.trim(),
//         locationFrom: pickupLocationController.text.trim().isNullOrEmpty
//             ? null
//             : pickupLocationController.text.trim(),
//         locationTo: destinationLocationController.text.trim().isNullOrEmpty
//             ? null
//             : destinationLocationController.text.trim(),
//         runningKilometers: runningKilometersController.text.trim().isNullOrEmpty
//             ? null
//             : int.tryParse(runningKilometersController.text.trim()),
//       );
//     } catch (e) {
//       context.showSnackBar(
//         'Error creating booking request: $e',
//         title: 'Error',
//         isError: true,
//       );
//       return null;
//     }
//   }
// }
