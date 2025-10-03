import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/features/transfer_product/view/widgets/transfer_product_history_tile.dart';
import 'package:bookie_buddy_web/features/transfer_product/view_model/bloc_transfer_product_history/transfer_product_history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransferProductHistoryScreen extends StatelessWidget {
  const TransferProductHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Product History'),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async => _fetchData(context),
        child: BlocBuilder<TransferProductHistoryBloc,
            TransferProductHistoryState>(
          builder: (context, state) => state.when(
              loading: () => ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 15,
                  itemBuilder: (context, index) => const TransferProductHistoryShimmerTile(),
                ),
              error: (error) => CustomErrorWidget(
                  errorText: error,
                  onRetry: () => _fetchData(context),
                ),
              loaded: (
                transferProductsHistory,
                nextPageUrl,
                isPaginating,
                shopId,
              ) => NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (nextPageUrl != null &&
                        !isPaginating &&
                        scrollInfo.metrics.pixels >=
                            scrollInfo.metrics.maxScrollExtent - 200) {
                      context.read<TransferProductHistoryBloc>().add(
                            const TransferProductHistoryEvent
                                .loadNextPageTransferHistory(),
                          );
                    }
                    return false;
                  },
                  child: transferProductsHistory.isEmpty
                      ? const Center(
                          child: Text('No transfer history'),
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: transferProductsHistory.length +
                              (isPaginating ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == transferProductsHistory.length) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final groupedHistory =
                                transferProductsHistory[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: 16.paddingOnly(
                                    left: true,
                                    top: true,
                                  ),
                                  child: Text(
                                    groupedHistory.date.getDateHeading(),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                10.height,
                                ...groupedHistory.transferProductHistoryList
                                    .map(
                                      (history) => TransferProductHistoryTile(
                                        transfer: history,
                                      ),
                                    )
                                    .toList(),
                              ],
                            );
                          },
                        ),
                ),
            ),
        ),
      ),
    );

  void _fetchData(BuildContext context) {
    context
        .read<TransferProductHistoryBloc>()
        .add(const TransferProductHistoryEvent.loadTransferHistory());
  }
}
