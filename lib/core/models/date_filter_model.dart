class DateFilterModel {
  final DateTime? startDate;
  final DateTime? endDate;

  const DateFilterModel({this.startDate, this.endDate});

  bool get hasActiveFilter => startDate != null || endDate != null;

  DateFilterModel copyWith({DateTime? startDate, DateTime? endDate}) => DateFilterModel(
      startDate: startDate,
      endDate: endDate,
    );

  DateFilterModel clear() => const DateFilterModel();
}
