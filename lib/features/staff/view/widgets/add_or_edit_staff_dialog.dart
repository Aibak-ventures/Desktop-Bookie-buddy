import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/models/staff_request_model/staff_request_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_normal_elevated_button.dart';
import 'package:bookie_buddy_web/features/staff/view_model/bloc_staff_list/staff_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddOrEditStaffDialog extends StatefulWidget {
  const AddOrEditStaffDialog({super.key, this.staff});

  final StaffModel? staff;

  @override
  State<AddOrEditStaffDialog> createState() => _AddOrEditStaffDialogState();
}

class _AddOrEditStaffDialogState extends State<AddOrEditStaffDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.staff?.name ?? '');
    phoneController = TextEditingController();
    if (widget.staff?.phoneNumber != null) {
      phoneController.text = widget.staff!.phoneNumber.replaceAll('+91', '');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    if (widget.staff == null) {
      context.read<StaffListBloc>().add(
            StaffListEvent.addStaff(
              StaffRequestModel(name: name, phoneNumber: phone),
            ),
          );
    } else {
      final isNameChanged = name != widget.staff?.name;
      final isPhoneChanged =
          phone != widget.staff?.phoneNumber.replaceAll('+91', '');
      if (!isNameChanged && !isPhoneChanged) {
        NavigatorX(context).pop();
        context.showSnackBar('No changes made');
        return;
      }
      context.read<StaffListBloc>().add(
            StaffListEvent.editStaff(
              StaffRequestModel(
                id: widget.staff!.id,
                name: isNameChanged ? name : null,
                phoneNumber: isPhoneChanged ? phone : null,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.staff != null ? 'Edit Staff' : 'Add Staff'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  keyboardType: TextInputType.name,
                  validator: AppInputValidators.name,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: AppInputValidators.phoneNumber,
                  maxLength: 10,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) {
                    _submit();
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => NavigatorX(context).pop(),
              child: const Text('Cancel')),
          BlocConsumer<StaffListBloc, StaffListState>(
            listenWhen: (previous, current) =>
                previous != current &&
                current.maybeMap(
                  orElse: () => false,
                  error: (value) => true,
                  loaded: (value) =>
                      value.status.isSuccess ||
                      value.status.isFailure ||
                      value.status.isUpdating,
                ),
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                loaded: (value) {
                  if (value.status.isSuccess) {
                    NavigatorX(context).pop();
                    context
                        .showSnackBar(value.message ?? 'Operation successful');
                  } else if (value.status.isFailure) {
                    context.showSnackBar(
                      value.message ?? 'Operation failed',
                      isError: true,
                    );
                  }
                },
              );
            },
            builder: (context, state) {
              final isUpdating = state.maybeMap(
                orElse: () => false,
                loaded: (value) => value.status.isUpdating,
              );
              return CustomNormalElevatedButton(
                text: widget.staff != null ? 'Save' : 'Add',
                onPressed: _submit,
                isLoading: isUpdating,
              );
            },
          ),
        ],
      );
}
