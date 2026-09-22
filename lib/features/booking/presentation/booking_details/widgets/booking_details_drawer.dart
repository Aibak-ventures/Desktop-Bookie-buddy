import 'package:bookie_buddy_web/core/app/bloc/details_drawer_cubit/details_drawer_cubit.dart';
import 'package:bookie_buddy_web/core/common/widgets/details_drawer_shell.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/booking_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Rendered by [GlobalDetailsDrawer], permanently mounted alongside
/// [SalesDetailsDrawer] so its `BlocListener` is always subscribed and never
/// misses the transition into `DetailsDrawerType.booking` — including the
/// very first time it opens. Every listener/visibility check below is
/// therefore gated on `drawerState.type == DetailsDrawerType.booking`, not
/// just `isOpen`, so a sales-drawer id change never triggers this drawer.
///
/// Callers never build this directly — open it from anywhere via
/// `context.read<DetailsDrawerCubit>().open(DetailsDrawerType.booking, id)`.
class BookingDetailsDrawer extends StatelessWidget {
  const BookingDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailsDrawerCubit, DetailsDrawerState>(
      listenWhen: detailsDrawerOpenedFor(DetailsDrawerType.booking),
      listener: (context, drawerState) {
        context.read<BookingDetailsBloc>().add(
          BookingDetailsEvent.fetchBookingDetails(drawerState.selectedId!),
        );
      },
      child: BlocBuilder<DetailsDrawerCubit, DetailsDrawerState>(
        builder: (context, drawerState) {
          final isThisOpen = drawerState.isOpenFor(DetailsDrawerType.booking);
          final selectedBookingId = drawerState.selectedId;
          return DetailsDrawerShell(
            isOpen: isThisOpen,
            onClose: () => context.read<DetailsDrawerCubit>().closeDrawer(),
            trailing: !isThisOpen || selectedBookingId == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.refresh, size: 24),
                    onPressed: () {
                      context.read<BookingDetailsBloc>().add(
                        BookingDetailsEvent.fetchBookingDetails(
                          selectedBookingId,
                        ),
                      );
                    },
                    tooltip: 'Refresh',
                    color: Colors.grey.shade600,
                    hoverColor: Colors.grey.shade100,
                  ),
            child: !isThisOpen || selectedBookingId == null
                ? const SizedBox.shrink()
                : BookingDetailsContent(selectedBookingId: selectedBookingId),
          );
        },
      ),
    );
  }
}
