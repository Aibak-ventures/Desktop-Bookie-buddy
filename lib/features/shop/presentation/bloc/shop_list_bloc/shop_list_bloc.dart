import 'dart:developer';

import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';
import 'package:bookie_buddy_web/features/shop/domain/usecases/get_shops_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_list_bloc.freezed.dart';
part 'shop_list_event.dart';
part 'shop_list_state.dart';

class ShopListBloc extends Bloc<ShopListEvent, ShopListState> {
  final GetShopsUseCase _getShops;
  final IUserRepository _userRepo;

  ShopListBloc({
    required GetShopsUseCase getShops,
    required IUserRepository userRepo,
  })  : _getShops = getShops,
        _userRepo = userRepo,
        super(const ShopListState.loading()) {
    on<_LoadShops>((event, emit) async {
      if (state is! _Loading) emit(const ShopListState.loading());

      try {
        final shops = await _getShops();
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
