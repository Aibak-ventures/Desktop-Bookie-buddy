import 'package:bookie_buddy_shared/core/features/booking/domain/entities/measurement_value_entity/standard_measurement_fields.dart';
import 'package:bookie_buddy_shared/core/core/constants/enums/gender_type_enums.dart';
import 'package:flutter/material.dart';

class MeasurementFieldFormState {
  final String name;
  final String key;
  final String description;
  final GenderType gender;
  final bool isOptional;
  final TextEditingController controller;

  MeasurementFieldFormState({
    required this.name,
    required this.key,
    required this.description,
    required this.gender,
    this.isOptional = false,
    TextEditingController? controller,
  }) : controller = controller ?? TextEditingController();

  /// A fresh form field, with its own controller, for every standard
  /// measurement (see [StandardMeasurementFields]).
  static List<MeasurementFieldFormState> standardFields() => [
    for (final d in StandardMeasurementFields.all)
      MeasurementFieldFormState(
        name: d.name,
        key: d.key,
        description: d.description,
        gender: d.gender,
      ),
  ];

  MeasurementFieldFormState copyWith({
    String? name,
    String? key,
    String? description,
    GenderType? gender,
    bool? isOptional,
    TextEditingController? controller,
  }) => MeasurementFieldFormState(
    name: name ?? this.name,
    key: key ?? this.key,
    description: description ?? this.description,
    gender: gender ?? this.gender,
    isOptional: isOptional ?? this.isOptional,
    controller: controller ?? this.controller,
  );
}
