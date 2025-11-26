// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookie_buddy_web/core/enums/availability_status_enums.dart';

class CheckAvailabilityModel {
  final CheckAvailabilityStatus status;
  final List<UnavailableProduct> unavailableProducts;

  CheckAvailabilityModel({
    required this.status,
    required this.unavailableProducts,
  });

  factory CheckAvailabilityModel.fromMap(Map<String, dynamic> map) =>
      CheckAvailabilityModel(
        status: CheckAvailabilityStatus.fromString(map['status']),
        unavailableProducts: List<UnavailableProduct>.from(
          (map['unavailable_products'] as List).map<UnavailableProduct>(
            (x) => UnavailableProduct.fromMap(x as Map<String, dynamic>),
          ),
        ),
      );
}

class UnavailableProduct {
  final int id;
  final String name;
  final String image;
  final List<String> unavailableDates;

  UnavailableProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.unavailableDates,
  });

  factory UnavailableProduct.fromMap(Map<String, dynamic> map) =>
      UnavailableProduct(
        id: map['id'] as int,
        name: map['name'] as String,
        image: map['image'] as String,
        unavailableDates: List<String>.from(map['unavailable_dates'] as List),
      );

  factory UnavailableProduct.fromJson(String source) =>
      UnavailableProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UnavailableProduct(id: $id, name: $name, image: $image, unavailableDates: $unavailableDates)';
}
