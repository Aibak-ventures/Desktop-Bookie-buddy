import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_normal_elevated_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/features/staff/view/widgets/staff_deleted_list_card.dart';
import 'package:bookie_buddy_web/features/staff/view_model/bloc_staff_deleted_list/staff_deleted_list_bloc.dart';
import 'package:bookie_buddy_web/features/staff/view_model/bloc_staff_list/staff_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StaffDeletedListScreen extends StatelessWidget {
  const StaffDeletedListScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Recently Deleted Staffs')),
        body: Padding(
          padding: 16.padding,
          child: BlocConsumer<StaffDeletedListBloc, StaffDeletedListState>(
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
                  child: const StaffDeletedListCardShimmer(),
                ),
              ),
              loaded: (staffs, nextPageUrl, isPaginating, _, _1) =>
                  RefreshIndicator.adaptive(
                onRefresh: () async => _fetchData(context),
                child: staffs.isEmpty
                    ? const EmptyDataWidget(
                        message: 'No deleted staffs found',
                        isShowIcon: false,
                      )
                    : NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent - 50 &&
                              !isPaginating &&
                              nextPageUrl != null) {
                            // Load more data when scrolled to the bottom
                            context.read<StaffDeletedListBloc>().add(
                                  const StaffDeletedListEvent
                                      .loadNextPageStaffs(),
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
                              child: StaffDeletedListCard(
                                name: staff.name,
                                phoneNumber: staff.phoneNumber,
                                onTap: () {
                                  _showRestoreStaffConfirmationDialog(
                                    context: context,
                                    staffId: staff.id,
                                    staffName: staff.name,
                                    onRestoreSuccess: () {
                                      context.read<StaffListBloc>().add(
                                            const StaffListEvent.loadStaffs(),
                                          );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
          ),
        ),
      );

  void _fetchData(BuildContext context) => context
      .read<StaffDeletedListBloc>()
      .add(const StaffDeletedListEvent.loadStaffs());

  Future<void> _showRestoreStaffConfirmationDialog({
    required BuildContext context,
    required int staffId,
    required String staffName,
    required VoidCallback? onRestoreSuccess,
  }) =>
      showDialog(
        context: context,
        builder: (dialogContext) => BlocProvider.value(
          value: context.read<StaffDeletedListBloc>(),
          child: AlertDialog(
            title: const Text('Confirm Restore'),
            content: Text('Are you sure you want to restore $staffName?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancel'),
              ),
              BlocConsumer<StaffDeletedListBloc, StaffDeletedListState>(
                listener: (context, state) {
                  state.maybeMap(
                    orElse: () {},
                    loaded: (value) {
                      if (value.status.isSuccess) {
                        onRestoreSuccess?.call();
                        NavigatorX(dialogContext).pop();
                        dialogContext.showSnackBar(
                          value.message ?? 'Staff restored successfully',
                        );
                      } else if (value.status.isFailure) {
                        NavigatorX(context).pop();
                        context.showSnackBar(
                          value.message ?? 'Failed to restore staff',
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
                    text: 'Restore',
                    onPressed: () {
                      context.read<StaffDeletedListBloc>().add(
                            StaffDeletedListEvent.restoreStaff(staffId),
                          );
                    },
                    isLoading: isUpdating,
                  );
                },
              ),
            ],
          ),
        ),
      );
}
