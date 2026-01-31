import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_shop_model.freezed.dart';
part 'available_shop_model.g.dart';

@freezed
class AvailableShopModel with _$AvailableShopModel {
  const factory AvailableShopModel({
    required int id,
    required String name,
    String? place,
    String? phone,
    String? email,
    required String address,
    @JsonKey(name: 'gst_number') String? gstNumber,
    String? city,
    String? state,
    String? pincode,
    @JsonKey(name: 'subscription_status') String? subscriptionStatus,
    @JsonKey(name: 'subscribed_date') String? subscribedDate,
    @JsonKey(name: 'renewal_due_date') String? renewalDueDate,
    String? img,
  }) = _AvailableShopModel;

  factory AvailableShopModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableShopModelFromJson(json);
}
