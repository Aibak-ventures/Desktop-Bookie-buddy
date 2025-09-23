import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/features/product/models/product_request_model/product_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_product_state.dart';
part 'save_product_cubit.freezed.dart';

class SaveProductCubit extends Cubit<SaveProductState> {
  final ProductRepository _repository = getIt.get<ProductRepository>();

  SaveProductCubit() : super(const _Initial());

  Future<void> saveProduct({
    required ProductRequestModel product,
  }) async {
    emit(const _Submitted());
    try {
      await _repository.saveProduct(
        product: product,
      );

      emit(const _Success());
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      emit(_Error(e.toString()));
    }
  }
}
