
import 'dart:developer';
// import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
// import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:dio/dio.dart';

/// Downloads a file from the given URL and saves it to the specified file path.
/// Returns null if the download is successful, otherwise returns a [CustomResponseModel]
/// containing error details.
///
/// filePath should include the full path including the file name and extension.
/// e.g., /path/to/directory/filename.pdf
///
/// url is the endpoint to download the file from.
Future<CustomResponseModel?> downloadFileFromUrl({
  required String url,
  required String filePath,
  Map<String, dynamic>? queryParameters,
  CancelToken? cancelToken,
  ProgressCallback? onReceiveProgress,
}) async {
  final fileName = filePath.split('/').last;
  try {
    final response = await DioClient.dio.download(
      url,
      filePath,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    log(
      'Download File $fileName Response: ${response.realUri.toString()} , status code: ${response.statusCode}',
    );
    if (response.statusCode == 200) {
      return null;
    }
    return CustomResponseModel.fromJson(response.data);
  } catch (e, stack) {
    log('❌ Error downloading file $fileName: $e', stackTrace: stack);
    rethrow;
  }
}
