import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/features/product/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:bookie_buddy_web/features/product_details/view/widgets/monthly_bar_chart.dart';
import 'package:bookie_buddy_web/features/product_details/view_model/product_details_cubit.dart';
import 'package:bookie_buddy_web/features/product_details/view_model/product_details_state.dart';
import 'package:bookie_buddy_web/features/stock_management/view_model/stock_management_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Initializing...')),
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.purple),
            ),
            loaded: (product, bookings, monthlySummary, nextPageUrl,
                    isPaginatingBookings) =>
                _buildContent(context, product, bookings, monthlySummary),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline,
                      size: 64, color: Colors.red.shade300),
                  const SizedBox(height: 16),
                  Text(
                    message,
                    style: TextStyle(fontSize: 16, color: Colors.red.shade600),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<ProductDetailsCubit>()
                          .loadProductDetails(widget.productId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ProductModel product,
    List bookings,
    List<ProductMonthlyDataModel> monthlySummary,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, product),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildLeftPanel(product),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 3,
                  child: _buildRightPanel(product, bookings, monthlySummary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProductModel product) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            // Use state-based navigation to return to product list
            context.read<StockManagementCubit>().hideProductDetails();
          },
          icon: const Icon(Icons.arrow_back, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 12),
        const Text(
          'Product Overview',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3436),
          ),
        ),
        const Spacer(),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Delete product
                  },
                  icon: const Icon(Icons.delete_outline, size: 16),
                  label: const Text('Delete', style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: BorderSide(color: Colors.red.shade300),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Edit product
                  },
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: const Text('Edit', style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey.shade700,
                    side: BorderSide(color: Colors.grey.shade300),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add expense
                  },
                  icon: const Icon(Icons.add, size: 16),
                  label:
                      const Text('Add Expense', style: TextStyle(fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftPanel(ProductModel product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: product.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CustomNetworkImage(
                        imageUrl: product.image!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Icons.image, size: 80, color: Colors.grey.shade400),
            ),
            const SizedBox(height: 24),

            // Product Name and Prices
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Purchase',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${NumberFormat('#,###').format(product.purchaseAmount ?? 0)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sale',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${NumberFormat('#,###').format(product.price ?? 0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Product Specifications
            const Text(
              'Product Specifications',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                if (product.category != null && product.category!.isNotEmpty)
                  _specChip(Icons.category, product.category!),
                if (product.model != null && product.model!.isNotEmpty)
                  _specChip(Icons.layers, product.model!),
                if (product.color != null && product.color!.isNotEmpty)
                  _specChip(Icons.palette, product.color!),
              ],
            ),

            const SizedBox(height: 32),

            // Available Variants
            const Text(
              'Available variants',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ...product.variants.map((variant) => _variantCard(variant)),
                _addVariantButton(),
              ],
            ),

            const SizedBox(height: 32),

            // Description
            if (product.description != null &&
                product.description!.isNotEmpty) ...[
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.description!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRightPanel(
    ProductModel product,
    List bookings,
    List<ProductMonthlyDataModel> monthlySummary,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sales Growth Section
          Row(
            children: [
              const Icon(Icons.bar_chart, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Sales Growth',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Monthly summary bar chart
          SizedBox(
            width: double.infinity,
            child: MonthlyBarChart(
              monthlyData: monthlySummary,
              height: 180,
            ),
          ),

          const SizedBox(height: 16),

          // Metrics
          Row(
            children: [
              Expanded(
                child: _metricCard('Total Orders', '42', '+12%', Colors.green),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _metricCard('Revenue', '₹67.2K', '+8%', Colors.green),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _metricCard('Avg. Order', '₹1,600', '0%', Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Bookings Section with Tabs
          const Text(
            'Bookings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),

          // Tab Bar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.purple,
              unselectedLabelColor: Colors.grey.shade600,
              indicatorColor: AppColors.purple,
              indicatorWeight: 2,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Upcoming Bookings
                _buildBookingsList(
                  bookings
                      .where((b) =>
                          b.bookingStatus != 'completed' &&
                          b.bookingStatus != 'cancelled')
                      .toList(),
                  'No upcoming bookings',
                ),
                // Completed Bookings
                _buildBookingsList(
                  bookings
                      .where((b) => b.bookingStatus == 'completed')
                      .toList(),
                  'No completed bookings',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _specChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _variantCard(variant) {
    final stockColor = variant.stock > 0 ? Colors.green : Colors.red;

    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            variant.attribute,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${variant.stock} stocks',
            style: TextStyle(
              fontSize: 12,
              color: stockColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addVariantButton() {
    return Container(
      width: 100,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppColors.purple, width: 2, style: BorderStyle.solid),
      ),
      child: IconButton(
        onPressed: () {
          // TODO: Add variant
        },
        icon: const Icon(Icons.add, color: AppColors.purple),
      ),
    );
  }

  Widget _buildBookingsList(List bookings, String emptyMessage) {
    if (bookings.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];

        // Parse pickup date to extract day and month
        String pickupDay = '';
        String pickupMonth = '';
        if (booking.pickupDate != null && booking.pickupDate.isNotEmpty) {
          try {
            final parts = booking.pickupDate.split('-');
            if (parts.length >= 2) {
              pickupDay = parts[0];
              final monthNames = [
                'Jan',
                'Feb',
                'Mar',
                'Apr',
                'May',
                'Jun',
                'Jul',
                'Aug',
                'Sep',
                'Oct',
                'Nov',
                'Dec'
              ];
              final monthNum = int.tryParse(parts[1]) ?? 1;
              pickupMonth = monthNames[monthNum - 1];
            }
          } catch (e) {
            pickupDay = '';
            pickupMonth = '';
          }
        }

        // Determine delivery status color
        Color deliveryStatusColor = Colors.green;
        if (booking.deliveryStatus == 'pending') {
          deliveryStatusColor = Colors.orange;
        } else if (booking.deliveryStatus == 'delivered') {
          deliveryStatusColor = Colors.green;
        } else if (booking.deliveryStatus == 'returned') {
          deliveryStatusColor = Colors.blue;
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Date Box
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pickupDay,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.purple,
                      ),
                    ),
                    Text(
                      pickupMonth,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.purple.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // Booking Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Client Name
                    Text(
                      booking.clientName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Payment & Delivery Status Row
                    Row(
                      children: [
                        Icon(
                          Icons.wallet,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Payment :',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: booking.paymentStatus.name == 'paid'
                                ? Colors.orange.withOpacity(0.15)
                                : Colors.grey.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            booking.paymentStatus.name == 'paid'
                                ? 'Pending'
                                : 'Unpaid',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: booking.paymentStatus.name == 'paid'
                                  ? Colors.orange.shade700
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Items
                    if (booking.bookedItems.isNotEmpty)
                      Text(
                        'Items : ${booking.bookedItems.join(', ')}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    const SizedBox(height: 6),

                    // Delivery Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: deliveryStatusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        booking.deliveryStatus.toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: deliveryStatusColor.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow Icon
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
                size: 24,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _metricCard(
      String label, String value, String change, Color changeColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: changeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
