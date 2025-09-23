import 'package:flutter/foundation.dart';

class PaginationModel<T> {
  final List<T> data;
  final int totalData;
  final String? nextPageUrl;

  PaginationModel({
    required this.data,
    required this.totalData,
    required this.nextPageUrl,
  });

  static int getPageFromUrl(String? url) {
    final uri = Uri.tryParse(url ?? '');
    return int.tryParse(uri?.queryParameters['page'] ?? '1') ?? 1;
  }

  PaginationModel<T> copyWith({
    List<T>? data,
    int? totalData,
    String? nextPageUrl,
  }) {
    return PaginationModel<T>(
      data: data ?? this.data,
      totalData: totalData ?? this.totalData,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    );
  }

  @override
  String toString() =>
      'PaginationModel(data: $data, totalData: $totalData, nextPageUrl: $nextPageUrl)';

  @override
  bool operator ==(covariant PaginationModel<T> other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data) &&
        other.totalData == totalData &&
        other.nextPageUrl == nextPageUrl;
  }

  @override
  int get hashCode => data.hashCode ^ totalData.hashCode ^ nextPageUrl.hashCode;
}
