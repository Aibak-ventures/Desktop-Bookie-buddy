import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/core/repositories/shop_repository.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_list_event.dart';
part 'shop_list_state.dart';
part 'shop_list_bloc.freezed.dart';

class ShopListBloc extends Bloc<ShopListEvent, ShopListState> {
  final ShopRepository _repository = getIt.get<ShopRepository>();
  ShopListBloc() : super(const _Loading()) {
    on<_LoadShops>((event, emit) async {
      if (state is! _Loading) emit(const _Loading());
      // emit(_Error('fetch data failed'));
      // return
      try {
        final shops = await _repository.getShops();
        final currentShopId = SharedPreferenceHelper.getShopId;
        emit(
          ShopListState.loaded(
            shops: shops,
            currentShopId: currentShopId,
          ),
        );
      } catch (e, stack) {
        log(e.toString(), stackTrace: stack);
        emit(ShopListState.error(e.toString()));
      }
    });

    on<_ChangeAccount>((event, emit) async {
      try {
        await SharedPreferenceHelper.setShopId(event.newShop.id);
        emit(ShopListState.changeSuccess(event.newShop));
      } catch (e) {
        emit(ShopListState.error(e.toString()));
      }
    });
  }
}
