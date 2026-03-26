import 'package:flutter/material.dart';

/// Column headers for the selected products table in [EditSalesScreen].
class SalesFormProductListHeader extends StatelessWidget {
  const SalesFormProductListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: _buildCell('items', alignLeft: true)),
          const SizedBox(width: 4),
          Expanded(flex: 2, child: _buildCell('Specifications')),
          const SizedBox(width: 4),
          Expanded(child: _buildCell('Quantity')),
          const SizedBox(width: 4),
          Expanded(child: _buildCell('Price / item')),
          const SizedBox(width: 4),
          Expanded(child: _buildCell('Total')),
          const SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _buildCell(String title, {bool alignLeft = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200),
      ),
      alignment: alignLeft ? Alignment.centerLeft : Alignment.center,
      child: Padding(
        padding: alignLeft
            ? const EdgeInsets.only(left: 12)
            : const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
