import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class BookingClientBar extends StatefulWidget {
  final TextEditingController clientNameController;
  final TextEditingController clientPhone1Controller;
  final TextEditingController clientPhone2Controller;
  final TextEditingController clientAddressController;
  final TextEditingController staffNameController;
  final ValueChanged<int?> onClientSelected;
  final ValueChanged<int?> onStaffSelected;
  final bool isSalesMode;

  const BookingClientBar({
    super.key,
    required this.clientNameController,
    required this.clientPhone1Controller,
    required this.clientPhone2Controller,
    required this.clientAddressController,
    required this.staffNameController,
    required this.onClientSelected,
    required this.onStaffSelected,
    this.isSalesMode = false,
  });

  @override
  State<BookingClientBar> createState() => _BookingClientBarState();
}

class _BookingClientBarState extends State<BookingClientBar> {
  bool isSearchEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Client & Staff Details',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const Spacer(),
              _buildSearchToggle(),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Client Name / Search
              Expanded(
                flex: 2,
                child: isSearchEnabled
                    ? _buildClientSearchField()
                    : _buildTextField(
                        controller: widget.clientNameController,
                        label: 'Client Name',
                        icon: Icons.person_outline,
                        validator: AppInputValidators.name,
                      ),
              ),
              const SizedBox(width: 12),

              // Phone
              Expanded(
                child: _buildTextField(
                  controller: widget.clientPhone1Controller,
                  label: 'Phone',
                  icon: Icons.phone_outlined,
                  type: TextInputType.phone,
                  readOnly: isSearchEnabled,
                  validator: AppInputValidators.phoneNumber,
                ),
              ),
              const SizedBox(width: 12),

              // Address
              Expanded(
                flex: 2,
                child: _buildTextField(
                  controller: widget.clientAddressController,
                  label: 'Address / Location',
                  icon: Icons.location_on_outlined,
                  validator: AppInputValidators.address,
                ),
              ),
              const SizedBox(width: 12),

              // Staff Selection
              Expanded(
                child: BlocListener<StaffSearchCubit, StaffSearchState>(
                  listener: (context, state) =>
                      widget.onStaffSelected(state.selectedStaff?.id),
                  child: StaffSearchNameField(
                    nameController: widget.staffNameController,
                    // compact: true, // Assuming we can make it compact or styling it here
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchToggle() {
    return Row(
      children: [
        Text(
          isSearchEnabled ? 'Search Mode' : 'Manual Entry',
          style: TextStyle(
            fontSize: 12,
            color: isSearchEnabled ? AppColors.purple : Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Transform.scale(
          scale: 0.7,
          child: Switch(
            value: isSearchEnabled,
            onChanged: (val) {
              setState(() => isSearchEnabled = val);
              if (!val) {
                // Clear when switching to manual? Maybe not always desired
                context.read<ClientCubit>().clearSelected();
              }
            },
            activeColor: AppColors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildClientSearchField() {
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        return TypeAheadField<ClientModel>(
          controller: widget.clientNameController,
          debounceDuration: const Duration(milliseconds: 200),
          hideOnEmpty: false,
          hideWithKeyboard: false,
          hideOnUnfocus: true,
          hideOnSelect: true,
          builder: (context, controller, focusNode) => _buildTextFieldFrame(
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Search client...',
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                prefixIcon:
                    Icon(Icons.search, size: 18, color: Colors.grey.shade500),
                suffixIcon: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (_, value, __) => value.text.isEmpty
                      ? const SizedBox.shrink()
                      : IconButton(
                          icon: const Icon(Icons.clear, size: 14),
                          onPressed: () {
                            controller.clear();
                            context.read<ClientCubit>().clearSelected();
                            widget.clientPhone1Controller.clear();
                            widget.clientPhone2Controller.clear();
                            widget.clientAddressController.clear();
                          },
                        ),
                ),
              ),
            ),
          ),
          suggestionsCallback: (query) async {
            if (query.isEmpty) return [];
            return await context.read<ClientCubit>().searchClient(query);
          },
          itemBuilder: (context, client) => ListTile(
            dense: true,
            title: Text(client.name, style: const TextStyle(fontSize: 13)),
            subtitle: Text(
              client.phone1.toString(),
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          onSelected: (client) {
            widget.clientNameController.text = client.name;
            widget.clientPhone1Controller.text = client.phone1.toString();
            widget.clientPhone2Controller.text =
                client.phone2?.toString() ?? '';
            widget.onClientSelected(client.id);
            context.read<ClientCubit>().selectClient(client);
          },
          decorationBuilder: (context, child) => Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType type = TextInputType.text,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return _buildTextFieldFrame(
      bgColor: readOnly ? Colors.grey.shade50 : Colors.white,
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        readOnly: readOnly,
        validator: validator,
        style: TextStyle(
          fontSize: 13,
          color: readOnly ? Colors.grey.shade600 : Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          border: InputBorder.none,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade500),
        ),
      ),
    );
  }

  Widget _buildTextFieldFrame({required Widget child, Color? bgColor}) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }
}
