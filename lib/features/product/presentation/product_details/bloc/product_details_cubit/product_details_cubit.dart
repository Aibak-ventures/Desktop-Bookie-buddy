import 'dart:developer';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_monthly_data_entity/product_monthly_data_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/add_product_variants_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_product_bookings_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_product_growth_data_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_product_info_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/update_variant_usecase.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_details/bloc/product_details_cubit/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductInfoUseCase _getProductInfo;
  final GetProductBookingsUseCase _getProductBookings;
  final GetProductGrowthDataUseCase _getProductGrowthData;
  final AddProductVariantsUseCase _addProductVariants;
  final UpdateVariantUseCase _updateVariant;
  final DeleteProductUseCase _deleteProduct;

  ProductDetailsCubit({
    required GetProductInfoUseCase getProductInfo,
    required GetProductBookingsUseCase getProductBookings,
    required GetProductGrowthDataUseCase getProductGrowthData,
    required AddProductVariantsUseCase addProductVariants,
    required UpdateVariantUseCase updateVariant,
    required DeleteProductUseCase deleteProduct,
  }) : _getProductInfo = getProductInfo,
       _getProductBookings = getProductBookings,
       _getProductGrowthData = getProductGrowthData,
       _addProductVariants = addProductVariants,
       _updateVariant = updateVariant,
       _deleteProduct = deleteProduct,
       super(const ProductDetailsState.initial());

  Future<void> loadProductDetails(
    int productId, {
    String? bookingStatus,
  }) async {
    try {
      emit(const ProductDetailsState.loading());

      final results = await Future.wait([
        _getProductInfo(productId),
        _getProductBookings(
          productId: productId,
          page: 1,
          status: bookingStatus,
        ).then<dynamic>((v) => v).catchError((e) {
          log('Error loading bookings: $e');
          return null;
        }),
        _getProductGrowthData(productId).then<dynamic>((v) => v).catchError((e) {
          log('Error loading monthly summary: $e');
          return <ProductMonthlyDataEntity>[];
        }),
      ]);

      final product = results[0] as ProductEntity;
      final bookingsData = results[1] as PaginationModel<BookingEntity>?;
      final monthlyData = results[2] as List<ProductMonthlyDataEntity>;

      emit(
        ProductDetailsState.loaded(
          product: product,
          bookings: bookingsData?.data ?? [],
          monthlySummary: monthlyData,
          nextPageUrl: bookingsData?.nextPageUrl,
        ),
      );
    } catch (e) {
      log('Error loading product details: $e');
      emit(ProductDetailsState.error(message: 'An error occurred: ${e.toString()}'));
    }
  }

  Future<void> reloadBookingsWithStatus(int productId, String? status) async {
    await state.maybeMap(
      loaded: (loadedState) async {
        try {
          final bookingsData = await _getProductBookings(
            productId: productId,
            page: 1,
            status: status,
          );
          emit(
            ProductDetailsState.loaded(
              product: loadedState.product,
              bookings: bookingsData.data,
              monthlySummary: loadedState.monthlySummary,
              nextPageUrl: bookingsData.nextPageUrl,
            ),
          );
        } catch (e) {
          log('Error reloading bookings: $e');
        }
      },
      orElse: () async {},
    );
  }

  Future<void> loadMoreBookings(int productId, int page, {String? status}) async {
    state.maybeMap(
      loaded: (loadedState) {
        if (loadedState.isPaginatingBookings || loadedState.nextPageUrl == null) return;

        emit(
          ProductDetailsState.loaded(
            product: loadedState.product,
            bookings: loadedState.bookings,
            monthlySummary: loadedState.monthlySummary,
            nextPageUrl: loadedState.nextPageUrl,
            isPaginatingBookings: true,
          ),
        );

        _getProductBookings(productId: productId, page: page, status: status)
            .then((moreBookings) {
              emit(
                ProductDetailsState.loaded(
                  product: loadedState.product,
                  bookings: [...loadedState.bookings, ...moreBookings.data],
                  monthlySummary: loadedState.monthlySummary,
                  nextPageUrl: moreBookings.nextPageUrl,
                  isPaginatingBookings: false,
                ),
              );
            })
            .catchError((e) {
              log('Error loading more bookings: $e');
              emit(
                ProductDetailsState.loaded(
                  product: loadedState.product,
                  bookings: loadedState.bookings,
                  monthlySummary: loadedState.monthlySummary,
                  nextPageUrl: loadedState.nextPageUrl,
                  isPaginatingBookings: false,
                ),
              );
            });
      },
      orElse: () {},
    );
  }

  Future<void> addProductVariant({
    required int productId,
    required String attribute,
    required int stock,
  }) async {
    try {
      await _addProductVariants(productId: productId, attribute: attribute, stock: stock);
      await loadProductDetails(productId);
    } catch (e) {
      log('Error adding product variant: $e');
      rethrow;
    }
  }

  Future<void> updateProductVariant({
    required int productId,
    required int variantId,
    required String attribute,
    required int stock,
    String? externalQrCode,
  }) async {
    try {
      await _updateVariant(
        productId: productId,
        variantId: variantId,
        updatedAttribute: attribute,
        updatedStock: stock,
        externalQrCode: externalQrCode,
      );
      await loadProductDetails(productId);
    } catch (e) {
      log('Error updating product variant: $e');
      rethrow;
    }
  }

  Future<void> deleteProductVariant({
    required int productId,
    required int variantId,
  }) async {
    try {
      await _deleteProduct(productId: productId, variantId: variantId);
      await loadProductDetails(productId);
    } catch (e) {
      log('Error deleting product variant: $e');
      rethrow;
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      await _deleteProduct(productId: productId);
    } catch (e) {
      log('Error deleting product: $e');
      rethrow;
    }
  }
}
