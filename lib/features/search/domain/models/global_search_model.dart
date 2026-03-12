import 'dart:developer';

import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/core/routing/app_routes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_search_model.freezed.dart';

@freezed
class GlobalSearchModel with _$GlobalSearchModel {
  const factory GlobalSearchModel({
    BookingsModel? booking,
    SaleModel? sale,
    @JsonKey(
      name: 'type',
      fromJson: GlobalSearchType.fromJson,
      toJson: GlobalSearchType.toJson,
    )
    required GlobalSearchType type,
  }) = _GlobalSearchModel;

  static GlobalSearchModel fromJson(Map<String, dynamic> json) {
    try {
      final typeRaw = json['type'];

      if (typeRaw is! String || typeRaw.isEmpty) {
        throw 'type is empty or invalid';
      }

      final type = GlobalSearchType.fromJson(typeRaw);

      BookingsModel? booking;
      SaleModel? sale;

      switch (type) {
        case GlobalSearchType.booking:
          booking = BookingsModel.fromJson(json);
          break;
        case GlobalSearchType.sale:
          sale = SaleModel.fromJson(json);
          break;
      }

      return GlobalSearchModel(
        type: type,
        booking: booking,
        sale: sale,
      );
    } catch (e, stackTrace) {
      log('Error parsing GlobalSearchModel: $e', stackTrace: stackTrace);
      return const GlobalSearchModel(type: GlobalSearchType.booking);
    }
  }
}

enum GlobalSearchType {
  booking('booking'),
  sale('sale');

  final String value;
  const GlobalSearchType(this.value);

  String get navigationRoute {
    switch (this) {
      case GlobalSearchType.booking:
        return AppRoutes.bookingDetails.name;
      case GlobalSearchType.sale:
        return AppRoutes.saleDetails.name;
    }
  }

  static GlobalSearchType fromJson(String? value) {
    if (value == null || value.isEmpty) {
      return GlobalSearchType.booking;
    }
    return GlobalSearchType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => GlobalSearchType.booking,
    );
  }

  static String toJson(GlobalSearchType type) => type.value;

  bool get isBooking => this == GlobalSearchType.booking;
  bool get isSale => this == GlobalSearchType.sale;
}
