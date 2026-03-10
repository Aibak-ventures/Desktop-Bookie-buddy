import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientSelectWidget extends StatelessWidget {
  ClientSelectWidget({
    super.key,
    required TextEditingController nameController,
    required TextEditingController phone1Controller,
    required TextEditingController phone2Controller,
    required this.isClientSearchEnabledNotifier,
    this.textSize,
    this.spacing,
    this.textStyle,
  })  : _nameController = nameController,
        _phone1Controller = phone1Controller,
        _phone2Controller = phone2Controller;

  // controllers
  final TextEditingController _nameController;
  final TextEditingController _phone1Controller;
  final TextEditingController _phone2Controller;

  // notifiers
  final ValueNotifier<bool> isClientSearchEnabledNotifier;
  //
  final double? textSize;
  final double? spacing;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => BlocListener<ClientCubit, ClientState>(
        listener: (context, state) {
          final selectedClient = state.selectedClient;

          if (selectedClient != null) {
            debugPrint('selected client: ${selectedClient}');
            _nameController.text = selectedClient.name;
            _phone1Controller.text = selectedClient.phone1.toString();
            _phone2Controller.text = selectedClient.phone2?.toString() ?? '';
            context.hideKeyboard();
          }
        },
        child: ValueListenableBuilder(
          valueListenable: isClientSearchEnabledNotifier,
          builder: (context, isSearchEnabled, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spacing?.w ?? 25.w,
            children: [
              Padding(
                padding: 8.paddingHorizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Client Details',
                        style: textStyle ??
                            TextStyle(
                              fontSize: textSize?.sp ?? 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),

                    Row(
                      children: [
                        Switch.adaptive(
                          value: isSearchEnabled,
                          onChanged: (value) {
                            isClientSearchEnabledNotifier.value = value;
                          },
                          activeTrackColor: AppColors.purple,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        5.width,
                        Text(
                          'Search Client',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    // BlocListener<ClientSaveBloc, ClientSaveState>(
                    //   listener: (context, state) {
                    //     state.maybeWhen(
                    //       orElse: () {
                    //         log('orElse');
                    //       },
                    //       failure: (message) {
                    //         log('message: $message');
                    //         context.showSnackBar(
                    //           message,
                    //           isError: true,
                    //         );
                    //       },
                    //       success: (message, client) {
                    //         log('client: $client');
                    //         context.pop();
                    //         context.showSnackBar(message);

                    //         context
                    //             .read<ClientBloc>()
                    //             .add(ClientEvent.clientSelected(client));
                    //       },
                    //     );
                    //   },
                    //   child: ElevatedButton.icon(
                    //     onPressed: () async {
                    //       await showAddClientDialog(
                    //         context: context,
                    //         onPressed: (dialogContext, name, phone1, phone2) {
                    //           context.read<ClientSaveBloc>().add(
                    //                 ClientSaveEvent.saveClient(
                    //                   ClientRequestModel(
                    //                     id: null,
                    //                     name: name,
                    //                     phone1: phone1.toInt(),
                    //                     phone2: phone2.toIntOrNull(),
                    //                   ),
                    //                 ),
                    //               );
                    //           // context.pop();
                    //         },
                    //       );
                    //     },
                    //     icon: const Icon(Icons.add),
                    //     label: const Text(
                    //       'Add Client',
                    //       style: TextStyle(
                    //         color: AppColors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              ClientSearchNameField(
                nameController: _nameController,
                hitText: isSearchEnabled ? 'Search existing client' : 'Name',
                isSearchEnabled: isSearchEnabled,
              ),

              /// Phone Number 1
              phoneDisplay(
                controller: _phone1Controller,
                label:
                    'Phone Number 1${isSearchEnabled ? ' (auto-filled)' : ''}',
                icon: Icons.phone,
                isEnabled: !isSearchEnabled,
              ),

              /// Phone Number 2
              phoneDisplay(
                controller: _phone2Controller,
                label:
                    'Phone Number 2${isSearchEnabled ? ' (auto-filled)' : ''}',
                icon: Icons.phone,
                isRequired: false,
                isEnabled: !isSearchEnabled,
              ),
            ],
          ),
        ),
      );
}

Widget phoneDisplay({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  bool isRequired = true,
  bool isEnabled = true,
}) =>
    CustomTextField(
      controller: controller,
      validator: (value) => AppInputValidators.isEmpty(value) && !isRequired
          ? null
          : AppInputValidators.phoneNumber(value),
      label: label,
      prefixIcon: Icon(icon),
      suffixIcon:
          !isEnabled ? Icon(Icons.lock, size: 16.sp, color: Colors.grey) : null,
      // maxLength: 10,
      ignorePointers: !isEnabled,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
    );
