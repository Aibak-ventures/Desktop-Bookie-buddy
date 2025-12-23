import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:bookie_buddy_web/core/models/bug_report_model/bug_report_model.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/navigation/navigations.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/profile/view_model/cubit_bug_report/bug_report_cubit.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report a Problem'),
        elevation: 0,
      ),
      body: BlocListener<BugReportCubit, BugReportState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            success: (message) {
              Flushbar(
                message: message,
                icon: const Icon(Icons.check_circle, color: Colors.white),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
                margin: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(8),
                flushbarPosition: FlushbarPosition.TOP,
              ).show(navigatorKey.currentContext!);
              
              // Go back after showing success
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pop();
              });
            },
            error: (message) {
              Flushbar(
                message: 'Error: $message',
                icon: const Icon(Icons.error, color: Colors.white),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
                margin: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(8),
                flushbarPosition: FlushbarPosition.TOP,
              ).show(navigatorKey.currentContext!);
            },
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Report an Issue',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Help us improve by reporting any problems you encounter',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),
              
              // Instructions card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'How to Report',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildInstructionStep(
                      '1. Tap the "Start Bug Report" button below',
                      Icons.touch_app,
                    ),
                    const SizedBox(height: 8),
                    _buildInstructionStep(
                      '2. Draw or annotate on the screenshot to highlight the problem',
                      Icons.draw,
                    ),
                    const SizedBox(height: 8),
                    _buildInstructionStep(
                      '3. Describe the issue in detail',
                      Icons.edit_note,
                    ),
                    const SizedBox(height: 8),
                    _buildInstructionStep(
                      '4. Submit the report',
                      Icons.send,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Start bug report button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showFeedbackForm(context);
                  },
                  icon: const Icon(Icons.bug_report, size: 24),
                  label: const Text(
                    'Start Bug Report',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Additional info
              Center(
                child: Text(
                  'Your feedback helps us improve BookieBuddy',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionStep(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blue.shade700),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade900,
            ),
          ),
        ),
      ],
    );
  }

  void _showFeedbackForm(BuildContext context) {
    BetterFeedback.of(context).show((UserFeedback feedback) {
      try {
        log('Feedback received: ${feedback.text}');
        log('Screenshot length: ${feedback.screenshot.length}');

        final userCubit = context.read<UserCubit>();
        final user = userCubit.state;

        // Prepare more details
        final moreDetails = {
          'user_id': user?.id.toString() ?? 'unknown',
          'user_name': user?.userFullName ?? 'unknown',
          'shop_id': user?.shopDetails.id.toString() ?? 'unknown',
          'shop_name': user?.shopDetails.name ?? 'unknown',
          'app_version': '1.0.0', // TODO: Get from package_info
          'platform': 'desktop',
          'timestamp': DateTime.now().toIso8601String(),
        };

        // Create bug report model
        final bugReport = BugReportModel(
          title: feedback.text.isEmpty 
              ? 'Bug Report - ${DateTime.now()}' 
              : feedback.text,
          description: feedback.text,
          moreDetails: moreDetails,
          image1: feedback.screenshot.toString(), // Screenshot from BetterFeedback
          image2: null,
        );

        // Submit the bug report
        context.read<BugReportCubit>().submitBugReport(bugReport);
      } catch (e, stack) {
        log('Error processing feedback: $e', stackTrace: stack);
        Flushbar(
          message: 'Failed to process feedback: $e',
          icon: const Icon(Icons.error, color: Colors.white),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
        ).show(navigatorKey.currentContext!);
      }
    });
  }
}
