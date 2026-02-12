import 'dart:developer';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/features/product/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:bookie_buddy_web/features/product_details/view_model/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository _repository;

  ProductDetailsCubit(this._repository)
      : super(const ProductDetailsState.initial());

  /// Load product details by ID along with bookings and monthly summary
  Future<void> loadProductDetails(int productId) async {
    try {
      emit(const ProductDetailsState.loading());

      // Load all data in parallel
      final results = await Future.wait([
        _repository.getProductInfo(productId),
        _repository
            .getProductBookings(productId: productId, page: 1)
            .catchError((e) {
          log('Error loading bookings: $e');
          return null;
        }),
        _repository.getProductGrowthData(productId).catchError((e) {
          log('Error loading monthly summary: $e');
          return <dynamic>[];
        }),
      ]);

      final product = results[0] as ProductModel;
      final bookingsData = results[1] as dynamic;
      final monthlyData = results[2] as List<ProductMonthlyDataModel>;

      emit(ProductDetailsState.loaded(
        product: product,
        bookings: bookingsData?.data ?? [],
        monthlySummary: monthlyData ?? [],
        nextPageUrl: bookingsData?.nextPageUrl,
      ));
    } catch (e) {
      log('Error loading product details: $e');
      emit(ProductDetailsState.error(
        message: 'An error occurred: ${e.toString()}',
      ));
    }
  }

  /// Load more bookings (pagination)
  Future<void> loadMoreBookings(int productId, int page) async {
    state.maybeMap(
      loaded: (loadedState) {
        if (loadedState.isPaginatingBookings ||
            loadedState.nextPageUrl == null) {
          return;
        }

        emit(ProductDetailsState.loaded(
          product: loadedState.product,
          bookings: loadedState.bookings,
          monthlySummary: loadedState.monthlySummary,
          nextPageUrl: loadedState.nextPageUrl,
          isPaginatingBookings: true,
        ));

        // Execute async operation without awaiting in the callback
        _repository
            .getProductBookings(
          productId: productId,
          page: page,
        )
            .then((moreBookings) {
          emit(ProductDetailsState.loaded(
            product: loadedState.product,
            bookings: [...loadedState.bookings, ...moreBookings.data],
            monthlySummary: loadedState.monthlySummary,
            nextPageUrl: moreBookings.nextPageUrl,
            isPaginatingBookings: false,
          ));
        }).catchError((e) {
          log('Error loading more bookings: $e');
          emit(ProductDetailsState.loaded(
            product: loadedState.product,
            bookings: loadedState.bookings,
            monthlySummary: loadedState.monthlySummary,
            nextPageUrl: loadedState.nextPageUrl,
            isPaginatingBookings: false,
          ));
        });
      },
      orElse: () {},
    );
  }

  /// Add a new variant to the product
  Future<void> addProductVariant({
    required int productId,
    required String attribute,
    required int stock,
  }) async {
    try {
      await _repository.addProductVariants(
        productId: productId,
        attribute: attribute,
        stock: stock,
      );
      // Reload product details to show the new variant
      await loadProductDetails(productId);
    } catch (e) {
      log('Error adding product variant: $e');
      rethrow;
    }
  }

  /// Delete a variant from the product
  Future<void> deleteProductVariant(
      {required int productId, required int variantId}) async {
    try {
      await _repository.deleteProduct(
        productId: productId,
        variantId: variantId,
      );
      // Reload product details to refresh the variants list
      await loadProductDetails(productId);
    } catch (e) {
      log('Error deleting product variant: $e');
      rethrow;
    }
  }

  /// Delete the entire product
  Future<void> deleteProduct(int productId) async {
    try {
      await _repository.deleteProduct(productId: productId);
    } catch (e) {
      log('Error deleting product: $e');
      rethrow;
    }
  }
}
