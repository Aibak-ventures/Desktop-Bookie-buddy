// import 'package:bookie_buddy_web/utils/responsive_helper.dart';
// import 'package:bookie_buddy_web/core/widgets/responsive_widget.dart';
// import 'package:flutter/material.dart';

// /// Universal template for making any screen responsive
// /// Copy this template and replace the content with your screen's content
// class ResponsiveScreenTemplate extends StatelessWidget {
//   final String title;
//   final Widget content;
//   final List<Widget>? action;
//   final bool showBackButton;

//   const ResponsiveScreenTemplate({
//     super.key,
//     required this.title,
//     required this.content,
//     this.actions,
//     this.showBackButton = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ResponsiveHelper.isDesktop(context)
//           ? const Color(0xFFF8F9FA)
//           : null,
//       appBar: ResponsiveHelper.isMobile(context)
//           ? AppBar(
//               automaticallyImplyLeading: showBackButton,
//               title: Text(title),
//               actions: actions,
//             )
//           : null,
//       body: ResponsiveWidget(
//         mobile: _buildMobileLayout(context),
//         tablet: _buildTabletLayout(context),
//         desktop: _buildDesktopLayout(context),
//         largeDesktop: _buildDesktopLayout(context),
//       ),
//     );
//   }

//   Widget _buildMobileLayout(BuildContext context) {
//     return content;
//   }

//   Widget _buildTabletLayout(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color(0xFFF8F9FA),
//             Color(0xFFE9ECEF),
//           ],
//         ),
//       ),
//       child: Column(
//         children: [
//           if (!ResponsiveHelper.isMobile(context))
//             // Header Section
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 40,
//                 vertical: 40,
//               ),
//               child: Row(
//                 children: [
//                   if (showBackButton) ...[
//                     IconButton(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const Icon(Icons.arrow_back),
//                       style: IconButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: Colors.grey.shade700,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                   ],
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(
//                       Icons.dashboard_outlined,
//                       color: Theme.of(context).primaryColor,
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           title,
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey.shade800,
//                           ),
//                         ),
//                         Text(
//                           'Manage your ${title.toLowerCase()}',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   if (actions != null) ...actions!,
//                 ],
//               ),
//             ),

//           // Content Section
//           Expanded(
//             child: Center(
//               child: Container(
//                 constraints: const BoxConstraints(maxWidth: 600),
//                 margin: const EdgeInsets.symmetric(horizontal: 40),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 20,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: content,
//               ),
//             ),
//           ),

//           const SizedBox(height: 60),
//         ],
//       ),
//     );
//   }

//   Widget _buildDesktopLayout(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color(0xFFF8F9FA),
//             Color(0xFFE9ECEF),
//           ],
//         ),
//       ),
//       child: Column(
//         children: [
//           // Header Section
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(
//               horizontal: 80,
//               vertical: 60,
//             ),
//             child: Row(
//               children: [
//                 if (showBackButton) ...[
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.arrow_back),
//                     style: IconButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Colors.grey.shade700,
//                       fixedSize: const Size(48, 48),
//                     ),
//                   ),
//                   const SizedBox(width: 24),
//                 ],
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Icon(
//                     Icons.dashboard_outlined,
//                     color: Theme.of(context).primaryColor,
//                     size: 32,
//                   ),
//                 ),
//                 const SizedBox(width: 24),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey.shade800,
//                         ),
//                       ),
//                       Text(
//                         'Manage your ${title.toLowerCase()}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (actions != null) ...actions!,
//               ],
//             ),
//           ),

//           // Content Section
//           Expanded(
//             child: Center(
//               child: Container(
//                 constraints: const BoxConstraints(maxWidth: 1000),
//                 margin: const EdgeInsets.symmetric(horizontal: 80),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 30,
//                       offset: const Offset(0, 8),
//                     ),
//                   ],
//                 ),
//                 child: content,
//               ),
//             ),
//           ),

//           const SizedBox(height: 80),
//         ],
//       ),
//     );
//   }
// }
