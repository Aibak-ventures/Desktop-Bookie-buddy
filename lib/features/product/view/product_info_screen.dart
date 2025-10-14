import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/app_icons.dart';
import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_variant_selection_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_responsive_builder.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
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
                            spacing: 5,
                            children: [
                              Icon(
                                Icons.swap_horiz,
                                color: AppColors.purple,
                              ),
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
      body: CustomResponsiveBuilder(
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
                        // flex: context.isMobile ? 1 : 0,
                        child: context.isMobile
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 15,
                                  children: [
                                    // Product Image
                                    _buildImage(product),

                                    // Product basic info
                                    _buildProductInfoSection(
                                      product,
                                      context,
                                      isFreeSize,
                                    ),

                                    // more info buttons
                                    _buildMoreInfoButtons(
                                      context,
                                      product,
                                    ),

                                    //
                                    20.height,
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 10,
                                    children: [
                                      // Product Image
                                      Expanded(child: _buildImage(product)),

                                      Expanded(
                                        child: Column(
                                          children: [
                                            _buildProductInfoSection(
                                              product,
                                              context,
                                              isFreeSize,
                                            ),

                                            20.height,

                                            // more info buttons
                                            _buildMoreInfoButtons(
                                              context,
                                              product,
                                            ),
                                          ],
                                        ),
                                      )

                                      // Product basic info
                                    ],
                                  ),
                                  10.height,
                                 Expanded(
                                  child: MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) =>
                                            ProductBookingUpcomingBloc(
                                              repository: getIt.get(),
                                            )..add(
                                              ProductBookingUpcomingEvent.loadBookings(
                                                product.id,
                                              ),
                                            ),
                                      ),
                                      BlocProvider(
                                        create: (context) =>
                                            ProductBookingCompletedBloc(
                                              repository: getIt.get(),
                                            )..add(
                                              ProductBookingCompletedEvent.loadBookings(
                                                product.id,
                                              ),
                                            ),
                                      ),
                                    ],
                                    child: ProductAllBookingsTabView(
                                      productId: productId,
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
      ),
      // bottomNavigationBar:
    );
  }

  Row _buildActionButtons(BuildContext context, ProductModel product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Edit button
        _iconBuilder(
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

        // Add expense button
        _iconBuilder(
          context: context,
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.attach_money_outlined,
                color: AppColors.purple,
              ),
              Text(
                'Add expense',
                style: TextStyle(
                  color: AppColors.purple,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
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

        // Delete button
        _iconBuilder(
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
      ],
    );
  }

  ClipRRect _buildImage(ProductModel product) {
    return ClipRRect(
      borderRadius: 20.radiusBorder,
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomNetworkImage(
          imageUrl: product.image ??
              'https://static.vecteezy.com/system/resources/thumbnails/054/519/001/small/e-commerce-product-box-illustration-for-sales-vector.jpg',
          filterQuality: FilterQuality.high,
          width: double.infinity,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) {
            return Image.asset(
              AppIcons.unknownProduct,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }

  Row _buildMoreInfoButtons(BuildContext context, ProductModel product) {
    final isMobile = context.isMobile;
    return Row(
      spacing: 10,
      mainAxisAlignment:
          isMobile ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.start,
      children: [
        // Growth check button
        _moreInfoButtonBuilder(
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
        if (isMobile) ...[
          SizedBox(
            height: 80,
            child: VerticalDivider(
              color: AppColors.grey300,
            ),
          ),
          _moreInfoButtonBuilder(
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
        ]
      ],
    );
  }

  Column _buildProductInfoSection(
      ProductModel product, BuildContext context, bool isFreeSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (product.price != null)
                  Text(
                    product.price!.toCurrency(),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (product.purchaseAmount != null)
                  Text(
                    'Purchase: ${product.purchaseAmount!.toCurrency()}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.grey,
                    ),
                  ),
              ],
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: Text(
                product.category == null || product.category!.isEmpty
                    ? 'Category: -'
                    : product.category!, // Replace with actual category name
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.grey,
                  // fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (!mainServiceType.isDress)
              Text(
                'Stock: ${product.variants.first.stock}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.grey,
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                product.color == null || product.color!.isEmpty
                    ? 'Color: -'
                    : product.color!, // Replace with actual color
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.blackShade,
                  // fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (mainServiceType.isDress)
              TextButton.icon(
                onPressed: () {
                  showVariantEditDialog(
                    context: context,
                    variants: product.variants,
                    productId: productId,
                  );
                },
                label: const Text('Edit'),
                icon: const Icon(Icons.edit),
              ),
          ],
        ),

        // Sizes
        if (mainServiceType.isDress)
          SizedBox(
            height: 100.w,
            width: double.infinity,
            child: isFreeSize
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 3,
                      children: [
                        _freeSizeVariantWidget(),
                        Text(
                          '${product.variants.first.stock} stocks',
                          style: TextStyle(
                            fontSize: 11.sp,
                          ),
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.variants.length + 1,
                    itemBuilder: (context, index) {
                      if (index < product.variants.length) {
                        final variant = product.variants[index];

                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 3,
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: const BoxDecoration(
                                  color: AppColors.purpleLight,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    variant.attribute,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                '${variant.stock} stocks',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 3,
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: const BoxDecoration(
                                color: AppColors.redLight,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ).onTap(
                              () {
                                showAddVariantDialog(
                                  context: context,
                                  productId: productId,
                                  variants: product.variants,
                                );
                              },
                            ),
                            Text(
                              'Add Variant',
                              style: TextStyle(
                                fontSize: 11.sp,
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
          ),

        if (product.description != null &&
            product.description!.trim().isNotEmpty)
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.height,
                Text('Description',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    )),
                5.height,
                Text(
                  product.description!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Container _freeSizeVariantWidget() {
    return Container(
      width: 130.w,
      padding: 10.padding,
      decoration: BoxDecoration(
        color: AppColors.purpleLight,
        borderRadius: 5.radiusBorder,
      ),
      child: Center(
        child: Text(
          'Free Size',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }

  Widget _iconBuilder({
    required BuildContext context,
    required Widget icon,
    required VoidCallback? onTap,
    Color? shadowColor,
  }) {
    return Container(
      padding: context.isMobile ? 18.padding : 22.padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: 50.radiusBorder,
        border: Border.all(color: AppColors.purpleLight),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? AppColors.grey200,
            blurRadius: 5,
            spreadRadius: 3,
          )
        ],
      ),
      child: icon,
    ).onTap(onTap);
  }

  Widget _moreInfoButtonBuilder({
    required String text,
    required String prefixText,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: 10.radiusBorder,
        border: Border.all(
          color: AppColors.purple,
        ),
      ),
      child: Padding(
        padding: 8.padding,
        child: Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      prefixText,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.grey,
                      ),
                    ),
                    Icon(
                      icon,
                      color: AppColors.purple,
                    )
                  ],
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            Container(
              padding: 6.padding,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey300,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ]),
              child: Icon(
                Icons.arrow_outward_outlined,
                size: 20.sp,
              ),
            )
          ],
        ),
      ),
    ).onTap(onTap);
  }

  void showDeleteConfirmationDialog({
    required BuildContext context,
    required int productId,
    required List<ProductVariantModel> variants,
  }) {
    ProductVariantModel? selectedVariant;

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: SizedBox(
          width: context.isMobile ? null : 0.6.widthR,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment:
                  !mainServiceType.isDress || variants.length == 1
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 15,
              children: [
                if (!mainServiceType.isDress || variants.length == 1)
                  Text(
                    'Delete Product',
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (mainServiceType.isDress && variants.length > 1)
                  StatefulBuilder(builder: (context, setState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Variant (Optional)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 55,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: variants.length,
                            itemBuilder: (context, index) {
                              final variant = variants[index];
                              final isSelected = selectedVariant == variant;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedVariant = variant;
                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.purpleLight
                                        : const Color(0xFFE8E4FF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF6C5CE7)
                                          : Colors.transparent,
                                      width: isSelected ? 2 : 0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      variant.attribute,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? const Color(0xFF6C5CE7)
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                const Text(
                  'Are you sure you want to delete?',
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 10,
                  children: [
                    TextButton(
                      onPressed: () => ctx.pop(),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ctx.pop();
                        context.read<ProductInfoBloc>().add(
                              ProductInfoEvent.deleteProduct(
                                productId: productId,
                                variantId: selectedVariant?.id,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Delete',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showVariantEditDialog({
    required BuildContext context,
    required int productId,
    required List<ProductVariantModel> variants,
  }) {
    ProductVariantModel? selectedVariant;
    final TextEditingController attributeController = TextEditingController();
    final TextEditingController stockController = TextEditingController();
    final isFreeSize = VariantSizeType.isFreeSize(variants.first.attribute);
    bool showAttributeField = true;
    if (isFreeSize) {
      selectedVariant = variants.first;
      stockController.text = selectedVariant.stock.toString();
      showAttributeField = false;
    }

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: SizedBox(
          width: context.isMobile ? null : 0.6.widthR,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(
              builder: (builderContext, setState) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 15,
                    children: [
                      const Text(
                        'Select Variant to Edit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        child: isFreeSize
                            ? _freeSizeVariantWidget()
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: variants.length,
                                itemBuilder: (context, index) {
                                  final variant = variants[index];
                                  final isSelected = selectedVariant == variant;

                                  return Container(
                                    width: 50,
                                    height: 50,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.purpleLight
                                          : const Color(0xFFE8E4FF),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF6C5CE7)
                                            : Colors.transparent,
                                        width: isSelected ? 2 : 0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        variant.attribute,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected
                                              ? const Color(0xFF6C5CE7)
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ).onTap(() {
                                    setState(() {
                                      selectedVariant = variant;
                                      attributeController.text =
                                          variant.attribute;
                                      stockController.text =
                                          variant.stock.toString();
                                    });
                                  });
                                },
                              ),
                      ),
                      if (selectedVariant != null) ...[
                        if (showAttributeField)
                          TextField(
                            controller: attributeController,
                            decoration: const InputDecoration(
                              labelText: 'Variant Size',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        TextField(
                          controller: stockController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Stock',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                      5.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 10,
                        children: [
                          TextButton(
                            onPressed: () => ctx.pop(),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: selectedVariant == null
                                ? null
                                : () {
                                    ctx.pop();
                                    if (selectedVariant!.attribute ==
                                            attributeController.text.trim() &&
                                        selectedVariant!.stock.toString() ==
                                            stockController.text.trim()) {
                                      context.showSnackBar("No changes made");
                                      return;
                                    }
                                    context.read<ProductInfoBloc>().add(
                                          ProductInfoEvent.updateVariant(
                                            productId: productId,
                                            variantId: selectedVariant!.id,
                                            updatedAttribute: isFreeSize
                                                ? null
                                                : attributeController.text
                                                    .trim(),
                                            updatedStock: stockController.text
                                                    .trim()
                                                    .toIntOrNull() ??
                                                selectedVariant!.stock,
                                          ),
                                        );
                                  },
                            child: const Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void showAddVariantDialog({
    required BuildContext context,
    required int productId,
    required List<ProductVariantModel> variants,
  }) {
    final TextEditingController attributeController = TextEditingController();
    final TextEditingController stockController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final variantSizeTypeNotifier =
        ValueNotifier<VariantSizeType>(VariantSizeType.letter);
    final variantsNotifier = ValueNotifier<List<ProductVariantModel>>(variants);
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: SizedBox(
          width: context.isMobile ? null : 0.6.widthR,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 15,
                  children: [
                    const Text(
                      'Add New Variant',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: variantSizeTypeNotifier,
                        builder: (context, sizeType, child) {
                          final isFreeSize =
                              sizeType == VariantSizeType.freeSize;
                          return CustomTextField(
                            controller: attributeController,
                            label: 'Variant Size',
                            hintText: sizeType.hintText,
                            readOnly: isFreeSize,
                            textCapitalization:
                                sizeType == VariantSizeType.letter
                                    ? TextCapitalization.characters
                                    : TextCapitalization.none,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: sizeType.validate,
                            suffixIcon: SizeTypeMenuButton(
                              onSelected: (option) {
                                variantSizeTypeNotifier.value = option;
                              },
                              variantsNotifier: variantsNotifier,
                            ),
                          );
                        }),
                    CustomTextField(
                      controller: stockController,
                      label: 'Stock',
                      hintText: 'Eg: 8 or 12',
                      keyboardType: TextInputType.number,
                      validator: AppInputValidators.quantity,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 10,
                      children: [
                        TextButton(
                          onPressed: () => ctx.pop(),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            ctx.pop();
                            context.read<ProductInfoBloc>().add(
                                  ProductInfoEvent.addProductVariant(
                                    productId: productId,
                                    attribute: attributeController.text.trim(),
                                    stock: int.tryParse(
                                          stockController.text.trim(),
                                        ) ??
                                        0,
                                  ),
                                );
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
