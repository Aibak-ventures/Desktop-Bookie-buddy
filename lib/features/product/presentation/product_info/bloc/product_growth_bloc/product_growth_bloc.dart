import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_product_growth_data_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_growth_event.dart';
part 'product_growth_state.dart';
part 'product_growth_bloc.freezed.dart';

class ProductGrowthBloc extends Bloc<ProductGrowthEvent, ProductGrowthState> {
  final GetProductGrowthDataUseCase _getProductGrowthData;

  ProductGrowthBloc({required GetProductGrowthDataUseCase getProductGrowthData})
      : _getProductGrowthData = getProductGrowthData,
        super(const _Loading()) {
    on<_LoadProductGrowthData>(_onLoadProductGrowth);
  }

  Future<void> _onLoadProductGrowth(
      _LoadProductGrowthData event, Emitter<ProductGrowthState> emit) async {
    emit(const _Loading());
    try {
      final result = await _getProductGrowthData(event.productId);
      emit(_Loaded(result));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
