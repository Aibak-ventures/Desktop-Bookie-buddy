import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: 16.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About BookieBuddy',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.height,
              Text(
                "Bookie Buddy is a comprehensive mobile application designed to streamline rental management and booking-related businesses. Packed with essential features, it offers tools for managing upcoming bookings, tracking expenses, overseeing product inventory, and monitoring cash flow. Whether you're handling rentals, bookings, or any related business operations, Bookie Buddy provides a user-friendly solution to ensure efficiency and organization. With its robust functionality, it caters to all the critical needs of a business, making it an indispensable tool for entrepreneurs looking to simplify their operations and enhance productivity.",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
              25.height,
              Text(
                "what bookie buddy doing :",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.height,

              buildText(
                  'Track and organize bookings: Never miss a reservation or appointment.'),
              // Text(
              //   '◉ Track and organize bookings: Never miss a reservation or appointment.',
              //   style: TextStyle(
              //     fontSize: AppSizes.fontMedium,
              //     color: Colors.grey[700],
              //   ),
              // ),

              buildText(
                  'Monitor expenses: Keep full control of your business costs and budgets.'),
              // Text(
              //   '◉ Monitor expenses: Keep full control of your business costs and budgets.',
              //   style: TextStyle(
              //     fontSize: AppSizes.fontMedium,
              //     color: Colors.grey[700],
              //   ),
              // ),

              buildText(
                  'Manage inventory: Track products and supplies for your business needs.'),
              // Text(
              //   '◉ Manage inventory: Track products and supplies for your business needs.',
              //   style: TextStyle(
              //     fontSize: AppSizes.fontMedium,
              //     color: Colors.grey[700],
              //   ),
              // ),

              buildText(
                  'Oversee cash flow: Maintain a clear view of your financial transactions.'),
              // Text(
              //   '◉ Oversee cash flow: Maintain a clear view of your financial transactions.',
              //   style: TextStyle(
              //     fontSize: AppSizes.fontMedium,
              //     color: Colors.grey[700],
              //   ),
              // ),

              buildText(
                  'Handle customer information: Store contact details and preferences.'),

              // Text(
              //   '◉ Handle customer information: Store contact details and preferences.',
              //   style: TextStyle(
              //     fontSize: AppSizes.fontMedium,
              //     color: Colors.grey[700],
              //   ),
              // ),

              buildText(
                  'Track payments: Record and monitor all payment activities.'),
              // Text(
              //   '◉ Track payments: Record and monitor all payment activities.',
              //   style: TextStyle(
              //     fontSize: AppSizes.fontMedium,
              //     color: Colors.grey[700],
              //   ),
              // ),
              buildText(
                  'Generate reports: Create detailed business insights and analytics.'),
              // Text(
              //   '◉ Generate reports: Create detailed business insights and analytics.',
              //   style: TextStyle(
              //     fontSize: AppSizes.fontMedium,
              //     color: Colors.grey[700],
              //   ),
              // ),
              10.height,
              Text(
                'Bookie Buddy simplifies your workflow for booking services. Save time, stay organized, and manage all aspects of your booking business with ease.',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
                softWrap: true,
              ),
              // const CustomText(
              //   text:
              //       'Bookie Buddy simplifies your workflow for booking services. Save time, stay organized, and manage all aspects of your booking business with ease.',
              //   size: 0.04,
              //   color: Colors.black87,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildText(String text) {
    return Text(
      '◉ $text',
      style: TextStyle(
        fontSize: AppSizes.fontMedium,
        color: Colors.grey[700],
      ),
    );
  }
}
