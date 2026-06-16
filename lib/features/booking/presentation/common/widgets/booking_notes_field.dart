import 'package:flutter/material.dart';

class BookingNotesField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback? onSubmitted;

  const BookingNotesField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        expands: true,
        textInputAction: TextInputAction.done,
        onSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Notes',
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
