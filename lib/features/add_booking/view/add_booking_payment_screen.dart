import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/screens/success_animation_screen.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/widgets/add_additional_charges_widget.dart';
import 'package:bookie_buddy_web/features/add_booking/view/widgets/add_booking_select_status_widget.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/bloc_add_booking/add_booking_bloc.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:bookie_buddy_web/features/main/view/bottom_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

import '../../../core/ui/widgets/custom_button.dart';
import '../../../core/ui/widgets/custom_textfield.dart';

class AddBookingPaymentScreen extends StatefulWidget {
  const AddBookingPaymentScreen({
    super.key,
    required this.newBooking,
    required this.whatsAppPhoneNumber,
  });
  final RequestBookingModel newBooking;

  final String whatsAppPhoneNumber;

  @override
  _AddBookingPaymentScreenState createState() =>
      _AddBookingPaymentScreenState();
}

class _AddBookingPaymentScreenState extends State<AddBookingPaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  // notifiers
  final paymentOptionNotifier = ValueNotifier(PaymentMethod.gPay);
  final purchaseModeNotifier = ValueNotifier(PurchaseMode.normal);
  final isSharingPdfToWhatsAppNotifier = ValueNotifier(false);
  final deliveryStatusNotifier = ValueNotifier(DeliveryStatus.booked);
  final additionalChargesNotifier = ValueNotifier<List<AdditionalChargesModel>>(
    [],
  );

  // controllers
  final advanceAmountController = TextEditingController();
  final additionalAmountController =
      TextEditingController(); // Additional charges field
  final securityAmountController = TextEditingController();
  final discountAmountController = TextEditingController();

  late final double totalAmount;

  @override
  void initState() {
    totalAmount = widget.newBooking.products!.fold(
      0,
      (sum, item) => sum + item.amount,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    // notifiers
    paymentOptionNotifier.dispose();
    purchaseModeNotifier.dispose();
    deliveryStatusNotifier.dispose();
    additionalChargesNotifier.dispose();
    isSharingPdfToWhatsAppNotifier.dispose();

    // controllers
    advanceAmountController.dispose();
    additionalAmountController.dispose();
    securityAmountController.dispose();
    discountAmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = context.screenWidth > 768;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: handlePop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: isWeb ? const Color(0xFFF5F7FA) : null,
        appBar: AppBar(
          title: const Text('Payment Details'),
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
                padding:
                    isWeb ? const EdgeInsets.all(40) : const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: isWeb ? _buildWebLayout() : _buildMobileLayout(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment & Booking Details',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Configure payment amounts and booking preferences',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.attach_money, color: Colors.green.shade600),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Amount: ${totalAmount.toCurrency()}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),

        // Main content in two columns
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column - Payment Details
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
                      'Payment Details',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    CustomTextField(
                      controller: advanceAmountController,
                      label: 'Advance Amount (Optional)',
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.currency_rupee),
                      validator: (value) => AppInputValidators.isEmpty(value)
                          ? null
                          : AppInputValidators.amount(
                              value,
                              allowZero: true,
                              fieldName: 'Advance Amount',
                            ),
                    ),

                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: securityAmountController,
                      label: 'Security Amount (Optional)',
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.currency_rupee),
                      validator: (value) => AppInputValidators.isEmpty(value)
                          ? null
                          : AppInputValidators.amount(
                              value,
                              allowZero: true,
                              fieldName: 'Security Amount',
                            ),
                    ),

                    const SizedBox(height: 16),

                    // Additional charges field removed as requested

                    CustomTextField(
                      controller: discountAmountController,
                      label: 'Discount Amount (Optional)',
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.currency_rupee),
                      validator: (value) => AppInputValidators.isEmpty(value)
                          ? null
                          : AppInputValidators.amount(
                              value,
                              allowZero: true,
                              fieldName: 'Discount Amount',
                            ),
                    ),

                    const SizedBox(height: 24),

                    AddAdditionalChargesWidget(
                      additionalChargesNotifier: additionalChargesNotifier,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 24),

            // Right column - Booking Settings
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
                      'Booking Settings',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AddBookingSelectStatusWidget(
                      deliveryStatusNotifier: deliveryStatusNotifier,
                      paymentOptionNotifier: paymentOptionNotifier,
                      isSharingPdfToWhatsAppNotifier:
                          isSharingPdfToWhatsAppNotifier,
                      advanceAmountController: advanceAmountController,
                      whatsAppNumber: widget.whatsAppPhoneNumber,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),

        // Confirm button
        BlocConsumer<AddBookingBloc, AddBookingState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              submitting: () => context.hideKeyboard(),
              error: (message) {
                context.showSnackBar(message, isError: true);
              },
              success: () {
                context.clearSnackBars();

                // Refresh dashboard to show new booking
                context.read<DashboardBloc>().add(
                      const DashboardEvent.loadDashboardData(),
                    );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessAnimationScreen(
                      text: 'Booked Successfully',
                      afterSuccess: () {
                        // Optional: callback to run after animation success
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BottomBarScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            final isSubmitting = state.maybeWhen(
              orElse: () => false,
              submitting: () => true,
            );
            return Center(
              child: SizedBox(
                width: 300,
                child: CustomElevatedButton(
                  text: 'Confirm Booking',
                  isLoading: isSubmitting,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _showConfirmationDialog();
                    }
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
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
          validator: (value) => AppInputValidators.isEmpty(value)
              ? null
              : AppInputValidators.amount(
                  value,
                  allowZero: true,
                  fieldName: 'Advance Amount',
                ),
        ),
        CustomTextField(
          controller: securityAmountController,
          label: 'Security Amount (Optional)',
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.currency_rupee),
          validator: (value) => AppInputValidators.isEmpty(value)
              ? null
              : AppInputValidators.amount(
                  value,
                  allowZero: true,
                  fieldName: 'Security Amount',
                ),
        ),
        CustomTextField(
          controller: discountAmountController,
          label: 'Discount Amount (Optional)',
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.currency_rupee),
          validator: (value) => AppInputValidators.isEmpty(value)
              ? null
              : AppInputValidators.amount(
                  value,
                  allowZero: true,
                  fieldName: 'Discount Amount',
                ),
        ),
        AddAdditionalChargesWidget(
          additionalChargesNotifier: additionalChargesNotifier,
        ),
        AddBookingSelectStatusWidget(
          deliveryStatusNotifier: deliveryStatusNotifier,
          paymentOptionNotifier: paymentOptionNotifier,
          isSharingPdfToWhatsAppNotifier: isSharingPdfToWhatsAppNotifier,
          advanceAmountController: advanceAmountController,
          whatsAppNumber: widget.whatsAppPhoneNumber,
        ),
        const SizedBox(height: 40),
        BlocConsumer<AddBookingBloc, AddBookingState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              submitting: () => context.hideKeyboard(),
              error: (message) {
                context.showSnackBar(message, isError: true);
              },
              success: () {
                context.clearSnackBars();

                // Refresh dashboard to show new booking
                context.read<DashboardBloc>().add(
                      const DashboardEvent.loadDashboardData(),
                    );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessAnimationScreen(
                      text: 'Booked Successfully',
                      afterSuccess: () {
                        // Navigate to home and trigger refresh of dashboard
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const BottomBarScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            final isSubmitting = state.maybeWhen(
              orElse: () => false,
              submitting: () => true,
            );
            return CustomElevatedButton(
              text: 'Confirm Booking',
              width: double.infinity,
              isLoading: isSubmitting,
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _showConfirmationDialog();
                }
              },
            );
          },
        ),
      ],
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm Booking'),
        content: const Text('Are you sure you want to confirm this booking?'),
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.black),
            ),
            onPressed: () {
              NavigatorX(context).pop(); // Close the dialog
            },
          ),
          ElevatedButton(
            child: const Text(
              'Confirm',
              style: TextStyle(color: AppColors.white),
            ),
            onPressed: () async {
              NavigatorX(context).pop();
              final advanceAmount =
                  advanceAmountController.text.trim().toIntOrNull();
              final securityAmount =
                  securityAmountController.text.trim().toIntOrNull() ?? 0;
              final discountAmount =
                  discountAmountController.text.trim().toIntOrNull() ?? 0;
              final additionalAmount =
                  additionalAmountController.text.trim().toIntOrNull() ?? 0;

              // Calculate final total including additional charges
              final finalTotalAmount = totalAmount + additionalAmount;

              if (advanceAmount != null && advanceAmount > finalTotalAmount) {
                return context.showSnackBar(
                  'Advance amount cannot be greater than total amount ${finalTotalAmount.toCurrency()}',
                  isError: true,
                );
              }
              if (discountAmount > (finalTotalAmount - (advanceAmount ?? 0))) {
                return context.showSnackBar(
                  'Discount amount cannot be greater than remaining amount ${(finalTotalAmount - (advanceAmount ?? 0)).toCurrency()}',
                  isError: true,
                );
              }

              final newBooking = widget.newBooking.copyWith(
                advanceAmount: advanceAmount == null ? null : advanceAmount,
                securityAmount: securityAmount,
                discountAmount: discountAmount,
                paymentMethod: paymentOptionNotifier.value,
                deliveryStatus: deliveryStatusNotifier.value,
                pickupDate:
                    '${widget.newBooking.pickupDate!.formatToUiDate()}T${widget.newBooking.pickupTime?.formatToTime(addSeconds: true) ?? '00:00:00'}',
                returnDate: () {
                  final returnDateStr = widget.newBooking.returnDate!;
                  var returnTimeStr = widget.newBooking.returnTime
                          ?.formatToTime(addSeconds: true) ??
                      '23:59:59';

                  // If same day booking, ensure return time is after pickup time
                  if (widget.newBooking.pickupDate!.formatToUiDate() ==
                          returnDateStr &&
                      widget.newBooking.pickupTime != null &&
                      widget.newBooking.returnTime != null) {
                    final pickupMinutes =
                        widget.newBooking.pickupTime!.hour * 60 +
                            widget.newBooking.pickupTime!.minute;
                    final returnMinutes =
                        widget.newBooking.returnTime!.hour * 60 +
                            widget.newBooking.returnTime!.minute;

                    // If return time is not after pickup time, use pickup time + 1 hour
                    if (returnMinutes <= pickupMinutes) {
                      final newHour =
                          (widget.newBooking.pickupTime!.hour + 1) % 24;
                      final minute = widget.newBooking.pickupTime!.minute;
                      returnTimeStr =
                          '${newHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';
                    }
                  }

                  return '${returnDateStr}T${returnTimeStr}';
                }(),
                coolingPeriodDate:
                    widget.newBooking.coolingPeriodDate.isNullOrEmpty
                        ? null
                        : '${widget.newBooking.coolingPeriodDate}T23:59:59',

                additionalCharges: [], // Removed additional charges as requested
                sendPdfToWhatsApp: isSharingPdfToWhatsAppNotifier.value,
              );

              context.read<AddBookingBloc>().add(
                    AddBookingEvent.addNewBooking(newBooking),
                  );
            },
          ),
        ],
      ),
    );
  }

  void handlePop(bool didPop, Object? result) async {
    if (didPop) {
      return;
    }

    if (advanceAmountController.text.trim().isEmpty &&
        securityAmountController.text.trim().isEmpty &&
        discountAmountController.text.trim().isEmpty) {
      NavigatorX(context).pop();
      return;
    }
    final result = await showDiscardDialog(context);
    if (result ?? false) {
      NavigatorX(context).pop();
    }
  }
}
