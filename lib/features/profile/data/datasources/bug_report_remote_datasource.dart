import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:bookie_buddy_web/features/profile/domain/models/bug_report_model/bug_report_model.dart';

class BugReportRemoteDatasource {
  final Dio _dio;

  BugReportRemoteDatasource(this._dio);

  Future<void> submitBugReport(BugReportModel bugReport) async {
    try {
      final formData = FormData.fromMap({
        'title': bugReport.title,
        'description': bugReport.description,
        'more_details': jsonEncode(bugReport.moreDetails),
      });

      if (bugReport.image1 != null && bugReport.image1!.isNotEmpty) {
        try {
          final bytes = base64Decode(bugReport.image1!.split(',').last);
          formData.files.add(
            MapEntry(
              'image1',
              MultipartFile.fromBytes(
                bytes,
                filename:
                    'screenshot_${DateTime.now().millisecondsSinceEpoch}.png',
              ),
            ),
          );
        } catch (e) {
          log('Error adding screenshot: $e');
        }
      }

      if (bugReport.image2 != null && bugReport.image2!.isNotEmpty) {
        try {
          final bytes = base64Decode(bugReport.image2!.split(',').last);
          formData.files.add(
            MapEntry(
              'image2',
              MultipartFile.fromBytes(
                bytes,
                filename:
                    'additional_${DateTime.now().millisecondsSinceEpoch}.png',
              ),
            ),
          );
        } catch (e) {
          log('Error adding additional image: $e');
        }
      }

      final response = await _dio.post(
        '/api/v1/bug-reports/',
        data: formData,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw 'Failed to submit bug report: ${response.statusMessage}';
      }
    } catch (e) {
      log('Error in BugReportRemoteDatasource.submitBugReport: $e');
      rethrow;
    }
  }
}
