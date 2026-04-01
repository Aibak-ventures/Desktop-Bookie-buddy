import 'dart:io';

import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_invoice_pdf_usecase.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/all_sales_bloc/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sales_details_bloc/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/save_sales_cubit/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/sales/presentation/pages/edit_sales_screen.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/open_pdf_in_new_tab.dart';//added
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

/// Sticky action bar (delete / edit / download) for [SalesDetailsDrawer].
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
          _buildIconActionButton(
            context,
            icon: Icons.download_outlined,
            color: AppColors.purple,
            onTap: () => _openInvoicePdf(context),
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
          context
              .read<SalesDetailsBloc>()
              .add(SalesDetailsEvent.deleteSale(sale.id));
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
          context
              .read<SalesDetailsBloc>()
              .add(SalesDetailsEvent.fetchSaleDetails(sale.id));
        }
      },
    );
  }

  Future<void> _openInvoicePdf(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final pdfBytes = await getIt<GetSaleInvoicePdfUseCase>()(sale.id);
      if (context.mounted) Navigator.of(context).pop();
      if (kIsWeb) {
        openPdfInNewTab(pdfBytes, 'sales_invoice_${sale.id}.pdf');
        return;
      }
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/sales_invoice_${sale.id}.pdf');
      await file.writeAsBytes(pdfBytes);
      await OpenFile.open(file.path);
    } catch (e) {
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) {
        context.showSnackBar('Failed to open invoice: $e', isError: true);
      }
    }
  }

  Widget _buildIconActionButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
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
