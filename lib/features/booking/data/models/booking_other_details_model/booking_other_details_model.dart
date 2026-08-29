import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_core/features/booking/domain/entities/booking_other_details_entity/booking_other_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_other_details_model.freezed.dart';
part 'booking_other_details_model.g.dart';

@freezed
abstract class BookingOtherDetailsModel with _$BookingOtherDetailsModel {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
    includeIfNull: false,
    createToJson: true,
  )
  const factory BookingOtherDetailsModel({
    @JsonKey(name: 'location_start') String? locationStart,
    @JsonKey(name: 'location_from') String? locationFrom,
    @JsonKey(name: 'location_to') String? locationTo,
    // Vehicle odometer reading — read/display only, never submitted back
    // through this model. See BookingOtherDetailsEntity.runningKilometers
    // (bookie_buddy_core) for the full explanation: the value the user
    // enters is submitted per-product instead (running_kilometers inside
    // each variant's measurements), not via this field, on either the
    // new-booking or edit path.
    @JsonKey(name: 'end') String? end,
    @JsonKey(
      name: 'cooling_period_type',
      fromJson: CoolingPeriodMode.tryFromJson,
      toJson: CoolingPeriodMode.tryToJson,
    )
    CoolingPeriodMode? coolingPeriodType,
    @JsonKey(name: 'total_product_count') int? totalProductCount,
  }) = _BookingOtherDetailsModel;

  factory BookingOtherDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BookingOtherDetailsModelFromJson(json);

  static BookingOtherDetailsModel empty() => const BookingOtherDetailsModel();
}

extension BookingOtherDetailsModelMapper on BookingOtherDetailsModel {
  // coolingPeriodType is NOT on the shared BookingOtherDetailsEntity (see
  // that file) — BookingRequestEntity already carries its own top-level
  // coolingPeriodType, unaffected by this. `end` (a vehicle odometer
  // reading, unclear legacy JSON key) maps to the entity's clearer
  // runningKilometers name.
  BookingOtherDetailsEntity toEntity() => BookingOtherDetailsEntity(
    locationStart: locationStart,
    locationFrom: locationFrom,
    locationTo: locationTo,
    runningKilometers: end,
    totalProductCount: totalProductCount,
  );
}

extension BookingOtherDetailsEntityMapper on BookingOtherDetailsEntity {
  BookingOtherDetailsModel toModel() => BookingOtherDetailsModel(
    locationStart: locationStart,
    locationFrom: locationFrom,
    locationTo: locationTo,
    end: runningKilometers,
    totalProductCount: totalProductCount,
  );
}
