import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_response_model.freezed.dart';
part 'custom_response_model.g.dart';

@freezed
class CustomResponseModel with _$CustomResponseModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CustomResponseModel({
    @JsonKey(
      name: 'status',
      fromJson: CustomResponseStatus.fromString,
      toJson: CustomResponseStatus.toJson,
    )
    required CustomResponseStatus status,
    required String message,
    @JsonKey(name: 'dev_message', defaultValue: '') required dynamic devMessage,
    @JsonKey(name: 'meta', includeIfNull: false) required dynamic meta,
    required dynamic data,
  }) = _CustomResponseModel;

  factory CustomResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CustomResponseModelFromJson(json);
}

/// Enum representing the status of a custom response
///
/// eg. success, error, failed, noContent
enum CustomResponseStatus {
  success,
  error,
  failed,
  noContent,
  validationError,
  permissionDenied,
  notFound,
  insufficientStock;

  String get apiName {
    // Convert enum's built-in name (camelCase) to snake_case
    final regex = RegExp(r'(?<=[a-z])[A-Z]');
    return name.replaceAllMapped(regex, (m) => '_${m.group(0)!.toLowerCase()}');
  }

  // String get name {
  //   switch (this) {
  //     case CustomResponseStatus.success:
  //       return 'success';
  //     case CustomResponseStatus.error:
  //       return 'error';
  //     case CustomResponseStatus.failed:
  //       return 'failed';
  //     case CustomResponseStatus.noContent:
  //       return 'no_content';
  //     case CustomResponseStatus.validationError:
  //       return 'validation_error';
  //     case CustomResponseStatus.permissionDenied:
  //       return 'permission_denied';
  //     case CustomResponseStatus.notFound:
  //       return 'not_found';
  //     case CustomResponseStatus.insufficientStock:
  //       return 'insufficient_stock';
  //   }
  // }

  static CustomResponseStatus fromString(String status) =>
      CustomResponseStatus.values.firstWhere(
        (e) => e.apiName == status.toLowerCase(),
        orElse: () => CustomResponseStatus.error,
      );

  static String toJson(CustomResponseStatus status) => status.apiName;

  bool get isSuccess => this == CustomResponseStatus.success;
  bool get isError => this == CustomResponseStatus.error;
  bool get isFailed => this == CustomResponseStatus.failed;
  bool get isNoContent => this == CustomResponseStatus.noContent;
  bool get isValidationError => this == CustomResponseStatus.validationError;
  bool get isPermissionDenied => this == CustomResponseStatus.permissionDenied;
  bool get isNotFound => this == CustomResponseStatus.notFound;
  bool get isInsufficientStock =>
      this == CustomResponseStatus.insufficientStock;
}
