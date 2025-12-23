import 'package:bookie_buddy_web/features/profile/models/shop_activity_model/shop_activity_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_activity_list_model.freezed.dart';
part 'shop_activity_list_model.g.dart';

@freezed
class ShopActivityListModel with _$ShopActivityListModel {
  const factory ShopActivityListModel({
    required List<ShopActivityModel> activities,
    @JsonKey(name: 'next') String? nextPageUrl,
    int? count,
  }) = _ShopActivityListModel;

  factory ShopActivityListModel.fromJson(Map<String, dynamic> json) =>
      _$ShopActivityListModelFromJson(json);
}
