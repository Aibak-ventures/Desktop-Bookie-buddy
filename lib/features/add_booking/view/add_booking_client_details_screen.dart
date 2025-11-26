import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/navigation/app_routes.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_select_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBookingClientDetailsScreen extends StatefulWidget {
  const AddBookingClientDetailsScreen({
    required this.addBookingModel,
    super.key,
  });
  final RequestBookingModel addBookingModel;
  @override
  State<AddBookingClientDetailsScreen> createState() =>
      _AddBookingClientDetailsScreenState();
}

class _AddBookingClientDetailsScreenState
    extends State<AddBookingClientDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _staffNameController = TextEditingController();
  final _phone1Controller = TextEditingController();
  final _phone2Controller = TextEditingController();
  final _addressController = TextEditingController();

  // notifiers
  final isClientSearchEnabledNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _nameController.dispose();
    _staffNameController.dispose();
    _phone1Controller.dispose();
    _phone2Controller.dispose();
    _addressController.dispose();

    // notifiers
    isClientSearchEnabledNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<ClientCubit>().clearSelected();
    context.read<StaffSearchCubit>()
      ..clearSelectedStaff()
      ..getAllStaffs();
    super.initState();
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
          title: const Text('Add Booking'),
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
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking Details',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Provide staff and client information for this booking',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),

        // Main content
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column - Staff Details
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
                      'Staff Details',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    StaffSearchNameField(
                      nameController: _staffNameController,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 24),

            // Right column - Client Details & Address
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // Client details card
                  Container(
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
                          'Client Information',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ClientSelectWidget(
                          nameController: _nameController,
                          phone1Controller: _phone1Controller,
                          phone2Controller: _phone2Controller,
                          isClientSearchEnabledNotifier:
                              isClientSearchEnabledNotifier,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Address card
                  Container(
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
                          'Location Details',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            CustomTextField(
                              controller: _addressController,
                              keyboardType: TextInputType.streetAddress,
                              hintText: 'Enter complete address',
                              prefixIcon: const SizedBox.shrink(),
                              maxLines: 4,
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),

        // Continue button
        Center(
          child: SizedBox(
            width: 300,
            child: CustomElevatedButton(
              text: 'Continue to Payment',
              onPressed: _handleNext,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Staff Details',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        StaffSearchNameField(
          nameController: _staffNameController,
        ),
        0.02.heightCustom,

        //Client details
        ClientSelectWidget(
          nameController: _nameController,
          phone1Controller: _phone1Controller,
          phone2Controller: _phone2Controller,
          isClientSearchEnabledNotifier: isClientSearchEnabledNotifier,
        ),

        0.03.heightCustom,
        Stack(
          children: [
            CustomTextField(
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
              hintText: 'Place',
              prefixIcon: const SizedBox.shrink(),
              maxLines: 5,
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
        if (context.isKeyboardVisible) 0.25.heightCustom,

        const SizedBox(height: 40),

        CustomElevatedButton(
          text: 'Next',
          width: double.infinity,
          onPressed: _handleNext,
        ),
      ],
    );
  }

  void _handleNext() async {
    if (_formKey.currentState?.validate() != true) return;

    final staff = context.read<StaffSearchCubit>().state.selectedStaff;
    if (staff == null) {
      context.showSnackBar('Please select a staff', isError: true);
      return;
    }

    final isExistingClient = isClientSearchEnabledNotifier.value;
    final client = context.read<ClientCubit>().getSelectedClient();

    if (client == null && isExistingClient) {
      context.showSnackBar('Please select a client', isError: true);
      return;
    }

    try {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddBookingPaymentScreen(
            whatsAppPhoneNumber: _phone1Controller.text.trim(),
            newBooking: widget.addBookingModel.copyWith(
              address: _addressController.text.trim(),
              staffId: staff.id,
              clientId: isExistingClient ? client?.id : null,
              client: isExistingClient
                  ? null
                  : ClientRequestModel(
                      id: null,
                      name: _nameController.text.trim(),
                      phone1: _phone1Controller.text.toInt(),
                      phone2: _phone2Controller.text.isNotEmpty
                          ? _phone2Controller.text.toIntOrNull()
                          : null,
                    ),
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint('Navigation error: $e');
      context.showSnackBar('Navigation error occurred', isError: true);
    }
  }

  void handlePop(bool didPop, Object? result) async {
    if (didPop) {
      return;
    }

    if (_staffNameController.text.trim().isEmpty &&
        _nameController.text.trim().isEmpty &&
        _addressController.text.trim().isEmpty) {
      NavigatorX(context).pop();
      return;
    }
    final result = await showDiscardDialog(context);
    if (result ?? false) {
      NavigatorX(context).pop();
    }
  }
}
