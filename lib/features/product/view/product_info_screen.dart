    import 'package:bookie_buddy_web/core/app_dependencies.dart';
    import 'package:bookie_buddy_web/core/enums/enums.dart';
    import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
    import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
    import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
    import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
    import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
    import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
    import 'package:bookie_buddy_web/core/theme/app_colors.dart';
    import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
    import 'package:bookie_buddy_web/core/ui/dialogs/show_variant_selection_dialog.dart';
    import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
    import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
    import 'package:bookie_buddy_web/core/ui/widgets/custom_responsive_builder.dart';
    import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
    import 'package:bookie_buddy_web/features/product/view/add_or_edit_product_screen.dart';
    import 'package:bookie_buddy_web/features/product/view/product_add_expense_dialog.dart';
    import 'package:bookie_buddy_web/features/product/view/product_growth_screen.dart';
    import 'package:bookie_buddy_web/features/product/view/widgets/variant_size_type_text_field.dart';
    import 'package:bookie_buddy_web/features/product/view_model/bloc_product/product_bloc.dart';
    import 'package:bookie_buddy_web/features/product/view_model/bloc_product_growth/product_growth_bloc.dart';
    import 'package:bookie_buddy_web/features/product/view_model/bloc_product_info/product_info_bloc.dart';
    import 'package:bookie_buddy_web/features/product/view_model/cubit_add_expense/add_expense_cubit.dart';
    import 'package:bookie_buddy_web/features/product_all_booking/view/product_all_bookings_screen.dart';
    import 'package:bookie_buddy_web/features/product_all_booking/view_model/bloc_product_booking_completed/product_booking_completed_bloc.dart';
    import 'package:bookie_buddy_web/features/product_all_booking/view_model/bloc_product_booking_upcoming/product_booking_upcoming_bloc.dart';
    import 'package:bookie_buddy_web/features/transfer_product/view/transfer_product_screen.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';
    import 'package:flutter_screenutil/flutter_screenutil.dart';

    class ProductInfoScreen extends StatelessWidget {
      final int serviceId;
      final int productId;
      final MainServiceType mainServiceType;

      ProductInfoScreen({
        required this.serviceId,
        required this.productId,
        required this.mainServiceType,
        Key? key,
      }) : super(key: key);  

      @override
      Widget build(BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => context
              .read<ProductInfoBloc>()
              .add(ProductInfoEvent.loadProductInfo(productId)),
        );
        final showMoreOption =
            context.read<UserCubit>().state?.haveMultipleShops ?? false;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product overview'),
            actions: [
              if (showMoreOption)
                BlocBuilder<ProductInfoBloc, ProductInfoState>(
                  builder: (context, state) {
                    final isVisible = state.maybeMap(
                      orElse: () => false,
                      loaded: (value) {
                        if (value.productInfo.variants.every(
                          (e) => e.stock != 0,
                        )) return true;
                        return false;
                      },
                    );
                    return Visibility(
                      visible: isVisible,
                      child: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) async {
                          if (value == 'transfer') {
                            final product =
                                context.read<ProductInfoBloc>().getProductInfo();
                            if (product == null) {
                              context.showSnackBar(
                                'Product not found',
                                isError: true,
                              );
                              return;
                            }

                            performSecureActionDialog(
                              context,
                              SecretPasswordLocations.transferProduct,
                              onSuccess: () async {
                                final selectedVariantId =
                                    product.variants.length == 1
                                        ? product.variants.first.id
                                        : await showVariantSelectionDialog(
                                            context: context,
                                            productId: productId,
                                            variants: product.variants,
                                            mainServiceType: mainServiceType,
                                          );

                                if (selectedVariantId == null) {
                                  return;
                                }

                                context
                                    .push(
                                  TransferProductScreen(
                                    serviceId: serviceId,
                                    product: product,
                                    variantId: selectedVariantId,
                                    mainServiceType: mainServiceType,
                                  ),
                                )
                                    .then(
                                  (value) {
                                    if (value is bool && value)
                                      context.read<ProductInfoBloc>().add(
                                          ProductInfoEvent.loadProductInfo(
                                              productId));
                                  },
                                );
                              },
                            );
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 'transfer',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.swap_horiz,
                                    color: AppColors.purple,
                                  ),
                                  SizedBox(width: 5),
                                  Text('Transfer products'),
                                ],
                              ),
                            ),
                          ];
                        },
                      ),
                    );
                  },
                )
            ],
          ),
          body: _buildResponsiveBody(context),
        );
      }

      Widget _buildResponsiveBody(BuildContext context) {
        if (context.isDesktop) {
          return _buildWebLayout(context);
        } else {
          return _buildMobileLayout(context);
        }
      }

      Widget _buildWebLayout(BuildContext context) {
        return Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 1400.w),
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding: EdgeInsets.all(24.w),
            child: BlocConsumer<ProductInfoBloc, ProductInfoState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (error) => context.showSnackBar(
                    error,
                    isError: true,
                  ),
                  failure: (message) => context.showSnackBar(
                    message,
                    isError: true,
                  ),
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
                    context.showSnackBar(
                      message,
                    );
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
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error) => Center(
                    child: Container(
                      padding: EdgeInsets.all(32.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CustomErrorWidget(
                        errorText: error,
                        onRetry: () {
                          context
                              .read<ProductInfoBloc>()
                              .add(ProductInfoEvent.loadProductInfo(productId));
                        },
                      ),
                    ),
                  ),
                  loaded: (product) {
                    final isFreeSize = VariantSizeType.isFreeSize(
                      product.variants.first.attribute,
                    );
                    return Column(
                      children: [
                        // Main content area
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left side - Product image
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.all(24.w),
                                  child: _buildImage(product),
                                ),
                              ),
                              SizedBox(width: 24.w),
                              // Right side - Product info and details
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    // Product info section
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.1),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        padding: EdgeInsets.all(24.w),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              _buildProductInfoSection(
                                                product,
                                                context,
                                                isFreeSize,
                                              ),
                                              SizedBox(height: 24.h),
                                              _buildMoreInfoButtons(
                                                context,
                                                product,
                                              ),
                                              SizedBox(height: 24.h),
                                              // Bookings section for web
                                              // Container(
                                              //   height: 400.h,
                                              //   decoration: BoxDecoration(
                                              //     color: AppColors.grey,
                                              //     borderRadius: BorderRadius.circular(12),
                                              //   ),
                                              //   child: Center(
                                              //     child: Text(
                                              //       'Bookings section',
                                              //       style: TextStyle(
                                              //         fontSize: 16.sp,
                                              //         color: AppColors.white,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // Action buttons
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(24.w),
                          child: _buildActionButtons(context, product),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      }

      Widget _buildMobileLayout(BuildContext context) {
        return CustomResponsiveBuilder(
          builder: (context, deviceType) => Padding(
            padding: 16.padding,
            child: BlocConsumer<ProductInfoBloc, ProductInfoState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (error) => context.showSnackBar(
                    error,
                    isError: true,
                  ),
                  failure: (message) => context.showSnackBar(
                    message,
                    isError: true,
                  ),
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
                    context.showSnackBar(
                      message,
                    );
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
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error) => CustomErrorWidget(
                    errorText: error,
                    onRetry: () {
                      context
                          .read<ProductInfoBloc>()
                          .add(ProductInfoEvent.loadProductInfo(productId));
                    },
                  ),
                  loaded: (product) {
                    final isFreeSize = VariantSizeType.isFreeSize(
                      product.variants.first.attribute,
                    );
                    return Column(
                      children: [
                        Expanded(
                          child: context.isMobile
                              ? SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Product Image
                                      _buildImage(product),
                                      SizedBox(height: 15.h),

                                      // Product basic info
                                      _buildProductInfoSection(
                                        product,
                                        context,
                                        isFreeSize,
                                      ),
                                      SizedBox(height: 15.h),

                                      // more info buttons
                                      _buildMoreInfoButtons(
                                        context,
                                        product,
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  ),
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Product Image
                                        Expanded(child: _buildImage(product)),
                                        SizedBox(width: 10.w),

                                        Expanded(
                                          child: Column(
                                            children: [
                                              _buildProductInfoSection(
                                                product,
                                                context,
                                                isFreeSize,
                                              ),
                                              SizedBox(height: 20.h),

                                              // more info buttons
                                              _buildMoreInfoButtons(
                                                context,
                                                product,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Bookings section',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),

                        // Action buttons
                        _buildActionButtons(context, product),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      }

      Row _buildActionButtons(BuildContext context, ProductModel product) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Edit button
            Flexible(
              child: _iconBuilder(
                context: context,
                icon: Icon(
                  Icons.edit_outlined,
                  size: 27.sp,
                  color: AppColors.grey,
                ),
                onTap: () async {
                  final needRefresh = await context.push(
                    AddOrEditProductScreen(
                      serviceId: serviceId,
                      product: product,
                    ),
                  );

                  if (needRefresh is bool && needRefresh) {
                    context
                        .read<ProductInfoBloc>()
                        .add(ProductInfoEvent.loadProductInfo(productId));
                    context
                        .read<ProductBloc>()
                        .add(ProductEvent.loadProducts(serviceId));
                  }
                },
              ),
            ),

            // Add expense button
            Flexible(
              flex: 2,
              child: _iconBuilder(
                context: context,
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.attach_money_outlined,
                      color: AppColors.purple,
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        'Add expense',
                        style: TextStyle(
                          color: AppColors.purple,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                shadowColor: AppColors.purpleLightShade,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) => AddExpenseCubit(repository: getIt.get()),
                      child: ProductAddExpenseDialog(
                        variantId: product.variants.first.id,
                        mainServiceType: mainServiceType,
                        variants: product.variants,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Delete button
            Flexible(
              child: _iconBuilder(
                context: context,
                icon: Icon(
                  Icons.delete_outlined,
                  color: AppColors.redTomato.lighten(0.2),
                  size: 27.sp,
                ),
                onTap: () {
                  showDeleteConfirmationDialog(
                    context: context,
                    productId: product.id,
                    variants: product.variants,
                  );
                },
              ),
            ),
          ],
        );
      }

      Row _buildMoreInfoButtons(BuildContext context, ProductModel product) {
        // final isMobile = context.isMobile;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Growth check button
            Flexible(
              child: _moreInfoButtonBuilder(
                text: 'Growth',
                prefixText: 'Check',
                icon: Icons.bar_chart_outlined,
                onTap: () {
                  context.push(
                    BlocProvider(
                      create: (context) => ProductGrowthBloc()
                        ..add(ProductGrowthEvent.loadProductGrowthData(
                          product.id,
                        )),
                      child: ProductGrowthScreen(
                        productId: product.id,
                      ),
                    ),
                  );
                },
              ),
            ),
            // if (isMobile) ...[
              SizedBox(width: 8.w),
              SizedBox(
                height: 80,
                child: VerticalDivider(
                  color: AppColors.grey300,
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: _moreInfoButtonBuilder(
                  text: 'Bookings',
                  prefixText: 'All',
                  icon: Icons.my_library_books_outlined,
                  onTap: () {
                    context.push(
                      MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                ProductBookingUpcomingBloc(repository: getIt.get())
                                  ..add(
                                    ProductBookingUpcomingEvent.loadBookings(
                                      product.id,
                                    ),
                                  ),
                          ),
                          BlocProvider(
                            create: (context) =>
                                ProductBookingCompletedBloc(repository: getIt.get())
                                  ..add(
                                    ProductBookingCompletedEvent.loadBookings(
                                      product.id,
                                    ),
                                  ),
                          ),
                        ],
                        child: ProductAllBookingsScreen(productId: product.id),
                      ),
                    );
                  },
                ),
              ),
            // ] else ...[
            //   SizedBox(width: 16.w),
            // ]
          ],
        );
      }

      // Placeholder methods - these need to be implemented based on the original file
      Widget _buildImage(ProductModel product) {
        return CustomNetworkImage(
          imageUrl: product.thumbnailImage ?? product.image ?? '',
          fit: BoxFit.contain,
        );
      }

      Widget _buildProductInfoSection(ProductModel product, BuildContext context, bool isFreeSize) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Description: ${product.description ?? 'No description'}',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.grey,
              ),
            ),
            Text(
              'Purchase: ₹${product.purchaseAmount ?? 'No description'}',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.grey,
              ),
            ),
            Text(
              'Colour: ${product.color ?? 'No description'}',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.grey,
              ),
            ),
            // Add more product info fields as needed
          ],
        );
      }

      Widget _iconBuilder({
        required BuildContext context,
        required Widget icon,
        required VoidCallback onTap,
        Color? shadowColor,
      }) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: shadowColor ?? Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: icon,
          ),
        );
      }

      Widget _moreInfoButtonBuilder({
        required String text,
        required String prefixText,
        required IconData icon,
        required VoidCallback onTap,
      }) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.purple),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(icon, size: 34.sp, color: AppColors.purple),
                SizedBox(height: 12.h),
                Text(
                  '$prefixText $text',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      void showDeleteConfirmationDialog({
        required BuildContext context,
        required int productId,
        required List<ProductVariantModel> variants,
      }) {
        // Implementation for delete confirmation dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Product'),
            content: const Text('Are you sure you want to delete this product?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Add delete logic here
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      }
    }