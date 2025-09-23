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
  }) = _CarouselDataModel;

  factory CarouselDataModel.fromJson(Map<String, dynamic> json) =>
      _$CarouselDataModelFromJson(json);
}

// class CarouselDataModel {
//   final int? upComingCount;
//   final int? completedCount;

//   CarouselDataModel({
//     required this.upComingCount,
//     required this.completedCount,
//   });

//   factory CarouselDataModel.fromJson(Map<String, dynamic> json) {
//     return CarouselDataModel(
//       upComingCount: json['upcoming_count'],
//       completedCount: json['completed_count'],
//     );
//   }

//   @override
//   bool operator ==(covariant CarouselDataModel other) {
//     if (identical(this, other)) return true;

//     return other.upComingCount == upComingCount &&
//         other.completedCount == completedCount;
//   }

//   @override
//   int get hashCode => upComingCount.hashCode ^ completedCount.hashCode;

//   @override
//   String toString() =>
//       'CarouselResponseModel(upComingCount: $upComingCount, completedCount: $completedCount)';
// }
