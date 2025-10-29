import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/navigation/app_routes.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_normal_elevated_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/features/staff/view/staff_deleted_list_screen.dart';
import 'package:bookie_buddy_web/features/staff/view/widgets/add_or_edit_staff_dialog.dart';
import 'package:bookie_buddy_web/features/staff/view/widgets/staff_list_card.dart';
import 'package:bookie_buddy_web/features/staff/view_model/bloc_staff_list/staff_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';

class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Staff'),
      actions: [
        IconButton(
          onPressed: () {
            NavigatorX(context).push(const StaffDeletedListScreen());
          },
          icon: const Icon(Icons.history),
        ),
      ],
    ),
    body: Padding(
      padding: 16.padding,
      child: BlocConsumer<StaffListBloc, StaffListState>(
        listenWhen: (previous, current) =>
            previous != current &&
            current.maybeMap(
              orElse: () => false,
              error: (value) => true,
              loaded: (value) =>
                  value.status.isSuccess || value.status.isFailure,
            ),
        listener: (context, state) {
          state.maybeMap(
            error: (value) {
              context.showSnackBar(value.message, isError: true);
            },
            orElse: () {},
          );
        },
        builder: (context, state) => state.when(
          error: (message) => CustomErrorWidget(
            errorText: message,
            onRetry: () => _fetchData(context),
          ),
          loading: () => ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) => Padding(
              padding: 8.paddingVertical,
              child: const StaffListCardShimmer(),
            ),
          ),
          loaded: (staffs, nextPageUrl, isPaginating, _, _1) => Column(
            children: [
              //!TODO: search bar
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: () async => _fetchData(context),
                  child: staffs.isEmpty
                      ? const EmptyDataWidget(
                          message: 'No staff found. Tap + to add new staff.',
                          isShowIcon: false,
                        )
                      : NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels >=
                                    scrollInfo.metrics.maxScrollExtent - 50 &&
                                !isPaginating &&
                                nextPageUrl != null) {
                              // Load more data when scrolled to the bottom
                              context.read<StaffListBloc>().add(
                                const StaffListEvent.loadNextPageStaffs(),
                              );
                            }
                            return false;
                          },

                          child: ListView.builder(
                            itemCount: staffs.length + (isPaginating ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= staffs.length) {
                                // Load more indicator
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              final staff = staffs[index];
                              return Padding(
                                padding: 8.paddingVertical,
                                child: StaffListCard(
                                  name: staff.name,
                                  phoneNumber: staff.phoneNumber,
                                  // onTapAnalytics: () {
                                  //   context.pushNamed(
                                  //     AppRoutes.staffAnalytics.name,
                                  //     pathParameters: {
                                  //       'id': staff.id.toString(),
                                  //     },
                                  //     queryParameters: {'name': staff.name},
                                  //   );
                                  // },
                                  onEdit: () => _showAddStaffDialog(
                                    context: context,
                                    staff: staff,
                                  ),
                                  onDelete: () => _showDeleteStaffDialog(
                                    context: context,
                                    staffId: staff.id,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),

    floatingActionButton: FloatingActionButton.extended(
      label: const Text('Add Staff', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
      onPressed: () {
        _showAddStaffDialog(context: context);
      },
      backgroundColor: AppColors.purple,
    ),
  );

  void _fetchData(BuildContext context) =>
      context.read<StaffListBloc>().add(const StaffListEvent.loadStaffs());

  void _showAddStaffDialog({required BuildContext context, StaffModel? staff}) {
    showDialog(
      context: context,
      builder: (dialogContext) => AddOrEditStaffDialog(staff: staff),
    );
  }

  void _showDeleteStaffDialog({
    required BuildContext context,
    required int staffId,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Staff'),
        content: const Text('Are you sure you want to delete this staff?'),
        actions: [
          TextButton(
            onPressed: () => NavigatorX(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          BlocConsumer<StaffListBloc, StaffListState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                loaded: (value) {
                  if (value.status.isSuccess) {
                    NavigatorX(dialogContext).pop();
                    dialogContext.showSnackBar(
                      value.message ?? 'Staff deleted successfully',
                    );
                  } else if (value.status.isFailure) {
                    NavigatorX(context).pop();
                    context.showSnackBar(
                      value.message ?? 'Failed to delete staff',
                      isError: true,
                    );
                  }
                },
              );
            },
            builder: (context, state) {
              final isUpdating = state.maybeMap(
                orElse: () => false,
                loaded: (value) => value.status.isUpdating,
              );
              return CustomNormalElevatedButton(
                text: 'Delete',
                onPressed: () {
                  context.read<StaffListBloc>().add(
                    StaffListEvent.deleteStaff(staffId),
                  );
                },
                isLoading: isUpdating,
                color: AppColors.redTomato,
              );
            },
          ),
        ],
      ),
    );
  }
}
