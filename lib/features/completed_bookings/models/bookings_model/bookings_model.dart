import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookings_model.freezed.dart';
part 'bookings_model.g.dart';

@freezed
class BookingsModel with _$BookingsModel {
  const factory BookingsModel({
    required int id,
    required String customerName,
    required String customerPhone,
    required String bookingDate,
    required String bookingTime,
    required String serviceName,
    required double totalAmount,
    required String status,
    required String createdAt,
    required String updatedAt,
  }) = _BookingsModel;

  factory BookingsModel.fromJson(Map<String, dynamic> json) =>
      _$BookingsModelFromJson(json);
}

@freezed
class BookingsResponse with _$BookingsResponse {
  const factory BookingsResponse({
    required List<BookingsModel> data,
    required Map<String, dynamic> pagination,
  }) = _BookingsResponse;

  factory BookingsResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingsResponseFromJson(json);
}
