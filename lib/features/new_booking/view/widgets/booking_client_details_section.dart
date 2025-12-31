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
  @override
  void initState() {
    super.initState();
    // Initialize staff search
    context.read<StaffSearchCubit>()
      ..clearSelectedStaff()
      ..getAllStaffs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Staff details section
        _buildStaffDetailsCard(),
        const SizedBox(height: 16),
        // Client details section
        _buildClientDetailsCard(),
      ],
    );
  }

  Widget _buildStaffDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Staff details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Listen to staff cubit for selected staff
          BlocListener<StaffSearchCubit, StaffSearchState>(
            listener: (context, state) {
              widget.onStaffSelected(state.selectedStaff?.id);
            },
            child: StaffSearchNameField(
              nameController: widget.staffNameController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Client details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Search client',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: widget.isSearchClientEnabled,
                    onChanged: widget.onSearchClientToggle,
                    activeColor: AppColors.purple,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Client fields
          if (widget.isSearchClientEnabled)
            _buildClientSearchField()
          else
            _buildClientManualFields(),
        ],
      ),
    );
  }

  Widget _buildClientSearchField() {
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(validator: null,

              controller: widget.clientNameController,
              hintText: 'Search client by name or phone',
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) {
                if (value.length >= 3) {
                  context.read<ClientCubit>().searchClient(value);
                } 
              },
            ),
            if (state.suggestions.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                constraints: const BoxConstraints(maxHeight: 150),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.suggestions.length,
                  itemBuilder: (context, index) {
                    final client = state.suggestions[index];
                    return ListTile(
                      dense: true,
                      title: Text(client.name),
                      subtitle: Text(client.phone1.toString()),
                      onTap: () {
                        widget.clientNameController.text = client.name;
                        widget.clientPhone1Controller.text =
                            client.phone1.toString();
                        widget.clientPhone2Controller.text =
                            client.phone2?.toString() ?? '';
                        widget.onClientSelected(client.id);
                        context.read<ClientCubit>().selectClient(client);
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
        // Name field
        _buildTextField(
          controller: widget.clientNameController,
          hintText: 'name',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 12),
        // Phone 1
        _buildTextField(
          controller: widget.clientPhone1Controller,
          hintText: 'Phone or Whatsapp',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) =>
              AppInputValidators.phoneNumber(value, isRequired: false),
        ),
        const SizedBox(height: 12),
        // Phone 2
        _buildTextField(
          controller: widget.clientPhone2Controller,
          hintText: 'phone 2',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) =>
              AppInputValidators.phoneNumber(value, isRequired: false),
        ),
        const SizedBox(height: 12),
        // Place/Address
        _buildTextField(
          controller: widget.clientAddressController,
          hintText: 'Place',
          icon: Icons.location_on_outlined,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
          ),
          prefixIcon: Icon(icon, color: Colors.grey.shade500, size: 20),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
