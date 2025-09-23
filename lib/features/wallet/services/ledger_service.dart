import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/features/wallet/models/ledger_invoice_entry_model/ledger_invoice_entry_model.dart';
import 'package:bookie_buddy_web/features/wallet/models/ledger_security_amount_model/ledger_security_amount_model.dart';
import 'package:path_provider/path_provider.dart';

class LedgerService {
  Future<List<LedgerInvoiceEntryModel>> fetchDataForInvoicePdf({
    required String fromDate,
    required String toDate,
    int? clientId,
    String type = 'all',
  }) async {
    try {
      final response = await DioClient.dio.get(
        '/api/v1/expenses/transaction-history/',
        queryParameters: {
          'from_date': fromDate,
          'to_date': toDate,
          'type': type,
          if (clientId != null) 'client_id': clientId,
        },
      );
      if (response.statusCode == 200) {
        return (response.data['transactions'] as List)
            .map(
              (e) => LedgerInvoiceEntryModel.fromJson(e),
            )
            .toList();
      } else {
        log('status code: ${response.statusCode}, data: ${response.data}');
        throw response.data['error'] ?? 'Failed to fetch data for invoice pdf';
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<String> downloadLedgerInvoice({
    required String fromDate,
    required String toDate,
    int? clientId,
    String type = 'all',
  }) async {
    final dir =
        await getTemporaryDirectory(); // You can also use getExternalStorageDirectory()
    final filePath =
        '${dir.path}/transactions_${DateTime.now().millisecondsSinceEpoch}.xlsx';

    try {
      final response = await DioClient.dio.download(
        '/api/v1/expenses/export-transactions/excel/',
        filePath,
        queryParameters: {
          'from_date': fromDate,
          'to_date': toDate,
          'type': type,
          if (clientId != null) 'client_id': clientId
        },
      );
      if (response.statusCode == 200) {
        return filePath;
      } else {
        log('status code: ${response.statusCode}, data: ${response.data}');
        throw 'Failed to fetch data for invoice pdf';
      }
    } catch (e, stack) {
      print("❌ Error downloading file: $e");
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<PaginationModel<LedgerSecurityAmountModel>>
      fetchSecurityAmountsPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await DioClient.dio.get(
        '/api/v2/bookings/wallet/security-amounts/',
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId
        },
      );

      if (response.statusCode == 200) {
        final data = (response.data['results'] as List)
            .map((e) => LedgerSecurityAmountModel.fromJson(e))
            .toList();
        return PaginationModel<LedgerSecurityAmountModel>(
          data: data,
          nextPageUrl: response.data['next'],
          totalData: response.data['count'],
        );
      } else {
        throw response.data['error'] ?? 'Something went wrong, try again';
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
