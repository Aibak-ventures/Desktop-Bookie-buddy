import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/widgets/show_variant_selection_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/pages/add_or_edit_product_screen.dart';
import 'package:bookie_buddy_web/features/expense/presentation/dialogs/product_add_expense_dialog.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/pages/product_growth_screen.dart';
import 'package:bookie_buddy_web/features/product/presentation/stock_management/bloc/product_bloc/product_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/bloc/product_growth_bloc/product_growth_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/bloc/product_info_bloc/product_info_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/pages/product_all_bookings_screen.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/bloc/product_booking_completed_bloc/product_booking_completed_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/bloc/product_booking_upcoming_bloc/product_booking_upcoming_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/transfer_product/pages/transfer_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Modern Product Info Screen - Optimized for Web with elegant design
class ProductInfoScreen extends StatelessWidget {
  final int serviceId;
  final int productId;
  final MainServiceType mainServiceType;

  const ProductInfoScreen({
    required this.serviceId,
    required this.productId,
    required this.mainServiceType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProductInfoBloc>()
          .add(ProductInfoEvent.loadProductInfo(productId));
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Product Overview'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        actions: _buildAppBarActions(context),
      ),
      body: SingleChildScrollView(
        child: _buildBody(context),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    final showMoreOption =
        context.read<UserCubit>().state?.haveMultipleShops ?? false;

    if (!showMoreOption) return [];

    return [
      BlocBuilder<ProductInfoBloc, ProductInfoState>(
        builder: (context, state) {
          final isVisible = state.maybeMap(
            orElse: () => false,
            loaded: (value) =>
                value.productInfo.variants.every((v) => v.stock != 0),
          );

          if (!isVisible) return const SizedBox.shrink();

          return Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ElevatedButton.icon(
              onPressed: () async {
                final product =
                    context.read<ProductInfoBloc>().getProductInfo();
                if (product == null) {
                  context.showSnackBar('Product not found', isError: true);
                  return;
                }

                await performSecureActionDialog(
                  context,
                  SecretPasswordLocations.transferProduct,
                  onSuccess: () async {
                    final selectedVariantId = product.variants.length == 1
                        ? product.variants.first.id
                        : await showVariantSelectionDialog(
                            context: context,
                            productId: productId,
                            variants: product.variants,
                            mainServiceType: mainServiceType,
                          );

                    if (selectedVariantId == null) return;

                    final result = await context.push(
                      TransferProductScreen(
                        serviceId: serviceId,
                        product: product,
                        variantId: selectedVariantId,
                        mainServiceType: mainServiceType,
                      ),
                    );

                    if (result is bool && result) {
                      context
                          .read<ProductInfoBloc>()
                          .add(ProductInfoEvent.loadProductInfo(productId));
                    }
                  },
                );
              },
              icon: const Icon(Icons.swap_horiz, size: 18),
              label: const Text('Transfer Product'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        },
      ),
    ];
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<ProductInfoBloc, ProductInfoState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (error) => context.showSnackBar(error, isError: true),
          failure: (message) => context.showSnackBar(message, isError: true),
          success: (message, needPop) {
            if (needPop) {
              context.pop();
              context
                  .read<ProductBloc>()
                  .add(ProductEvent.loadProducts(serviceId));
            } else {
              context
                  .read<ProductInfoBloc>()
                  .add(ProductInfoEvent.loadProductInfo(productId));
            }
            context.showSnackBar(message);
          },
        );
      },
      buildWhen: (previous, current) {
        return current.maybeWhen(
          orElse: () => true,
          failure: (_) => false,
          success: (_, __) => false,
        );
      },
      builder: (context, state) {
        return state.when(
          loading: () => Container(
            height: 600.h,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.purple),
              ),
            ),
          ),
          error: (error) => _errorView(context, error),
          failure: (message) => _errorView(context, message),
          success: (message, needPop) => const SizedBox.shrink(),
          loaded: (product) => _buildModernLayout(context, product),
        );
      },
    );
  }

  Widget _errorView(BuildContext context, String msg) {
    return Container(
      height: 600.h,
      padding: EdgeInsets.all(40.w),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.w,
              color: AppColors.red,
            ),
            SizedBox(height: 24.h),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.grey800,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              msg,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.grey600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () => context
                  .read<ProductInfoBloc>()
                  .add(ProductInfoEvent.loadProductInfo(productId)),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                foregroundColor: AppColors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernLayout(BuildContext context, ProductModel product) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1400.w),
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          children: [
            // Hero Section with Product Image and Basic Info
            _buildHeroSection(context, product),
            SizedBox(height: 32.h),

            // Main Content Grid
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 1200;

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2, child: _buildLeftColumn(context, product)),
                      SizedBox(width: 32.w),
                      Expanded(
                          flex: 1, child: _buildRightColumn(context, product)),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildLeftColumn(context, product),
                      SizedBox(height: 32.h),
                      _buildRightColumn(context, product),
                    ],
                  );
                }
              },
            ),

            SizedBox(height: 32.h),

            // Action Buttons Section
            _buildActionSection(context, product),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, ProductModel product) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 200.w,
            height: 200.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.grey100,
              border: Border.all(color: AppColors.grey200),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: product.image != null && product.image!.isNotEmpty
                  ? CustomNetworkImage(
                      imageUrl: product.image!,
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Icon(
                        Icons.inventory_2_outlined,
                        size: 80.w,
                        color: AppColors.grey400,
                      ),
                    ),
            ),
          ),

          SizedBox(width: 32.w),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          height: 1.2,
                        ),
                      ),
                    ),
                    _buildStatusBadge(product),
                  ],
                ),

                SizedBox(height: 8.h),

                Text(
                  'Product ID: #${product.id}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.grey600,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 16.h),

                if (product.description != null &&
                    product.description!.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.grey100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.grey200),
                    ),
                    child: Text(
                      product.description!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.grey700,
                        height: 1.5,
                      ),
                    ),
                  ),

                SizedBox(height: 24.h),

                // Quick Stats Row
                Row(
                  children: [
                    _buildQuickStat(
                      'Price',
                      '₹${product.price ?? 0}',
                      Icons.attach_money,
                      AppColors.green,
                    ),
                    SizedBox(width: 16.w),
                    _buildQuickStat(
                      'Total Stock',
                      '${product.variants.fold<int>(0, (p, v) => p + v.stock)}',
                      Icons.inventory,
                      AppColors.purple,
                    ),
                    SizedBox(width: 16.w),
                    _buildQuickStat(
                      'Variants',
                      '${product.variants.length}',
                      Icons.tune,
                      AppColors.gold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(ProductModel product) {
    final totalStock = product.variants.fold<int>(0, (p, v) => p + v.stock);
    final isInStock = totalStock > 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isInStock ? AppColors.green : AppColors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isInStock ? Icons.check_circle : Icons.warning,
            color: AppColors.white,
            size: 16.w,
          ),
          SizedBox(width: 4.w),
          Text(
            isInStock ? 'In Stock' : 'Out of Stock',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(
      String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grey200),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: color, size: 20.w),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey600,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftColumn(BuildContext context, ProductModel product) {
    return Column(
      children: [
        _buildModernCard(
          'Product Details',
          Icons.info_outline,
          AppColors.purple,
          Column(
            children: [
              _buildDetailRow('Name', product.name),
              _buildDetailRow('Category', product.category ?? 'Uncategorized'),
              _buildDetailRow('Model', product.model ?? 'N/A'),
              _buildDetailRow('Color', product.color ?? 'N/A'),
              if (product.purchaseAmount != null)
                _buildDetailRow('Purchase Price', '₹${product.purchaseAmount}'),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        _buildModernCard(
          'Variants & Stock',
          Icons.inventory_2_outlined,
          AppColors.green,
          Column(
            children: product.variants
                .map((variant) => _buildVariantCard(variant))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context, ProductModel product) {
    return Column(
      children: [
        _buildModernCard(
          'Quick Actions',
          Icons.bolt,
          AppColors.yellow,
          Column(
            children: [
              _buildActionButton(
                'Edit Product',
                Icons.edit,
                AppColors.purple,
                () => _showEditDialog(context, product),
              ),
              SizedBox(height: 12.h),
              _buildActionButton(
                'Add Expense',
                Icons.add_circle_outline,
                AppColors.green,
                () => _showExpenseDialog(context),
              ),
              SizedBox(height: 12.h),
              _buildActionButton(
                'View Growth',
                Icons.trending_up,
                AppColors.purple,
                () => _showGrowthScreen(context),
              ),
              SizedBox(height: 12.h),
              _buildActionButton(
                'View Bookings',
                Icons.calendar_today,
                AppColors.yellow,
                () => _showBookingsScreen(context),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        _buildModernCard(
          'Danger Zone',
          Icons.warning_outlined,
          AppColors.red,
          _buildActionButton(
            'Delete Product',
            Icons.delete_outline,
            AppColors.red,
            () => _showDeleteDialog(context, product),
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection(BuildContext context, ProductModel product) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activities',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.grey),
                SizedBox(width: 12.w),
                Text(
                  'No recent activities to display',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernCard(
      String title, IconData icon, Color accentColor, Widget child) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: accentColor, size: 20.w),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          child,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantCard(variant) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  variant.attribute,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey800,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Stock: ${variant.stock}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: variant.stock > 0 ? AppColors.green : AppColors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              variant.stock > 0 ? 'Available' : 'Out of Stock',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18.w),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, ProductModel product) async {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.productEdit,
      onSuccess: () async {
        final result = await context.push(
          AddOrEditProductScreen(
            serviceId: serviceId,
            product: product,
          ),
        );

        if (result is bool && result) {
          context
              .read<ProductInfoBloc>()
              .add(ProductInfoEvent.loadProductInfo(productId));
        }
      },
    );
  }

  void _showDeleteDialog(BuildContext context, ProductModel product) async {
    await performSecureActionDialog(
      context,
      SecretPasswordLocations.productDeletion,
      onSuccess: () {
        context.read<ProductInfoBloc>().add(
              ProductInfoEvent.deleteProduct(
                productId: productId,
                variantId: product.variants.length == 1
                    ? null
                    : product.variants.first.id,
              ),
            );
      },
    );
  }

  void _showExpenseDialog(BuildContext context) async {
    final product = context.read<ProductInfoBloc>().getProductInfo();
    if (product == null) return;

    showProductAddExpenseDialog(
      context: context,
      variantId: product.variants.first.id,
      mainServiceType: mainServiceType,
      variants: product.variants,
    );

    // await showDialog(
    //   context: context,
    //   builder: (context) => BlocProvider(
    //     create: (_) => AddExpenseCubit(saveProductExpenseUsecase: getIt.get()),
    //     child: ProductAddExpenseDialog(
    //       variantId: product.variants.first.id,
    //       mainServiceType: mainServiceType,
    //       variants: product.variants,
    //     ),
    //   ),
    // );
  }

  void _showGrowthScreen(BuildContext context) async {
    await context.push(
      BlocProvider(
        create: (_) => ProductGrowthBloc(getProductGrowthData: getIt.get()),
        child: ProductGrowthScreen(
          productId: productId,
        ),
      ),
    );
  }

  void _showBookingsScreen(BuildContext context) async {
    await context.push(
      MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  ProductBookingUpcomingBloc(getProductBookings: getIt.get())),
          BlocProvider(
              create: (_) =>
                  ProductBookingCompletedBloc(getProductBookings: getIt.get())),
        ],
        child: ProductAllBookingsScreen(
          productId: productId,
        ),
      ),
    );
  }
}
