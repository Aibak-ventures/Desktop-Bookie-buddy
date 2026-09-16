import 'package:bookie_buddy_web/core/app/bloc/details_drawer_cubit/details_drawer_cubit.dart';
import 'package:bookie_buddy_web/core/common/widgets/details_drawer_shell.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/all_sales_bloc/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sales_details_bloc/sales_details_bloc.dart';
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

/// Rendered by [GlobalDetailsDrawer], permanently mounted alongside
/// [BookingDetailsDrawer] so its `BlocListener` is always subscribed and
/// never misses the transition into `DetailsDrawerType.sales` — including
/// the very first time it opens. Every listener/visibility check below is
/// therefore gated on `drawerState.type == DetailsDrawerType.sales`, not
/// just `isOpen`, so a booking-drawer id change never triggers this drawer.
///
/// Callers never build this directly — open it from anywhere via
/// `context.read<DetailsDrawerCubit>().open(DetailsDrawerType.sales, id)`.
class SalesDetailsDrawer extends StatelessWidget {
  const SalesDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailsDrawerCubit, DetailsDrawerState>(
      listenWhen: detailsDrawerOpenedFor(DetailsDrawerType.sales),
      listener: (context, drawerState) {
        context.read<SalesDetailsBloc>().add(
          SalesDetailsEvent.fetchSaleDetails(drawerState.selectedId!),
        );
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
                context.read<DetailsDrawerCubit>().closeDrawer();
              }
            },
            error: (message) {
              context.showSnackBar(message, isError: true);
            },
          );
        },
        child: BlocBuilder<DetailsDrawerCubit, DetailsDrawerState>(
          builder: (context, drawerState) {
            final isThisOpen = drawerState.isOpenFor(DetailsDrawerType.sales);
            return DetailsDrawerShell(
              isOpen: isThisOpen,
              onClose: () => context.read<DetailsDrawerCubit>().closeDrawer(),
              trailing: !isThisOpen || drawerState.selectedId == null
                  ? null
                  : IconButton(
                      icon: Icon(Icons.refresh, size: 24),
                      onPressed: () {
                        context.read<SalesDetailsBloc>().add(
                          SalesDetailsEvent.fetchSaleDetails(
                            drawerState.selectedId!,
                          ),
                        );
                      },
                      tooltip: 'Refresh',
                      color: Colors.grey.shade600,
                      hoverColor: Colors.grey.shade100,
                    ),
              child: _buildContent(context, drawerState.selectedId, isThisOpen),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    int? selectedSaleId,
    bool isThisOpen,
  ) {
    if (!isThisOpen || selectedSaleId == null) {
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
                context.read<SalesDetailsBloc>().add(
                  SalesDetailsEvent.fetchSaleDetails(selectedSaleId),
                );
              },
            ),
          ),
          loaded: (sale) => Column(
            key: ValueKey('sale_${sale.id}'),
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
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
                          sale.clientPhone.isNotEmpty) ...[
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
