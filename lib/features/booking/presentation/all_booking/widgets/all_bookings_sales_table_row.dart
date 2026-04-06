import 'package:bookie_buddy_web/features/sales/domain/entities/sale_entity/sale_entity.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sales_details_bloc/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sales_details_drawer_cubit/sales_details_drawer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A single data row in the sales table of [AllBookingsDesktopScreen].
///
/// Tapping the row opens the [SalesDetailsDrawer] for the given sale.
class AllBookingsSalesTableRow extends StatelessWidget {
  final SaleEntity sale;

  const AllBookingsSalesTableRow({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<SalesDetailsDrawerCubit>().openDrawer(sale.id);
            context.read<SalesDetailsBloc>().add(
              SalesDetailsEvent.fetchSaleDetails(sale.id),
            );
          },
          hoverColor: const Color(0xFF8A63FE).withOpacity(0.08),
          splashColor: const Color(0xFF8A63FE).withOpacity(0.12),
          highlightColor: const Color(0xFF8A63FE).withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const SizedBox(width: 11),
                SizedBox(
                  width: 100,
                  child: Text(
                    sale.shopSaleId ?? 'SL${sale.id.toString().padLeft(5, '0')}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(width: 95, child: Text(sale.saleDate, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
                const SizedBox(width: 12),
                SizedBox(
                  width: 110,
                  child: Text(
                    sale.clientPhone?.toString() ?? 'N/A',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(sale.products, style: const TextStyle(fontSize: 12, color: Colors.black), maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 12),
                SizedBox(width: 80, child: Text('₹${sale.totalAmount}', style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
                const SizedBox(width: 12),
                SizedBox(width: 70, child: Text('₹${sale.paidAmount}', style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
                const SizedBox(width: 12),
                SizedBox(width: 70, child: Text('₹${sale.discountAmount}', style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
                const SizedBox(width: 10),
                const Icon(Icons.chevron_right, size: 18, color: Colors.blueAccent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
