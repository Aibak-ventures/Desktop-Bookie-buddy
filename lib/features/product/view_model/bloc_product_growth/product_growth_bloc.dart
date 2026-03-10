import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/features/product/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_growth_event.dart';
part 'product_growth_state.dart';
part 'product_growth_bloc.freezed.dart';

class ProductGrowthBloc extends Bloc<ProductGrowthEvent, ProductGrowthState> {
  final ProductRepository _repository = getIt.get<ProductRepository>();
  ProductGrowthBloc() : super(const _Loading()) {
    on<_LoadProductGrowthData>(_onLoadProductGrowth);
  }

  Future<void> _onLoadProductGrowth(
      _LoadProductGrowthData event, Emitter<ProductGrowthState> emit) async {
    emit(const _Loading());
    try {
      final result = await _repository.getProductGrowthData(event.productId);
      emit(_Loaded(result));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
