import 'dart:developer';

import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/core/repositories/shop_repository.dart';
import 'package:bookie_buddy_web/core/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_list_event.dart';
part 'shop_list_state.dart';
part 'shop_list_bloc.freezed.dart';

class ShopListBloc extends Bloc<ShopListEvent, ShopListState> {
  final ShopRepository _shopRepo;
  final UserRepository _userRepo;
  ShopListBloc({
    required ShopRepository shopRepo,
    required UserRepository userRepo,
  })  : _shopRepo = shopRepo,
        _userRepo = userRepo,
        super(const ShopListState.loading()) {
    on<_LoadShops>((event, emit) async {
      if (state is! _Loading) emit(const ShopListState.loading());

      try {
        final shops = await _shopRepo.getShops();
        final currentShopId = _userRepo.getShopId;
        emit(ShopListState.loaded(shops: shops, currentShopId: currentShopId));
      } catch (e, stack) {
        log(e.toString(), stackTrace: stack);
        emit(ShopListState.error(e.toString()));
      }
    });

    on<_ChangeAccount>((event, emit) async {
      try {
        await _userRepo.setShopId(event.newShop.id);
        emit(ShopListState.changeSuccess(event.newShop));
      } catch (e) {
        emit(ShopListState.error(e.toString()));
      }
    });
  }
}
