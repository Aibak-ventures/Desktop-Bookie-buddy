import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingClientDetailsSection extends StatefulWidget {
  final TextEditingController staffNameController;
  final TextEditingController clientNameController;
  final TextEditingController clientPhone1Controller;
  final TextEditingController clientPhone2Controller;
  final TextEditingController clientAddressController;
  final bool isSearchClientEnabled;
  final ValueChanged<bool> onSearchClientToggle;
  final ValueChanged<int?> onStaffSelected;
  final ValueChanged<int?> onClientSelected;

  const BookingClientDetailsSection({
    super.key,
    required this.staffNameController,
    required this.clientNameController,
    required this.clientPhone1Controller,
    required this.clientPhone2Controller,
    required this.clientAddressController,
    required this.isSearchClientEnabled,
    required this.onSearchClientToggle,
    required this.onStaffSelected,
    required this.onClientSelected,
  });

  @override
  State<BookingClientDetailsSection> createState() =>
      _BookingClientDetailsSectionState();
}

class _BookingClientDetailsSectionState
    extends State<BookingClientDetailsSection> {
  // UI Constants
  static const double _fieldSpacing = 7.0;

  // Focus nodes for navigation
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phone1FocusNode = FocusNode();
  final FocusNode _phone2FocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<StaffSearchCubit>()
      ..clearSelectedStaff()
      ..getAllStaffs();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _phone1FocusNode.dispose();
    _phone2FocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStaffDetailsCard(),
        const SizedBox(height: 10),
        _buildClientDetailsCard(),
      ],
    );
  }

  Widget _buildStaffDetailsCard() {
    return _card(
      title: '',
      child: BlocListener<StaffSearchCubit, StaffSearchState>(
        listener: (context, state) =>
            widget.onStaffSelected(state.selectedStaff?.id),
        child: StaffSearchNameField(
          nameController: widget.staffNameController,
        ),
      ),
    );
  }

  Widget _buildClientDetailsCard() {
    return _card(
      title: 'Client details',
      trailing: Row(
        children: [
          Text('Search client',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          const SizedBox(width: 6),
          Transform.scale(
            scale: .8,
            child: Switch(
              value: widget.isSearchClientEnabled,
              onChanged: widget.onSearchClientToggle,
              activeColor: AppColors.purple,
            ),
          ),
        ],
      ),
      child: widget.isSearchClientEnabled
          ? _buildClientSearchField()
          : _buildClientManualFields(),
    );
  }

  Widget _buildClientSearchField() {
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 34,
              child: CustomTextField(
                validator: (value) {},
                controller: widget.clientNameController,
                hintText: 'Search clients',
                prefixIcon: const Icon(Icons.search, size: 16),
                // style: const TextStyle(fontSize: 12),
                onChanged: (v) {
                  if (v.length >= 3) {
                    context.read<ClientCubit>().searchClient(v);
                  }
                },
              ),
            ),
            if (state.suggestions.isNotEmpty) ...[
              const SizedBox(height: 6),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: state.suggestions.length,
                  itemBuilder: (_, i) {
                    final c = state.suggestions[i];
                    return ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -3),
                      title: Text(c.name, style: const TextStyle(fontSize: 15)),
                      subtitle: Text(c.phone1.toString(),
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade600)),
                      onTap: () {
                        widget.clientNameController.text = c.name;
                        widget.clientPhone1Controller.text =
                            c.phone1.toString();
                        widget.clientPhone2Controller.text =
                            c.phone2?.toString() ?? '';
                        widget.onClientSelected(c.id);
                        context.read<ClientCubit>().selectClient(c);
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildClientManualFields() {
    return Column(
      children: [
        _compactField(
          widget.clientNameController,
          'Name',
          Icons.person_outline,
          TextInputType.text,
          _nameFocusNode,
          _phone1FocusNode,
        ),
        const SizedBox(height: _fieldSpacing),
        _compactField(
          widget.clientPhone1Controller,
          'Phone',
          Icons.phone_outlined,
          TextInputType.phone,
          _phone1FocusNode,
          _phone2FocusNode,
        ),
        const SizedBox(height: _fieldSpacing),
        _compactField(
          widget.clientPhone2Controller,
          'Phone 2',
          Icons.phone_outlined,
          TextInputType.phone,
          _phone2FocusNode,
          _addressFocusNode,
        ),
        const SizedBox(height: _fieldSpacing),
        _compactField(
          widget.clientAddressController,
          'Place',
          Icons.location_on_outlined,
          TextInputType.text,
          _addressFocusNode,
          null, // Last field, no next field
        ),
      ],
    );
  }

  Widget _compactField(
    TextEditingController c,
    String hint,
    IconData icon,
    TextInputType type,
    FocusNode focusNode,
    FocusNode? nextFocusNode,
  ) {
    return SizedBox(
      height: 39,
      child: TextField(
        controller: c,
        focusNode: focusNode,
        keyboardType: type,
        textInputAction:
            nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        onEditingComplete: () {
          if (nextFocusNode != null) {
            nextFocusNode.requestFocus();
          } else {
            focusNode.unfocus();
          }
        },
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, right: 6),
            child: Icon(icon, size: 16, color: Colors.grey.shade600),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 34,
            minHeight: 34,
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _card(
      {required String title, Widget? trailing, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              const Spacer(),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
