import 'package:dio/dio.dart';

extension DioExtensionError on Response {
  String dioResponseError() {
    if (data != null && data is Map<String, dynamic>) {
      final Map<String, dynamic> errorData = data;
      return errorData['message'] ?? 
             errorData['error'] ?? 
             errorData['response'] ?? 
             'Unknown error occurred';
    }
    return statusMessage ?? 'Unknown error occurred';
  }
}
