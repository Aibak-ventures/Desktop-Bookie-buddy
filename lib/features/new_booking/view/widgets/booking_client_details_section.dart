import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/new_booking/view/new_booking_screen.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_document_upload_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_address_autocomplete_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

class BookingClientDetailsSection extends StatelessWidget {
  final TextEditingController clientNameController;
  final TextEditingController clientPhone1Controller;
  final TextEditingController clientPhone2Controller;
  final TextEditingController clientAddressController;
  final TextEditingController staffNameController;
  final TextEditingController descriptionController;
  final ValueNotifier<List<DocumentFile>> documentsNotifier;
  final bool sendPdfToWhatsApp;
  final ValueChanged<bool> onWhatsAppChanged;
  final ValueChanged<StaffModel> onStaffSelected;
  final VoidCallback onContinue;

  static const double kFieldSpacing = 10.0;

  const BookingClientDetailsSection({
    super.key,
    required this.clientNameController,
    required this.clientPhone1Controller,
    required this.clientPhone2Controller,
    required this.clientAddressController,
    required this.staffNameController,
    required this.descriptionController,
    required this.documentsNotifier,
    required this.sendPdfToWhatsApp,
    required this.onWhatsAppChanged,
    required this.onStaffSelected,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Client Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: kFieldSpacing),
                        _buildClientField("Name", clientNameController),
                        const SizedBox(height: kFieldSpacing),
                        _buildClientField("Phone", clientPhone1Controller),
                        const SizedBox(height: kFieldSpacing),
                        _buildClientField("Phone 2", clientPhone2Controller),
                        const SizedBox(height: kFieldSpacing),
                        // Replaced standard field with Autocomplete (Local List)
                        _buildAddressAutocompleteField(
                            "Place", clientAddressController),
                        const SizedBox(height: kFieldSpacing),
                        _buildWhatsappSection(),
                        const SizedBox(height: kFieldSpacing),
                        BookingDocumentUploadSection(
                            documentsNotifier: documentsNotifier),
                        const SizedBox(height: kFieldSpacing),
                        _buildStaffSection(),
                        const SizedBox(height: kFieldSpacing),
                        _buildNotesField(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                // Continue Button (Fixed at bottom)
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6132E4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClientField(String label, TextEditingController controller,
      {TextInputAction action = TextInputAction.next}) {
    return Container(
      width: double.infinity,
      height: 37,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            color: Color(0xFFA2A2A2),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: TextField(
        controller: controller,
        textInputAction: action,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'Inter',
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            color: Color(0xFF8C8C8C),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildAddressAutocompleteField(
      String label, TextEditingController controller) {
    return BookingAddressAutocompleteField(
        label: label, controller: controller);
  }

  Widget _buildWhatsappSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F2FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0D4FC)),
      ),
      child: Row(
        children: [
          const Icon(Icons.description_outlined,
              size: 16, color: Color(0xFF6132E4)),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Send PDF to WhatsApp',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6132E4),
              ),
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value: sendPdfToWhatsApp,
              onChanged: onWhatsAppChanged,
              activeColor: const Color(0xFF6132E4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffSection() {
    return BlocBuilder<StaffSearchCubit, StaffSearchState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Staff Details',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            LayoutBuilder(
              builder: (context, constraints) {
                return Autocomplete<StaffModel>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return state.staffs;
                    }
                    return state.staffs.where((StaffModel option) {
                      return option.name
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  displayStringForOption: (StaffModel option) => option.name,
                  onSelected: onStaffSelected,
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    // Sync with parent controller if needed, but here AutoComplete uses its own or passed one.
                    // We need to ensure the parent's controller is updated or used.
                    // Actually, Autocomplete creates its own unless we handle it carefully.
                    // But wait, the parent `staffNameController` needs to be used.
                    // Flutters `Autocomplete` doesn't easily accept an external controller for the text field unless we use `fieldViewBuilder` and ignore the internal one? No.
                    // We can use `fieldViewBuilder` to attach the `staffNameController`.

                    // Hack: If we want to use `staffNameController` passed from parent:
                    if (fieldTextEditingController.text !=
                        staffNameController.text) {
                      fieldTextEditingController.text =
                          staffNameController.text;
                    }

                    return TextField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      style: const TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Select Staff',
                        hintStyle: TextStyle(
                            fontSize: 13, color: Colors.grey.shade400),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        suffixIcon: const Icon(Icons.arrow_drop_down,
                            size: 20, color: Colors.grey),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildNotesField() {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            color: Color(0xFFA2A2A2),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: TextField(
        controller: descriptionController,
        maxLines: null,
        expands: true,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'Inter',
          color: Colors.black87,
        ),
        decoration: const InputDecoration(
          hintText: 'Add notes...',
          hintStyle: TextStyle(
            color: Color(0xFF8C8C8C),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
