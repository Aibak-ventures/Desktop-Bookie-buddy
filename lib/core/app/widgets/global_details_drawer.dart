import 'package:bookie_buddy_web/core/app/bloc/details_drawer_cubit/details_drawer_cubit.dart';
import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_drawer.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_details_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Single mount point for every feature's details drawer. Lives once in
/// [AppShellScreen]'s root `Stack` so any screen can open a drawer via
/// `context.read<DetailsDrawerCubit>().open(DetailsDrawerType.x, id)` without
/// wrapping itself in a `Stack` or rendering the drawer widget itself.
///
/// Every drawer widget is mounted unconditionally and permanently — each
/// stays subscribed to [DetailsDrawerCubit] for the app's whole lifetime and
/// filters internally on its own [DetailsDrawerType], showing itself only
/// when that type is the active one. This matters for two reasons: (1) a
/// `Stack` sizes itself to any non-positioned child, so conditionally
/// swapping a drawer widget out for `SizedBox.shrink()` here would collapse
/// this whole `Stack` (and therefore [AppShellScreen]'s `Stack`) to zero size
/// whenever no drawer is open; (2) a drawer's `BlocListener` only reacts to
/// *future* state changes, so a widget that only gets mounted once its type
/// becomes active would always miss the very transition that opened it.
///
/// To add a new drawer (e.g. client, staff): add a case to
/// [DetailsDrawerType], build a `XDetailsDrawer` widget the same shape as
/// [BookingDetailsDrawer]/[SalesDetailsDrawer] (using [DetailsDrawerShell]
/// for the shared chrome, and gating every check on its own type), and add
/// it below.
///
/// Only reaches screens that render inside [AppShellScreen]'s `Stack` (every
/// shell tab, today). A screen pushed as its own full-screen `Navigator`
/// route outside the shell would still update [DetailsDrawerCubit] fine on
/// `open()`, but nothing would be mounted there to show it — route to the
/// relevant shell tab first, or mount this drawer at that route's own level.
class GlobalDetailsDrawer extends StatelessWidget {
  const GlobalDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserEntity?>(
      listenWhen: (previous, current) {
        if (previous == null || current == null) return false;
        return previous.shopDetails.id != current.shopDetails.id;
      },
      listener: (context, user) {
        context.read<DetailsDrawerCubit>().closeDrawer();
      },
      child: const Stack(
        children: [BookingDetailsDrawer(), SalesDetailsDrawer()],
      ),
    );
  }
}
