import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBookingClientDetailsSection extends StatelessWidget {
  const EditBookingClientDetailsSection({
    super.key,
    required this.clientNameController,
    required this.clientPhone1Controller,
    required this.clientPhone2Controller,
    required this.clientAddressController,
    required this.isClientSearchEnabledNotifier,
  });

  final TextEditingController clientNameController;
  final TextEditingController clientPhone1Controller;
  final TextEditingController clientPhone2Controller;
  final TextEditingController clientAddressController;
  final ValueNotifier<bool> isClientSearchEnabledNotifier;

  @override
  Widget build(BuildContext context) {
    return _buildCard(
      title: 'Client details',
      trailing: ValueListenableBuilder<bool>(
        valueListenable: isClientSearchEnabledNotifier,
        builder: (context, isEnabled, _) {
          return Row(
            children: [
              Text('Search client',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
              const SizedBox(width: 6),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: isEnabled,
                  onChanged: (v) => isClientSearchEnabledNotifier.value = v,
                  activeColor: AppColors.purple,
                ),
              ),
            ],
          );
        },
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: isClientSearchEnabledNotifier,
        builder: (context, isEnabled, _) {
          return isEnabled
              ? _buildClientSearchField(context)
              : _buildClientManualFields();
        },
      ),
    );
  }

  Widget _buildClientSearchField(BuildContext context) {
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 34,
              child: CustomTextField(
                validator: (value) => null,
                controller: clientNameController,
                hintText: 'Search clients',
                prefixIcon: const Icon(Icons.search, size: 16),
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
                      title: Text(c.name, style: const TextStyle(fontSize: 13)),
                      subtitle: Text(c.phone1.toString(),
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600)),
                      onTap: () {
                        clientNameController.text = c.name;
                        clientPhone1Controller.text = c.phone1.toString();
                        clientPhone2Controller.text =
                            c.phone2?.toString() ?? '';
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
          clientNameController,
          'Name',
          Icons.person_outline,
          TextInputType.text,
        ),
        const SizedBox(height: 7),
        _compactField(
          clientPhone1Controller,
          'Phone',
          Icons.phone_outlined,
          TextInputType.phone,
        ),
        const SizedBox(height: 7),
        _compactField(
          clientPhone2Controller,
          'Phone 2',
          Icons.phone_outlined,
          TextInputType.phone,
        ),
        const SizedBox(height: 7),
        _compactField(
          clientAddressController,
          'Place',
          Icons.location_on_outlined,
          TextInputType.text,
        ),
      ],
    );
  }

  Widget _compactField(
    TextEditingController c,
    String hint,
    IconData icon,
    TextInputType type,
  ) {
    return SizedBox(
      height: 39,
      child: TextField(
        controller: c,
        keyboardType: type,
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

  Widget _buildCard(
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
