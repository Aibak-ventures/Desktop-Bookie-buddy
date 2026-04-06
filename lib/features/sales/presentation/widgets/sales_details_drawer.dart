import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/all_sales_bloc/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sales_details_bloc/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sales_details_drawer_cubit/sales_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_details_action_bar.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_details_customer_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_details_dates_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_details_header_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_details_items_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_details_notes_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_details_payment_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_details_staff_section.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SalesDetailsDrawer extends StatelessWidget {
  const SalesDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserEntity?>(
      listenWhen: (previous, current) {
        if (previous == null || current == null) return false;
        return previous.shopDetails.id != current.shopDetails.id;
      },
      listener: (context, user) {
        context.read<SalesDetailsDrawerCubit>().closeDrawer();
      },
      child: BlocListener<SalesDetailsBloc, SalesDetailsState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (message, didPop, needRefresh) {
              context.showSnackBar(message);
              if (needRefresh) {
                context.read<AllSalesBloc>().add(
                      const AllSalesEvent.loadSales(),
                    );
              }
              if (didPop) {
                context.read<SalesDetailsDrawerCubit>().closeDrawer();
              }
            },
            error: (message) {
              context.showSnackBar(message, isError: true);
            },
          );
        },
        child: BlocBuilder<SalesDetailsDrawerCubit, SalesDetailsDrawerState>(
          builder: (context, drawerState) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              right: drawerState.isOpen ? 0 : -650,
              top: 0,
              bottom: 0,
              width: 470,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Material(
                  elevation: 16,
                  shadowColor: Colors.black.withValues(alpha: 0.3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(-4, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_right,
                                    size: 28),
                                onPressed: () => context
                                    .read<SalesDetailsDrawerCubit>()
                                    .closeDrawer(),
                                tooltip: 'Close',
                                color: Colors.grey.shade600,
                                hoverColor: Colors.grey.shade100,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: _buildContent(context, drawerState)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    SalesDetailsDrawerState drawerState,
  ) {
    if (!drawerState.isOpen || drawerState.selectedSaleId == null) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<SalesDetailsBloc, SalesDetailsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => SizedBox(
            height: context.mediaQueryHeight(0.8),
            child: const Center(
              child: SpinKitFadingCircle(color: AppColors.purple),
            ),
          ),
          error: (error) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomErrorWidget(
              errorText: error,
              onRetry: () {
                if (drawerState.selectedSaleId != null) {
                  context.read<SalesDetailsBloc>().add(
                        SalesDetailsEvent.fetchSaleDetails(
                            drawerState.selectedSaleId!),
                      );
                }
              },
            ),
          ),
          loaded: (sale) => Column(
            key: ValueKey('sale_${sale.id}'),
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SalesDetailsHeaderSection(sale: sale),
                      const SizedBox(height: 16),
                      SalesDetailsDatesSection(sale: sale),
                      const SizedBox(height: 24),
                      SalesDetailsItemsSection(sale: sale),
                      const SizedBox(height: 24),
                      if (sale.client != null ||
                          (sale.clientPhone != null &&
                              sale.clientPhone.toString().isNotEmpty)) ...[
                        SalesDetailsCustomerSection(sale: sale),
                        const SizedBox(height: 24),
                      ],
                      if (sale.description.isNotEmpty) ...[
                        SalesDetailsNotesSection(sale: sale),
                        const SizedBox(height: 24),
                      ],
                      if (sale.staffName != null &&
                          sale.staffName!.isNotEmpty) ...[
                        SalesDetailsStaffSection(sale: sale),
                        const SizedBox(height: 24),
                      ],
                      SalesDetailsPaymentSection(sale: sale),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              SalesDetailsActionBar(sale: sale),
            ],
          ),
        );
      },
    );
  }
}
