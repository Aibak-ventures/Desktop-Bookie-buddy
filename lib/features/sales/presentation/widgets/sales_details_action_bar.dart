import 'package:bookie_buddy_web/core/constants/enums/secret_password_locations_enum.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_core/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/all_sales_bloc/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sales_details_bloc/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/save_sales_cubit/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/sales/presentation/pages/edit_sales_screen.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_invoice_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Sticky action bar (delete / edit / share invoice / print) for
/// [SalesDetailsDrawer]. Print/invoice actions themselves live in
/// [SalesInvoiceActions] — this widget is just the button row.
class SalesDetailsActionBar extends StatelessWidget {
  final SaleDetailsEntity sale;

  const SalesDetailsActionBar({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildIconActionButton(
            context,
            icon: Icons.delete_outline,
            color: Colors.red,
            onTap: () => _onDelete(context),
          ),
          const SizedBox(width: 12),
          _buildIconActionButton(
            context,
            icon: Icons.edit_outlined,
            color: AppColors.purple,
            onTap: () => _onEdit(context),
          ),
          const SizedBox(width: 12),
          // Share Invoice (always visible)
          _buildIconActionButton(
            context,
            icon: Icons.share_outlined,
            color: AppColors.purple,
            onTap: () => SalesInvoiceActions.openInvoicePdf(context, sale),
          ),
          const SizedBox(width: 12),
          // Print Invoice / Receipt / Preview
          _buildIconActionButton(
            context,
            icon: Icons.print_outlined,
            color: AppColors.purple,
            onTap: () => SalesInvoiceActions.printReceipt(context, sale),
            onLongPress: () =>
                SalesInvoiceActions.previewReceipt(context, sale),
          ),
        ],
      ),
    );
  }

  void _onDelete(BuildContext context) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.bookingDelete,
      onSuccess: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Sale'),
            content: const Text(
              'Are you sure you want to delete this sale? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
        if (confirm == true && context.mounted) {
          context.read<SalesDetailsBloc>().add(
            SalesDetailsEvent.deleteSale(sale.id),
          );
        }
      },
    );
  }

  void _onEdit(BuildContext context) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.bookingEdit,
      onSuccess: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => SaveSalesCubit(
                createSaleUseCase: getIt.get(),
                updateSaleUseCase: getIt.get(),
              ),
              child: EditSalesScreen(saleDetails: sale),
            ),
          ),
        );
        if (result == true && context.mounted) {
          context.read<AllSalesBloc>().add(const AllSalesEvent.loadSales());
          context.read<SalesDetailsBloc>().add(
            SalesDetailsEvent.fetchSaleDetails(sale.id),
          );
        }
      },
    );
  }

  Widget _buildIconActionButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
  }) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}
