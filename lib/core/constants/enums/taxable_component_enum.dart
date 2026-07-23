enum TaxableComponent {
  productTotal('Product Total', 'product_total'),
  additionalCharges('Additional Charges', 'additional_charges');
  // securityAmount('Security Amount', 'security_amount');

  final String value;
  final String label;

  const TaxableComponent(this.label, this.value);

  /// Components a discount is allowed to reduce before tax — the billable
  /// product/service charge, never the (refundable) security deposit.
  static List<TaxableComponent> get discountableComponents => const [
    productTotal,
    additionalCharges,
  ];

  // single
  static TaxableComponent? tryFromJson(String? apiValue) {
    if (apiValue == null || apiValue.isEmpty) return null;
    return TaxableComponent.values.firstWhere(
      (e) => e.value == apiValue,
      orElse: () => TaxableComponent.productTotal,
    );
  }

  static TaxableComponent fromJson(String apiValue) {
    return TaxableComponent.values.firstWhere(
      (e) => e.value == apiValue,
      orElse: () => TaxableComponent.productTotal,
    );
  }

  static String toJson(TaxableComponent component) => component.value;
  static String? tryToJson(TaxableComponent? component) => component?.value;

  // List
  static List<TaxableComponent> fromJsonList(List<dynamic> apiValues) {
    return apiValues
        .map((e) => TaxableComponent.fromJson(e as String))
        .toList();
  }

  static List<TaxableComponent>? tryFromJsonList(List<dynamic>? apiValues) {
    if (apiValues == null) return null;
    return apiValues
        .map((e) => TaxableComponent.fromJson(e as String))
        .toList();
  }

  static List<String> toJsonList(List<TaxableComponent> components) =>
      components.map((e) => e.value).toList();
  static List<String>? tryToJsonList(List<TaxableComponent>? components) =>
      components?.map((e) => e.value).toList();
}
