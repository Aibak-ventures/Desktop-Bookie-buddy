// Widget _buildProductRow(ProductSelectedModel product) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//     child: Row(
//       children: [
//         // Item Name
//         Expanded(
//           flex: 3,
//           child: Text(
//             product.variant.name ?? '',
//             style: const TextStyle(
//               fontSize: 13,
//               fontFamily: 'Inter',
//               fontWeight: FontWeight.w500,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//         // Variant
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border(left: BorderSide(color: Colors.grey.shade300)),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               product.variant.variantAttribute.isNotEmpty
//                   ? product.variant.variantAttribute
//                   : product.variant.model ?? '-',
//               style: const TextStyle(fontSize: 12, color: Colors.black87),
//             ),
//           ),
//         ),
//         // Available
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border(left: BorderSide(color: Colors.grey.shade300)),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               '${product.variant.quantity}',
//               style: const TextStyle(fontSize: 12, color: Colors.black87),
//             ),
//           ),
//         ),
//         // Quantity
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border(left: BorderSide(color: Colors.grey.shade300)),
//             ),
//             alignment: Alignment.center,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () => _decrementQuantity(product),
//                   child: Icon(Icons.remove_circle_outline,
//                       size: 16, color: Colors.grey.shade600),
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   '${product.quantity}',
//                   style: const TextStyle(
//                       fontSize: 12, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(width: 8),
//                 InkWell(
//                   onTap: () => _incrementQuantity(product),
//                   child: Icon(Icons.add_circle_outline,
//                       size: 16, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // Price / item
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border(left: BorderSide(color: Colors.grey.shade300)),
//             ),
//             alignment: Alignment.center,
//             child: InkWell(
//               onTap: () => _showPriceEditDialog(product),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     '₹${product.amount}',
//                     style: const TextStyle(fontSize: 12, color: Colors.black87),
//                   ),
//                   const SizedBox(width: 4),
//                   Icon(Icons.edit, size: 10, color: Colors.grey.shade400),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         // Total
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border(left: BorderSide(color: Colors.grey.shade300)),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               '₹${product.amount * product.quantity}',
//               style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87),
//             ),
//           ),
//         ),
//         // Remove
//         SizedBox(
//           width: 48,
//           child: IconButton(
//             icon: const Icon(Icons.close, size: 18, color: Colors.redAccent),
//             onPressed: () => _removeProduct(product),
//           ),
//         ),
//       ],
//     ),
//   );
// }
