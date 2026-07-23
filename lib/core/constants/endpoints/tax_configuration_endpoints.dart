import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class TaxConfigurationEndpoints {
  const TaxConfigurationEndpoints();

  static const _root = '${ApiConfig.v3}/shop/shop-tax-configuration/';

  final String taxConfigurations = _root;
  String taxConfigurationById(int id) => '$_root$id/';
}
