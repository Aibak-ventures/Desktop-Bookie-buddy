import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_shop_model.freezed.dart';
part 'user_shop_model.g.dart';

@freezed
class UserShopModel with _$UserShopModel {
  const factory UserShopModel({
    required int id,
    required String name,
    required String phone,
    String? phone2,
    required String address,
    @JsonKey(name: 'gst_number') String? gstNumber,
    String? image,
    String? place,
    String? email,
    String? city,
    String? state,
    String? pincode,
    @JsonKey(name: 'terms_and_conditions')
    @Default(const [
      'No refund will be given after Booking cancellation.',
      'Any damages must be paid by the customer',
      'Confirm your Pickup and return dates properly.',
      'Make sure all your needs are clear before booking.',
      'Security deposit (if applicable) will be refunded after return.',
      'Products should be returned on the exact return date, without any damages.',
    ])
    List<String> termsAndConditions,
  }) = _UserShopModel;

  factory UserShopModel.fromJson(Map<String, dynamic> json) =>
      _$UserShopModelFromJson(json);
}

extension UserShopModelX on UserShopModel {
  String get fullAddress {
    final parts = <String>[
      address, // street
      if (place != null && place!.trim().isNotEmpty) place!.trim(),
      if (city != null && city!.trim().isNotEmpty) city!.trim(),
      if (state != null && state!.trim().isNotEmpty) state!.trim(),
      if (pincode != null && pincode!.trim().isNotEmpty) pincode!.trim(),
    ];
    return parts.join(', ');
  }
}
