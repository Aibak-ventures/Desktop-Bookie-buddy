import 'package:bookie_buddy_web/core/constants/enums/gender_type_enums.dart';
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
