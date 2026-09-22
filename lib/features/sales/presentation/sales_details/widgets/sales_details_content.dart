import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/bloc/sales_details_bloc/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/widgets/sales_details_action_bar.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/widgets/sales_details_customer_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/widgets/sales_details_dates_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/widgets/sales_details_header_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/widgets/sales_details_items_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/widgets/sales_details_notes_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/widgets/sales_details_payment_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/sales_details/widgets/sales_details_staff_section.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// The actual sale-details view: every section (header, dates, items,
/// customer, notes, staff, payment) plus the bottom action bar, driven by
/// [SalesDetailsBloc]. Content-wise this is screen-equivalent — it just
/// happens to always be shown inside [SalesDetailsDrawer]'s slide-in chrome
/// rather than a full-screen route.
class SalesDetailsContent extends StatelessWidget {
  final int selectedSaleId;

  const SalesDetailsContent({super.key, required this.selectedSaleId});

  @override
  Widget build(BuildContext context) {
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
