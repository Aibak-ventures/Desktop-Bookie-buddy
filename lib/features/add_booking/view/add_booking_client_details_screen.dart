import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_select_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_appbar.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_client/client_bloc.dart';
import 'package:bookie_buddy_web/features/add_booking/models/add_booking_model/add_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_booking_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBookingClientDetailsScreen extends StatefulWidget {
  const AddBookingClientDetailsScreen({
    required this.addBookingModel,
    super.key,
  });
  final AddBookingModel addBookingModel;
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

  @override
  void dispose() {
    _nameController.dispose();
    _staffNameController.dispose();
    _phone1Controller.dispose();
    _phone2Controller.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<ClientBloc>().add(const ClientEvent.clearSelected());
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
                if (_formKey.currentState?.validate() == true) {
                  // Create a client object from form input
                  // final client = ClientModel(
                  //   name: _nameController.text,
                  //   phone1: int.parse(_phone1Controller.text),
                  //   phone2: _phone2Controller.text.isNotEmpty
                  //       ? int.parse(_phone2Controller.text)
                  //       : null,
                  // );

                  // get client details from client selected bloc
                  final client = context.read<ClientBloc>().getSelectedClient();

                  if (client == null) {
                    context.showSnackBar(
                      'Please select a client',
                      isError: true,
                    );
                    return;
                  }

                  context.push(
                    AddBookingPaymentScreen(
                      newBooking: widget.addBookingModel.copyWith(
                        staffName: _staffNameController.text.trim(),
                        clientId: client.id,
                        address: _addressController.text.trim(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
