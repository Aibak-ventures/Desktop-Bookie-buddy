import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/stock_management_cubit/stock_management_cubit.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

/// Summary stat cards at the top of the stock management screen.
class StockManagementSummaryCards extends StatelessWidget {
  const StockManagementSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockManagementCubit, StockManagementState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (
            _,
            totalProducts,
            totalCategories,
            __,
            ___,
            ____,
            _____,
            ______,
          ) {
            final serviceCount =
                context.read<ServiceBloc>().getServices().length;
            return Row(
              children: [
                _SummaryCard(
                  title: 'Total Products',
                  value: NumberFormat('#,###').format(totalProducts),
                ),
                const SizedBox(width: 16),
                _SummaryCard(
                  title: 'Total Categories',
                  value: serviceCount.toString(),
                ),
              ],
            );
          },
          orElse: () {
            final serviceCount =
                context.read<ServiceBloc>().getServices().length;
            return Row(
              children: [
                SizedBox(
                  width: 227,
                  height: 98,
                  child: _SummaryCard(title: 'Total Products', value: '-'),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 227,
                  height: 98,
                  child: _SummaryCard(
                    title: 'Total Services',
                    value: serviceCount.toString(),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 217,
      height: 97,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
