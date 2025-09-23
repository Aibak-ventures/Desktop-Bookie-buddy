import 'dart:developer';
import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/features/wallet/models/pending_model/ledger_pending_model.dart';
import 'package:dio/dio.dart';

class PendingService {
  final Dio _dio = DioClient.dio;

  Future<PaginationModel<LedgerPendingModel>> fetchPendingPagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v2/bookings/wallet/pending-amounts/',
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId
        },
      );

      log('status code: ${response.statusCode}, data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        final result = (data["results"] as List)
            .map((e) => LedgerPendingModel.fromJson(e))
            .toList();
        return PaginationModel<LedgerPendingModel>(
          data: result,
          totalData: data["count"],
          nextPageUrl: data["next"],
        );
      } else {
        log(response.data);
        throw 'Failed to load balance data';
      }
    } on DioException catch (e) {
      log('Fetch Balance Error: ${e.message}');
      throw 'Error fetching balance: ${e.message}';
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw e;
    }
  }
}
