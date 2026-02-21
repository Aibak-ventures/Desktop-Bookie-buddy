import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/product/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:bookie_buddy_web/features/product/view/widgets/variant_size_type_text_field.dart';
import 'package:bookie_buddy_web/features/product_details/view/widgets/monthly_bar_chart.dart';
import 'package:bookie_buddy_web/features/product_details/view_model/product_details_cubit.dart';
import 'package:bookie_buddy_web/features/product_details/view_model/product_details_state.dart';
import 'package:bookie_buddy_web/features/stock_management/view_model/stock_management_cubit.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/product/view/product_add_expense_dialog.dart';
import 'package:bookie_buddy_web/features/all_booking/view/widgets/booking_details_drawer.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_booking_details_drawer/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/stock_management/view/widgets/add_edit_product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/features/product/view_model/cubit_add_expense/add_expense_cubit.dart';
import 'package:bookie_buddy_web/features/product/view_model/cubit_save_product/save_product_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final int? serviceId; // Service ID passed from navigation
final MainServiceType? mainServiceType;
final ProductModel? productForEdit; // Optional product model for direct data access
  const ProductDetailsScreen({
    super.key,
    required this.productId,
    this.serviceId,
    this.mainServiceType,
    this.productForEdit,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentPage = 1;
  String _currentBookingStatus = 'upcoming'; // Track current tab status

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Listen to tab changes and reload bookings with the appropriate status
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final newStatus = _tabController.index == 0 ? 'upcoming' : 'completed';
        if (newStatus != _currentBookingStatus) {
          _currentBookingStatus = newStatus;
          context
              .read<ProductDetailsCubit>()
              .reloadBookingsWithStatus(widget.productId, _currentBookingStatus);
        }
      }
    });
    
    context
        .read<ProductDetailsCubit>()
        .loadProductDetails(widget.productId, bookingStatus: _currentBookingStatus);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookingDetailsDrawerCubit()),
      ],
      child: BlocListener<BookingDetailsDrawerCubit, BookingDetailsDrawerState>(
        listener: (context, drawerState) {
          // When drawer opens with a booking ID, fetch the booking details
          if (drawerState.isOpen && drawerState.selectedBookingId != null) {
            context.read<BookingDetailsBloc>().add(
                  BookingDetailsEvent.fetchBookingDetails(
                    drawerState.selectedBookingId!,
                  ),
                );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          body: Stack(
            children: [
              BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const Center(child: Text('Initializing...')),
                    loading: () => const Center(
                      child: CircularProgressIndicator(color: AppColors.purple),
                    ),
                    loaded: (product, bookings, monthlySummary, nextPageUrl,
                            isPaginatingBookings) =>
                        _buildContent(
                            context, product, bookings, monthlySummary),
                    error: (message) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline,
                              size: 64, color: Colors.red.shade300),
                          const SizedBox(height: 16),
                          Text(
                            message,
                            style: TextStyle(
                                fontSize: 16, color: Colors.red.shade600),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductDetailsCubit>()
                                  .loadProductDetails(widget.productId, bookingStatus: _currentBookingStatus);
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
              // Drawer overlay
              const BookingDetailsDrawer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ProductModel product,
    List<BookingsModel> bookings,
    List<ProductMonthlyDataModel> monthlySummary,
  ) {
    return Padding(
      padding: const EdgeInsets.all(3),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Back button with better styling
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: IconButton(
              onPressed: () {
                context.read<StockManagementCubit>().hideProductDetails();
              },
              icon: const Icon(Icons.arrow_back, size: 20),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
              tooltip: 'Back to Stock Management',
            ),
          ),
          const SizedBox(width: 16),
          // Title with gradient accent
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Product Overview',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Detailed view and management',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Action buttons with enhanced styling
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  _showDeleteProductDialog(product);
                },
                icon: Icon(Icons.delete_outline,
                    size: 16, color: Colors.red.shade600),
                label: const Text('Delete',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red.shade600,
                  side: BorderSide(color: Colors.red.shade200, width: 1.5),
                  backgroundColor: Colors.red.shade50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () {
                  _showAddEditProductDialog(context, product: widget.productForEdit);
                },
                icon: const Icon(Icons.edit_outlined, size: 16),
                label: const Text('Edit Product',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.purple,
                  side: BorderSide(
                      color: AppColors.purple.withOpacity(0.3), width: 1.5),
                  backgroundColor: AppColors.purple.withOpacity(0.05),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // Removed Add Expense button - no longer needed
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeftPanel(ProductModel product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Name and Price Row
            Container(
              width: 408,
              height: 279,
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
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Purchase Price below name (hide if 0)
                      if (product.purchaseAmount != null &&
                          product.purchaseAmount! > 0)
                        Text(
                          'Purchase: ₹${NumberFormat('#,###').format(product.purchaseAmount)}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Price on the right
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${NumberFormat('#,###').format(product.price ?? 0)}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFF6132E4),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Sale price below main price (right aligned) - show actual salePrice from first variant
                    Builder(
                      builder: (context) {
                        int? salePrice;
                        if (product.variants.isNotEmpty) {
                          salePrice = product.variants.first.salePrice;
                        }
                        return Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Sale:',
                                style: TextStyle(
                                  color: Color(0xFF8E8E8E),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: salePrice != null
                                    ? ' ₹${NumberFormat('#,###').format(salePrice)}'
                                    : ' -',
                                style: const TextStyle(
                                  color: Color(0xFFFFA93A),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Divider
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),

            // Available Serial Numbers (hide for non-variant service products)
            if (product.variants.length > 1 ||
                (product.variants.length == 1 &&
                    product.variants.first.attribute != product.name))
              ..._buildVariantsSection(product),

            // Stock count for non-variant products
            if (product.variants.length == 1 &&
                product.variants.first.attribute == product.name) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.purple.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.purple.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.inventory_2_outlined,
                            size: 20, color: AppColors.purple),
                        const SizedBox(width: 12),
                        const Text(
                          'Total Stock:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${product.variants.first.stock} Units',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Product Specifications
            if (product.category != null ||
                product.model != null ||
                product.color != null) ...[
              const Text(
                'Product Specifications',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (product.category != null &&
                        product.category!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 12,
                        ),
                        child: _specChip(Icons.category, product.category!),
                      ),
                    if (product.model != null && product.model!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _specChip(Icons.layers, product.model!),
                      ),
                    if (product.color != null && product.color!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _specChip(Icons.palette, product.color!),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Vehicle-specific information (Registration & Valid Upto) for vehicles
            // Always show for vehicles, even if fields are empty (show N/A)
            // Show if: mainServiceType is vehicle OR if we have vehicle attributes (fallback)
            if ((product.effectiveRegistrationNumber != null ||
                product.effectivePollutionExpiry != null ||
                product.effectiveInsuranceExpiry != null ||
                product.effectiveFitnessExpiry != null)) ...[
              // Registration Number
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.app_registration,
                        size: 18, color: Colors.grey.shade600),
                    const SizedBox(width: 12),
                    const Text(
                      'Registration No:',
                      style: TextStyle(
                        color: Color(0xFF787878),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      product.effectiveRegistrationNumber != null &&
                              product.effectiveRegistrationNumber!.isNotEmpty
                          ? product.effectiveRegistrationNumber!
                          : 'N/A',
                      style: TextStyle(
                        color: product.effectiveRegistrationNumber != null &&
                                product.effectiveRegistrationNumber!.isNotEmpty
                            ? Colors.black
                            : Colors.grey.shade400,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Valid Upto Section (Expiry Dates) - Always show for vehicles
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F0FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.purple.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.verified_user_outlined,
                            size: 18, color: AppColors.purple),
                        const SizedBox(width: 8),
                        const Text(
                          'Valid Upto',
                          style: TextStyle(
                            color: AppColors.purple,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildExpiryRow(
                        'Pollution',
                        product.effectivePollutionExpiry?.isNotEmpty == true
                            ? product.effectivePollutionExpiry!
                            : 'N/A'),
                    const SizedBox(height: 8),
                    _buildExpiryRow(
                        'Insurance',
                        product.effectiveInsuranceExpiry?.isNotEmpty == true
                            ? product.effectiveInsuranceExpiry!
                            : 'N/A'),
                    const SizedBox(height: 8),
                    _buildExpiryRow(
                        'Permit',
                        product.effectiveFitnessExpiry?.isNotEmpty == true
                            ? product.effectiveFitnessExpiry!
                            : 'N/A'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Description
            if (product.description != null &&
                product.description!.isNotEmpty) ...[
              const Text(
                'Description',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.description!,
                style: const TextStyle(
                  color: Color(0xFF787878),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
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
    List<BookingsModel> bookings,
    List<ProductMonthlyDataModel> monthlySummary,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Monthly Growth Section
          Row(
            children: [
              const Icon(Icons.bar_chart, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Monthly Growth',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

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
          // Row(
          //   children: [
          //     Expanded(
          //       child: _metricCard('Total Orders', '42', '+12%', Colors.green),
          //     ),
          //     const SizedBox(width: 16),
          //     Expanded(
          //       child: _metricCard('Revenue', '₹67.2K', '+8%', Colors.green),
          //     ),
          //     const SizedBox(width: 16),
          //     Expanded(
          //       child: _metricCard('Avg. Order', '₹1,600', '0%', Colors.grey),
          //     ),
          //   ],
          // ),

          const SizedBox(height: 16),

          // Bookings Section with Tabs
          const Text(
            'Bookings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),

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
                // Upcoming Bookings (API filtered)
                _buildBookingsList(
                  bookings,
                  'No upcoming bookings',
                ),
                // Completed Bookings (API filtered)
                _buildBookingsList(
                  bookings,
                  'No completed bookings',
                  isOngoing: true,
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
      width: 130,
      height: 25,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            color: Color(0xFFE0E0E0),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.black,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for vehicle expiry dates
  Widget _buildExpiryRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF787878),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: value == 'N/A' ? Colors.grey.shade400 : Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _variantCard(ProductVariantModel variant, ProductModel product) {
    // For gadgets, use wider rectangular design to accommodate serial numbers
    final isGadget = product.mainServiceType?.isGadget == true;
    final cardWidth = isGadget ? 150.0 : 82.0;
    final cardHeight = 65.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: cardWidth,
          height: cardHeight,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFE0E0E0),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                variant.attribute,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF171717),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${variant.stock} stocks',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        // Edit icon at top-right for editing variant
        Positioned(
          top: -5,
          right: -5,
          child: InkWell(
            onTap: () {
              _showEditVariantDialog(variant);
            },
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.purple,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteProductDialog(ProductModel product) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.productDeletion,
      onSuccess: () async {
        try {
          await context.read<ProductDetailsCubit>().deleteProduct(product.id);
          if (mounted) {
            context.read<StockManagementCubit>().hideProductDetails();
            context.showSnackBar('Product deleted successfully');
          }
        } catch (e) {
          if (mounted) {
            context.showSnackBar('Failed to delete product: $e', isError: true);
          }
        }
      },
    );
  }

  void _showDeleteVariantDialog(ProductVariantModel variant) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.productDeletion,
      onSuccess: () async {
        await context.read<ProductDetailsCubit>().deleteProductVariant(
              productId: widget.productId,
              variantId: variant.id,
            );
      },
    );
  }

  // Helper method to build variants section (only if product has variants)
  List<Widget> _buildVariantsSection(ProductModel product) {
    return [
      const Text(
        'Available Serial Numbers',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
      ),
      const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...product.variants.map((variant) => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _variantCard(variant, product),
                )),
            _addVariantButton(),
          ],
        ),
      ),
      const SizedBox(height: 12),
    ];
  }

  Widget _addVariantButton() {
    return Container(
      width: 82,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: AppColors.purple, width: 2, style: BorderStyle.solid),
      ),
      child: IconButton(
        onPressed: () {
          _showAddVariantDialog(context);
        },
        icon: const Icon(Icons.add, color: AppColors.purple),
      ),
    );
  }

  void _showAddVariantDialog(BuildContext context) {
    final variantAttributeController = TextEditingController();
    final variantQuantityController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    // Get current product from state to initialize variantsNotifier
    final currentState = context.read<ProductDetailsCubit>().state;
    List<ProductVariantModel> currentVariants = [];
    currentState.maybeWhen(
      loaded: (product, _, __, ___, ____) => currentVariants = product.variants,
      orElse: () {},
    );

    final variantsNotifier =
        ValueNotifier<List<ProductVariantModel>>(List.from(currentVariants));

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Add Variant',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Same field style as VariantsWidget
              VariantSizeTypeTextField(
                variantAttributeController: variantAttributeController,
                variantsNotifier: variantsNotifier,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: variantQuantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  hintText: 'Enter quantity',
                  border: const OutlineInputBorder(),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: AppInputValidators.quantity,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final attribute = variantAttributeController.text.trim();
                final quantity =
                    int.tryParse(variantQuantityController.text.trim()) ?? 0;

                try {
                  // Show loading or something if needed
                  await context.read<ProductDetailsCubit>().addProductVariant(
                        productId: widget.productId,
                        attribute: attribute,
                        stock: quantity,
                      );

                  if (context.mounted) {
                    Navigator.of(dialogContext).pop();
                    context.showSnackBar('Variant added successfully');
                  }
                } catch (e) {
                  if (context.mounted) {
                    context.showSnackBar('Failed to add variant: $e',
                        isError: true);
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditVariantDialog(ProductVariantModel variant) {
    final variantAttributeController =
        TextEditingController(text: variant.attribute);
    final variantQuantityController =
        TextEditingController(text: variant.stock.toString());
    final externalBarcodeController =
        TextEditingController(text: variant.externalQrCode ?? '');
    final formKey = GlobalKey<FormState>();

    // Get current product from state to initialize variantsNotifier (excluding current variant)
    final currentState = context.read<ProductDetailsCubit>().state;
    List<ProductVariantModel> currentVariants = [];
    currentState.maybeWhen(
      loaded: (product, _, __, ___, ____) => currentVariants =
          product.variants.where((v) => v.id != variant.id).toList(),
      orElse: () {},
    );

    final variantsNotifier =
        ValueNotifier<List<ProductVariantModel>>(List.from(currentVariants));

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'Edit Variant',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VariantSizeTypeTextField(
                variantAttributeController: variantAttributeController,
                variantsNotifier: variantsNotifier,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: variantQuantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  hintText: 'Enter quantity',
                  border: const OutlineInputBorder(),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: AppInputValidators.quantity,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: externalBarcodeController,
                decoration: InputDecoration(
                  labelText: 'External Barcode (Optional)',
                  hintText: 'Enter external QR code or barcode',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.qr_code),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          // Delete button
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _showDeleteVariantDialog(variant);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final attribute = variantAttributeController.text.trim();
                final quantity =
                    int.tryParse(variantQuantityController.text.trim()) ?? 0;
                final externalBarcode = externalBarcodeController.text.trim();

                try {
                  // Update variant
                  await context
                      .read<ProductDetailsCubit>()
                      .updateProductVariant(
                        productId: widget.productId,
                        variantId: variant.id,
                        attribute: attribute,
                        stock: quantity,
                        externalQrCode:
                            externalBarcode.isEmpty ? null : externalBarcode,
                      );

                  if (context.mounted) {
                    Navigator.of(dialogContext).pop();
                    context.showSnackBar('Variant updated successfully');
                  }
                } catch (e) {
                  if (context.mounted) {
                    context.showSnackBar('Failed to update variant: $e',
                        isError: true);
                  }
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(List<BookingsModel> bookings, String emptyMessage,
      {bool isOngoing = false}) {
    if (bookings.isEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.event_busy_outlined,
                size: 48,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 12),
              Text(
                emptyMessage,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 12),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];

        // Display booking card with side drawer on tap
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BookingCard(
            booking: booking,
            useReturnDate: isOngoing,
            // onTap: () => _showBookingDetailsDrawer(booking),
            onTap: () {
              // Open booking details drawer using the cubit
              context.read<BookingDetailsDrawerCubit>().openDrawer(booking.id!);
            },
          ),
        );
      },
    );
  }


  /// Show add/edit product dialog (same as stock management screen)
  Future<void> _showAddEditProductDialog(BuildContext context,
      {ProductModel? product}) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SaveProductCubit()),
          BlocProvider.value(value: context.read<ServiceBloc>()),
        ],
        child: AddEditProductDialog(
          serviceId: widget.serviceId ,
          product: product,
        ),
      ),
    );

    // Refresh product details if a product was edited
    if (result == true && mounted) {
      context
          .read<ProductDetailsCubit>()
          .loadProductDetails(widget.productId, bookingStatus: _currentBookingStatus);
    }
  }

  void _showBookingDetailsDrawerOLD(BookingsModel booking) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Booking Details',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            elevation: 16,
            child: Container(
              width: 450,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.purple,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.white, size: 24),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Booking Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Customer', booking.clientName),
                          _buildDetailRow(
                              'Booking ID', booking.id?.toString() ?? 'N/A'),
                          _buildDetailRow('Status', booking.bookingStatus.name),
                          _buildDetailRow(
                              'Delivery Status', booking.deliveryStatus.name),
                          _buildDetailRow(
                              'Payment Status', booking.paymentStatus.name),
                          if (booking.bookedDate != null)
                            _buildDetailRow(
                                'Booking Date',
                                DateFormat('MMM dd, yyyy').format(
                                    booking.bookedDate!.parseToDateTime())),
                          if (booking.pickupDate != null)
                            _buildDetailRow(
                                'Pickup Date',
                                DateFormat('MMM dd, yyyy').format(
                                    booking.pickupDate!.parseToDateTime())),
                          if (booking.returnDate != null)
                            _buildDetailRow(
                                'Return Date',
                                DateFormat('MMM dd, yyyy').format(
                                    booking.returnDate!.parseToDateTime())),
                          if (booking.shopBookingId != null &&
                              booking.shopBookingId!.isNotEmpty)
                            _buildDetailRow(
                                'Shop Booking ID', booking.shopBookingId!),
                          if (booking.staffName != null &&
                              booking.staffName!.isNotEmpty)
                            _buildDetailRow('Staff', booking.staffName!),
                          if (booking.bookedItems.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Booked Items',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...booking.bookedItems.map((item) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          '• $item',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF1F2937),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
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
