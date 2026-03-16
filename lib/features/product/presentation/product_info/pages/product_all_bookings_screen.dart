import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/pages/product_booking_completed_tab.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/pages/product_booking_upcoming_tab.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/bloc/product_booking_upcoming_bloc/product_booking_upcoming_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductAllBookingsScreen extends StatefulWidget {
  const ProductAllBookingsScreen({
    super.key,
    required this.productId,
  });
  final int productId;

  @override
  State<ProductAllBookingsScreen> createState() =>
      _ProductAllBookingsScreenState();
}

class _ProductAllBookingsScreenState extends State<ProductAllBookingsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load data initially
    context
        .read<ProductBookingUpcomingBloc>()
        .add(ProductBookingUpcomingEvent.loadBookings(widget.productId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Bookings'),
      ),
      body: Padding(
        padding: 10.padding,
        child: ProductAllBookingsTabView(productId: widget.productId),
      ),
    );
  }
}

class ProductAllBookingsTabView extends StatefulWidget {
  const ProductAllBookingsTabView({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ProductAllBookingsTabView> createState() =>
      _ProductAllBookingsTabViewState();
}

class _ProductAllBookingsTabViewState extends State<ProductAllBookingsTabView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load data initially
    context
        .read<ProductBookingUpcomingBloc>()
        .add(ProductBookingUpcomingEvent.loadBookings(widget.productId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: 10.padding,
            child: TabBarView(
              controller: _tabController,
              children: [
                ProductBookingUpcomingTab(productId: widget.productId),
                ProductBookingCompletedTab(productId: widget.productId),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
