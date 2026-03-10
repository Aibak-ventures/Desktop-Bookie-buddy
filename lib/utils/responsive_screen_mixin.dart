import 'package:bookie_buddy_web/utils/responsive_helper.dart';
import 'package:bookie_buddy_web/core/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

/// Mixin to easily make any screen responsive
/// Usage: class MyScreen extends StatelessWidget with ResponsiveScreenMixin
mixin ResponsiveScreenMixin on Widget {
  /// Override this method to provide the screen title
  String get screenTitle => 'Screen';

  /// Override this method to provide the screen icon
  IconData get screenIcon => Icons.dashboard_outlined;

  /// Override this method to provide custom app bar actions
  List<Widget> getAppBarActions(BuildContext context) => [];

  /// Override this method to provide the main content
  Widget buildContent(BuildContext context);

  /// Override this method to control back button visibility
  bool get showBackButton => true;

  /// Override this method to provide custom background color for desktop
  Color? get desktopBackgroundColor => const Color(0xFFF8F9FA);

  Widget buildResponsiveScreen(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ResponsiveHelper.isDesktop(context) ? desktopBackgroundColor : null,
      appBar: ResponsiveHelper.isMobile(context)
          ? AppBar(
              automaticallyImplyLeading: showBackButton,
              title: Text(screenTitle),
              actions: getAppBarActions(context),
            )
          : null,
      body: ResponsiveWidget(
        mobile: buildContent(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
        largeDesktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Column(
        children: [
          // Header Section
          if (!ResponsiveHelper.isMobile(context))
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 40,
              ),
              child: Row(
                children: [
                  if (showBackButton) ...[
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      screenIcon,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          screenTitle,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        Text(
                          'Manage your ${screenTitle.toLowerCase()}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...getAppBarActions(context),
                ],
              ),
            ),

          // Content Section
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: buildContent(context),
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 60,
            ),
            child: Row(
              children: [
                if (showBackButton) ...[
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey.shade700,
                      fixedSize: const Size(48, 48),
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    screenIcon,
                    color: Theme.of(context).primaryColor,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        screenTitle,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Text(
                        'Manage yours ${screenTitle.toLowerCase()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                ...getAppBarActions(context),
              ],
            ),
          ),

          // Content Section
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                margin: const EdgeInsets.symmetric(horizontal: 80),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: buildContent(context),
                ),
              ),
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
