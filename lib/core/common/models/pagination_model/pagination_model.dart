import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_model.freezed.dart';

@freezed
abstract class PaginationModel<T> with _$PaginationModel<T> {
  const factory PaginationModel({
    required List<T> data,
    String? nextPageUrl,
    String? previousPageUrl,
    @Default(0) int totalData,
    @Default(0) int pageSize,
    @Default(1) int currentPage,
    @Default(0) int totalPages,
    @Default(0) int startIndex,
    @Default(0) int endIndex,
  }) = _PaginationModel<T>;

  /// JSON factory with generic type parsing
  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) itemFromJson, {
    List<T> Function(List<T> data)? listFromJson,
    List<T> Function(
      dynamic dataJson,
      T Function(Object? json) itemFromJson,
    )? customJsonParser,
  }) {
    final result = customJsonParser != null
        ? customJsonParser(json['data'], itemFromJson)
        : (json['data'] as List<dynamic>?)
                ?.map((item) => itemFromJson(item))
                .toList() ??
            <T>[];

    return PaginationModel<T>(
      data: listFromJson != null ? listFromJson(result) : result,
      totalData: json['count'] as int? ?? 0,
      nextPageUrl: json['next'] as String?,
      previousPageUrl: json['previous'] as String?,
      currentPage: json['current_page'] as int? ?? 1,
      totalPages: json['total_pages'] as int? ?? 1,
      startIndex: json['start_index'] as int? ?? 0,
      endIndex: json['end_index'] as int? ?? 0,
      pageSize: json['page_size'] as int? ?? 0,
    );
  }

  /// Extracts the page number from a pagination URL.
  ///
  /// If the URL is null, does not contain a 'page' query parameter, or if parsing fails,
  /// this method will return `1` as the default page number.
  static int getPageFromUrl(String? url) {
    final uri = Uri.tryParse(url ?? '');
    return int.tryParse(uri?.queryParameters['page'] ?? '1') ?? 1;
  }
}
