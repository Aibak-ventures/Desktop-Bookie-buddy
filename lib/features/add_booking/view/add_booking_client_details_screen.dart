import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_select_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_appbar.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_payment_screen.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/cubit/staff_search_cubit.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        'Add Booking',
        leadingIcon: const Icon(Icons.arrow_back_ios_new_rounded),
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      CustomTextField(
                        controller: _staffNameController,
                        hintText: 'Staff Name',
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(Icons.person),
                        validator: AppInputValidators.name,
                      ),
                      0.02.heightCustom,

                      //Client details
                     ClientSelectWidget(
                        nameController: _nameController,
                        phone1Controller: _phone1Controller,
                        phone2Controller: _phone2Controller,
                        isClientSearchEnabledNotifier:
                            isClientSearchEnabledNotifier,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
           Padding(
            padding: context.isMobile ? 14.padding : (40, 16).padding,
            child: CustomElevatedButton(
              text: 'Next',
              width: double.infinity,
              onPressed: () async {
                if (_formKey.currentState?.validate() != true) return;

                final staff = context
                    .read<StaffSearchCubit>()
                    .state
                    .selectedStaff;
                if (staff == null) {
                  context.showSnackBar('Please select a staff', isError: true);
                  return;
                }

                final isExistingClient = isClientSearchEnabledNotifier.value;

                // get client details from client selected bloc
                final client = context.read<ClientCubit>().getSelectedClient();

                if (client == null && isExistingClient) {
                  context.showSnackBar('Please select a client', isError: true);
                  return;
                }

                await context.push(
                  AddBookingPaymentScreen(
                    newBooking: widget.addBookingModel.copyWith(
                      // staffName: _staffNameController.text.trim(),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
