import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_other_details_model.freezed.dart';
part 'booking_other_details_model.g.dart';

@freezed
class BookingOtherDetailsModel with _$BookingOtherDetailsModel {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
    includeIfNull: false,
    createToJson: true,
  )
  const factory BookingOtherDetailsModel({
    @JsonKey(name: 'location_start') String? locationStart,
    @JsonKey(name: 'location_from') String? locationFrom,
    @JsonKey(name: 'location_to') String? locationTo,
    @JsonKey(name: 'end') String? end,
  }) = _BookingOtherDetailsModel;

  factory BookingOtherDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BookingOtherDetailsModelFromJson(json);

  static BookingOtherDetailsModel empty() => const BookingOtherDetailsModel();
}
