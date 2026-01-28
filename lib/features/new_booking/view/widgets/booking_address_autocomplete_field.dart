import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class BookingAddressAutocompleteField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const BookingAddressAutocompleteField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      controller: controller,
      builder: (context, textController, focusNode) {
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
            controller: textController,
            focusNode: focusNode,
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
      },
      suggestionsCallback: (pattern) async {
        if (pattern.length < 1) return [];
        // Local list simulation for specific location starting with 'kozhi' etc.
        final List<String> places = [
          'Kozhikode, Kerala',
          'Kozhikode Beach',
          'Kozhikode Railway Station',
          'Kozhikode Civil Station',
          'Kozhikode Medical College',
          'Thamarassery',
          'Balussery',
          'Vadakara',
          'Feroke',
          'Ramanattukara',
          'Mavoor',
          'Kunnamangalam',
          'Koduvally',
          'Mukkam',
        ];
        return places
            .where((p) => p.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          dense: true,
          leading: const Icon(Icons.location_on, size: 16, color: Colors.grey),
          title: Text(suggestion, style: const TextStyle(fontSize: 13)),
        );
      },
      onSelected: (suggestion) {
        controller.text = suggestion;
      },
      emptyBuilder: (context) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('No places found', style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
