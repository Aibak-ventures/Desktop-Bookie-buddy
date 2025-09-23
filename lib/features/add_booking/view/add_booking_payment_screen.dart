import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/screens/success_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_snack_bar.dart';
import 'package:bookie_buddy_web/features/add_booking/models/add_booking_model/add_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/widgets/add_booking_select_status_widget.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/bloc_add_booking/add_booking_bloc.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/ui/widgets/custom_appbar.dart';
import '../../../core/ui/widgets/custom_button.dart';
import '../../../core/ui/widgets/custom_textfield.dart';

class AddBookingPaymentScreen extends StatefulWidget {
  const AddBookingPaymentScreen({
    required this.newBooking,
    super.key,
  });
  final AddBookingModel newBooking;

  @override
  _AddBookingPaymentScreenState createState() =>
      _AddBookingPaymentScreenState();
}

class _AddBookingPaymentScreenState extends State<AddBookingPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final paymentOptionNotifier = ValueNotifier(PaymentMethod.gPay);
  final purchaseModeNotifier = ValueNotifier(PurchaseMode.normal);
  final deliveryStatusNotifier = ValueNotifier(DeliveryStatus.booked);

  // controllers
  final advanceAmountController = TextEditingController();
  final securityAmountController = TextEditingController();
  final discountAmountController = TextEditingController();

  late final double totalAmount;

  @override
  void initState() {
    totalAmount =
        widget.newBooking.products!.fold(0, (sum, item) => sum + item.amount);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    paymentOptionNotifier.dispose();
    purchaseModeNotifier.dispose();
    deliveryStatusNotifier.dispose();

    // controllers
    advanceAmountController.dispose();
    securityAmountController.dispose();
    discountAmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        'Payment Details',
        leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded),
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: context.isMobile ? 14.padding : (40, 16).padding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      Text(
                        'Client Payment Details',
                        style: TextStyle(
                          fontSize: 19.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Total Amount : ${totalAmount.toCurrency()}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      CustomTextField(
                        controller: advanceAmountController,
                        label: 'Advance Amount (Optional)',
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.currency_rupee),
                        validator: (value) {
                          return AppInputValidators.isEmpty(value)
                              ? null
                              : AppInputValidators.amount(
                                  value,
                                  allowZero: true,
                                  fieldName: 'Advance Amount',
                                );
                        },
                      ),

                      CustomTextField(
                        controller: securityAmountController,
                        label: 'Security Amount (Optional)',
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.currency_rupee),
                        validator: (value) {
                          return AppInputValidators.isEmpty(value)
                              ? null
                              : AppInputValidators.amount(
                                  value,
                                  allowZero: true,
                                  fieldName: 'Security Amount',
                                );
                        },
                      ),
                      CustomTextField(
                        controller: discountAmountController,
                        label: 'Discount Amount (Optional)',
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(Icons.currency_rupee),
                        validator: (value) {
                          return AppInputValidators.isEmpty(value)
                              ? null
                              : AppInputValidators.amount(
                                  value,
                                  allowZero: true,
                                  fieldName: 'Discount Amount',
                                );
                        },
                      ),

                      //

                      AddBookingSelectStatusWidget(
                        deliveryStatusNotifier: deliveryStatusNotifier,
                        paymentOptionNotifier: paymentOptionNotifier,
                        purchaseModeNotifier: purchaseModeNotifier,
                        advanceAmountController: advanceAmountController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BlocConsumer<AddBookingBloc, AddBookingState>(
            listener: (context, state) {
              state.maybeWhen(
                  orElse: () {},
                  error: (message) {
                    CustomSnackBar(
                      title: 'Error',
                      message: message,
                    );
                  },
                  success: () {
                    context
                        .push(const SuccessScreen(text: 'Booked Successfully'));
                    context
                        .read<DashboardBloc>()
                        .add(const DashboardEvent.loadDashboardData());
                  });
            },
            builder: (context, state) {
              final isSubmitting = state.maybeWhen(
                orElse: () => false,
                submitting: () => true,
              );
              return Padding(
                padding: context.isMobile ? 14.padding : (40, 16).padding,
                child: CustomElevatedButton(
                  text: 'Confirm Booking',
                  width: double.infinity,
                  isLoading: isSubmitting,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _showConfirmationDialog();
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Booking',
          ),
          content: const Text('Are you sure you want to confirm this booking?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.black),
              ),
              onPressed: () {
                context.pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: const Text(
                'Confirm',
                style: TextStyle(color: AppColors.white),
              ),
              onPressed: () async {
                context.hideKeyboard();
                context.pop(); // Close the dialog
                final advanceAmount =
                    advanceAmountController.text.trim().toIntOrNull();
                final securityAmount =
                    securityAmountController.text.trim().toIntOrNull() ?? 0;
                final discountAmount =
                    discountAmountController.text.trim().toIntOrNull() ?? 0;

                if (advanceAmount != null && advanceAmount > totalAmount) {
                  return context.showSnackBar(
                    'Advance amount cannot be greater than total amount ${totalAmount.toCurrency()}',
                    isError: true,
                  );
                }
                if (discountAmount > (totalAmount - (advanceAmount ?? 0))) {
                  return context.showSnackBar(
                    'Discount amount cannot be greater than remaining amount ${((totalAmount - (advanceAmount ?? 0)).toCurrency())}',
                    isError: true,
                  );
                }

                final newBooking = widget.newBooking.copyWith(
                  advanceAmount: advanceAmount == null ? null : advanceAmount,
                  securityAmount: securityAmount,
                  discountAmount: discountAmount,
                  paymentMethod: paymentOptionNotifier.value.toValue(),
                  purchaseMode: purchaseModeNotifier.value.toValue(),
                  deliveryStatus: deliveryStatusNotifier.value.toValue(),
                  pickupDate:
                      '${widget.newBooking.pickupDate!.formatToUiDate()}T${widget.newBooking.pickupTime?.formatToTime(addSeconds: true) ?? '00:00:00'}',
                  returnDate:
                      '${widget.newBooking.returnDate}T${widget.newBooking.returnTime?.formatToTime(addSeconds: true) ?? '23:59:59'}',
                );

                final bloc = context.read<AddBookingBloc>();
                bloc.add(
                  AddBookingEvent.addNewBooking(
                    newBooking,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
