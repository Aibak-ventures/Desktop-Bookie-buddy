enum TaxCalculationType {
  inclusive('Inclusive', 'inclusive'),
  exclusive('Exclusive', 'exclusive');

  final String value;
  final String label;

  const TaxCalculationType(this.label, this.value);

  static TaxCalculationType? tryFromJson(String? apiValue) {
    if (apiValue == null || apiValue.isEmpty) return null;
    return TaxCalculationType.values.firstWhere(
      (e) => e.value == apiValue,
      orElse: () => TaxCalculationType.exclusive,
    );
  }

  static TaxCalculationType fromJson(String apiValue) {
    return TaxCalculationType.values.firstWhere(
      (e) => e.value == apiValue,
      orElse: () => TaxCalculationType.exclusive,
    );
  }

  static String toJson(TaxCalculationType type) => type.value;
  static String? tryToJson(TaxCalculationType? type) => type?.value;
}
