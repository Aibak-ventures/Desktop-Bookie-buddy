import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & FAQ'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildFAQItem(
            'How do I add a booking?',
            'Go to the home screen and tap the + button to create a new booking.',
          ),
          _buildFAQItem(
            'How do I manage staff?',
            'Navigate to Profile > Staff to add, edit, or manage your staff members.',
          ),
          _buildFAQItem(
            'How do I view reports?',
            'Access the Ledger from your profile to view financial reports and statements.',
          ),
          _buildFAQItem(
            'How do I contact support?',
            'Go to Profile > Contact & Support to reach our support team.',
          ),
          const SizedBox(height: 32),
          const Text(
            'Need More Help?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Navigate to contact support
            },
            icon: const Icon(Icons.support_agent),
            label: const Text('Contact Support'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(answer),
          ),
        ],
      ),
    );
  }
}
