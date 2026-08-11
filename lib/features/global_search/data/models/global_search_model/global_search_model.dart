import 'dart:developer';

import 'package:bookie_buddy_web/features/booking/data/models/desktop_booking_model/desktop_booking_item_model.dart';
import 'package:bookie_buddy_web/features/global_search/domain/entities/global_search_entity/global_search_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_search_model.freezed.dart';

@freezed
abstract class GlobalSearchModel with _$GlobalSearchModel {
  const factory GlobalSearchModel({DesktopBookingItemModel? booking}) =
      _GlobalSearchModel;

  static GlobalSearchModel fromJson(Map<String, dynamic> json) {
    try {
      final booking = DesktopBookingItemModel.fromJson(json);

      // Return model with correct type and data
      return GlobalSearchModel(booking: booking);
    } catch (e, stackTrace) {
      log('Error parsing GlobalSearchModel: $e', stackTrace: stackTrace);
      log('Input JSON: $json');
      rethrow;
    }
  }
}

extension GlobalSearchModelMapper on GlobalSearchModel {
  GlobalSearchEntity toEntity() =>
      GlobalSearchEntity(booking: booking?.toEntity());
}
