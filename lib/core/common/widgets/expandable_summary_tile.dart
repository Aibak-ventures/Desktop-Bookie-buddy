import 'package:flutter/material.dart';

class SummaryField {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final Color? color;
  final bool showDivider;

  const SummaryField({
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
    this.color,
    this.showDivider = false,
  });
}

class ExpandableSummaryTile extends StatefulWidget {
  final String totalLabel;
  final String totalValue;
  final String? subLabel;
  final Color subLabelColor;
  final List<SummaryField> fields;
  final double fieldSpacing;
  final EdgeInsets expandedPadding;
  final double borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final List<BoxShadow>? boxShadow;

  const ExpandableSummaryTile({
    super.key,
    required this.totalLabel,
    required this.totalValue,
    required this.fields,
    this.subLabel,
    this.subLabelColor = const Color(0xFF1AB000),
    this.fieldSpacing = 4,
    this.expandedPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    this.borderRadius = 8,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0x1A000000),
    this.boxShadow,
  });

  @override
  State<ExpandableSummaryTile> createState() => _ExpandableSummaryTileState();
}

class _ExpandableSummaryTileState extends State<ExpandableSummaryTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: widget.borderColor),
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: widget.boxShadow ?? [],
      ),
      child: ExpansionTile(
        shape: const Border(),
        childrenPadding: EdgeInsets.zero,
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (value) => setState(() => _isExpanded = value),
        trailing: AnimatedRotation(
          turns: _isExpanded ? 0.5 : 1,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 200),
          child: const Icon(Icons.keyboard_arrow_up),
        ),
        title: _buildTitle(),
        children: [
          Divider(color: Colors.black.withValues(alpha: 0.1), height: 1),
          Padding(padding: widget.expandedPadding, child: _buildFields()),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.totalLabel,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Inter',
            color: Color(0xFF3E3E3E),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              widget.totalValue,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                color: Color(0xFF3E3E3E),
                fontWeight: FontWeight.w700,
              ),
            ),
            if (widget.subLabel != null) ...[
              const SizedBox(width: 6),
              Text(
                widget.subLabel!,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'Inter',
                  color: widget.subLabelColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildFields() {
    return Column(
      children: [
        for (int i = 0; i < widget.fields.length; i++) ...[
          if (widget.fields[i].showDivider)
            Padding(
              padding: EdgeInsets.symmetric(vertical: widget.fieldSpacing / 2),
              child: Divider(
                color: Colors.black.withValues(alpha: 0.1),
                height: 1,
              ),
            )
          else
            _buildFieldRow(widget.fields[i]),
          if (i < widget.fields.length - 1)
            SizedBox(height: widget.fieldSpacing),
        ],
      ],
    );
  }

  Widget _buildFieldRow(SummaryField field) {
    final defaultStyle = TextStyle(
      fontSize: 13,
      fontFamily: 'Inter',
      color: field.color ?? const Color(0xFF3E3E3E),
      fontWeight: FontWeight.w400,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(field.label, style: field.labelStyle ?? defaultStyle),
          ),
          Text(field.value, style: field.valueStyle ?? defaultStyle),
        ],
      ),
    );
  }
}
