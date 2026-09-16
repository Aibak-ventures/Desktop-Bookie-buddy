import 'package:bookie_buddy_web/core/app/bloc/details_drawer_cubit/details_drawer_cubit.dart';
import 'package:bookie_buddy_web/core/common/widgets/details_drawer_shell.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/all_sales_bloc/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/bloc/sales_details_bloc/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/widgets/sales_details_content.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            final selectedSaleId = drawerState.selectedId;
            return DetailsDrawerShell(
              isOpen: isThisOpen,
              onClose: () => context.read<DetailsDrawerCubit>().closeDrawer(),
              trailing: !isThisOpen || selectedSaleId == null
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.refresh, size: 24),
                      onPressed: () {
                        context.read<SalesDetailsBloc>().add(
                          SalesDetailsEvent.fetchSaleDetails(selectedSaleId),
                        );
                      },
                      tooltip: 'Refresh',
                      color: Colors.grey.shade600,
                      hoverColor: Colors.grey.shade100,
                    ),
              child: !isThisOpen || selectedSaleId == null
                  ? const SizedBox.shrink()
                  : SalesDetailsContent(selectedSaleId: selectedSaleId),
            );
          },
        ),
      ),
    );
  }
}
