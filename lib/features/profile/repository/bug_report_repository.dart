import 'dart:developer';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/bug_report_model/bug_report_model.dart';

class BugReportRepository {
  static final Dio _dio = DioClient.dio;

  Future<void> submitBugReport(BugReportModel bugReport) async {
    try {
      // Prepare form data
      final formData = FormData.fromMap({
        'title': bugReport.title,
        'description': bugReport.description,
        'more_details': jsonEncode(bugReport.moreDetails),
      });

      // Add image1 if exists (base64 screenshot from feedback)
      if (bugReport.image1 != null && bugReport.image1!.isNotEmpty) {
        try {
          // Image from feedback plugin is base64 encoded
          final bytes = base64Decode(bugReport.image1!.split(',').last);
          formData.files.add(
            MapEntry(
              'image1',
              MultipartFile.fromBytes(
                bytes,
                filename: 'screenshot_${DateTime.now().millisecondsSinceEpoch}.png',
              ),
            ),
          );
        } catch (e) {
          log('Error adding screenshot: $e');
        }
      }

      // Add image2 if exists
      if (bugReport.image2 != null && bugReport.image2!.isNotEmpty) {
        try {
          final bytes = base64Decode(bugReport.image2!.split(',').last);
          formData.files.add(
            MapEntry(
              'image2',
              MultipartFile.fromBytes(
                bytes,
                filename: 'additional_${DateTime.now().millisecondsSinceEpoch}.png',
              ),
            ),
          );
        } catch (e) {
          log('Error adding additional image: $e');
        }
      }

      // Log form data for debugging
      log('Bug Report FormData:');
      formData.fields.forEach((field) {
        log('  ${field.key}: ${field.value}');
      });
      formData.files.forEach((file) {
        log('  File: ${file.key} -> ${file.value.filename}');
      });

      // Submit bug report to API
      // TODO: Replace with actual API endpoint when available
      final response = await _dio.post(
        '/api/v1/bug-reports/',
        data: formData,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw 'Failed to submit bug report: ${response.statusMessage}';
      }

      log('Bug report submitted successfully: ${response.data}');
    } catch (e, stack) {
      log('Error submitting bug report: $e', stackTrace: stack);
      rethrow;
    }
  }
}
