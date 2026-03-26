import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/stock_management_cubit/stock_management_cubit.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Horizontal scrollable service-filter tabs for the stock management screen.
class StockManagementCategoryTabs extends StatelessWidget {
  const StockManagementCategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, serviceState) {
        return BlocBuilder<StockManagementCubit, StockManagementState>(
          builder: (context, state) {
            final selectedServiceId = state.maybeWhen(
              loaded: (_, __, ___, ____, _____, selected, ______, _______) =>
                  selected,
              orElse: () => -1,
            );

            return serviceState.maybeWhen(
              loaded: (services) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // "All Services" tab
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: () {
                            context
                                .read<StockManagementCubit>()
                                .filterByService(-1);
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: selectedServiceId == -1
                                  ? AppColors.purple.withValues(alpha: 0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selectedServiceId == -1
                                    ? AppColors.purple
                                    : Colors.grey.shade300,
                                width: selectedServiceId == -1 ? 2 : 1,
                              ),
                            ),
                            child: Text(
                              'All Services',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: selectedServiceId == -1
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: selectedServiceId == -1
                                    ? AppColors.purple
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Service tabs from API
                      ...services.map((service) {
                        final isSelected = service.id == selectedServiceId;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<StockManagementCubit>()
                                  .filterByService(service.id);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.purple.withValues(alpha: 0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.purple
                                      : Colors.grey.shade300,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Text(
                                service.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? AppColors.purple
                                      : Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
              orElse: () => const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
