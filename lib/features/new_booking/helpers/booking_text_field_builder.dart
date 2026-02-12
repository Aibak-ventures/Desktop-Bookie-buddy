import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Helper class for building common text field widgets in new booking screen
class BookingTextFieldBuilder {
  /// Builds a text field for right panel with standard styling
  static Widget buildRightPanelTextField({
    required TextEditingController controller,
    required String hint,
    bool isNumber = false,
    bool enabled = true,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    String? errorText,
    IconData? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: errorText != null
                  ? Colors.red.shade400
                  : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(8),
            color: enabled ? Colors.white : Colors.grey.shade100,
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(
                  prefixIcon,
                  size: 16,
                  color: errorText != null ? Colors.red.shade400 : Colors.grey,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  enabled: enabled,
                  keyboardType:
                      isNumber ? TextInputType.number : TextInputType.text,
                  inputFormatters: isNumber
                      ? [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ]
                      : null,
                  textInputAction: nextFocusNode != null
                      ? TextInputAction.next
                      : TextInputAction.done,
                  onEditingComplete: () {
                    if (nextFocusNode != null) {
                      nextFocusNode.requestFocus();
                    } else {
                      focusNode?.unfocus();
                    }
                  },
                  style: TextStyle(
                    fontSize: 13,
                    color: enabled ? Colors.black87 : Colors.grey.shade500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle:
                        TextStyle(fontSize: 13, color: Colors.grey.shade400),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              errorText,
              style: TextStyle(
                fontSize: 11,
                color: Colors.red.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Builds a section header with optional tag
  static Widget buildSectionHeader(String title, {bool optional = false}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        if (optional) ...[
          const SizedBox(width: 4),
          Text(
            '(optional)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ],
    );
  }

  /// Builds a simple text field for steps
  static Widget buildSimpleTextField(
    TextEditingController controller,
    String hint, {
    bool isNumber = false,
  }) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  /// Builds a compact amount field with icon
  static Widget buildCompactAmountField({
    required TextEditingController controller,
    required String label,
    IconData icon = Icons.currency_rupee,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]')), // Strict regex for digits
            ],
            onChanged: (value) {
              // Extra layer of protection
              if (value.contains(RegExp(r'[^0-9]'))) {
                final cleanText = value.replaceAll(RegExp(r'[^0-9]'), '');
                controller.value = TextEditingValue(
                  text: cleanText,
                  selection: TextSelection.collapsed(offset: cleanText.length),
                );
              }
            },
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final amount = int.tryParse(value);
                if (amount == 0) {
                  return 'Amount cannot be 0';
                }
              }
              return null;
            },
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                color: Color(0xFF8C8C8C),
              ),
              hintText: label,
              prefixText: '₹ ',
              prefixStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
              // Use OutlineInputBorder to match previous container style
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF6132E4), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}
