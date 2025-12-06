import 'package:freezed_annotation/freezed_annotation.dart';

part 'carousel_data_model.freezed.dart';
part 'carousel_data_model.g.dart';

@freezed
class CarouselDataModel with _$CarouselDataModel {
  factory CarouselDataModel({
    @JsonKey(
      name: 'upcoming_count',
      defaultValue: 0,
    )
    required int upComingCount,
    @JsonKey(
      name: 'completed_count',
      defaultValue: 0,
    )
    required int completedCount,
    @JsonKey(
      name: 'expired_count',
      defaultValue: 0,
    )
    required int expiredCount,
  }) = _CarouselDataModel;

  factory CarouselDataModel.fromJson(Map<String, dynamic> json) =>
      _$CarouselDataModelFromJson(json);

  factory CarouselDataModel.initial() => CarouselDataModel(
        upComingCount: 0,
        completedCount: 0,
        expiredCount: 0,
      );
}

// extension CarouselDataModelExtension on CarouselDataModel {
  // int get total => upComingCount + completedCount + expiredCount;

// }