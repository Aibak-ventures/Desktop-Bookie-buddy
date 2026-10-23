import 'package:bookie_buddy_shared/core/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurement_rules.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

/// Round badge with the first letter of a person's name.
class PersonAvatar extends StatelessWidget {
  const PersonAvatar({required this.name, this.size = 40, super.key});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: AppColors.purpleLight,
      shape: BoxShape.circle,
    ),
    child: Text(
      name.trim().isEmpty ? '?' : name.trim().getInitialLetters,
      style: TextStyle(
        fontSize: size * 0.42,
        fontWeight: FontWeight.w700,
        color: AppColors.purple,
      ),
    ),
  );
}

/// Plain key/value list of one set of measurements.
class MeasurementKeyValueList extends StatelessWidget {
  const MeasurementKeyValueList(this.measurements, {super.key});

  final List<MeasurementValueEntity> measurements;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (final e in measurements)
        Row(
          children: [
            Expanded(
              child: Text(
                e.name,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            const Text(':  '),
            Expanded(child: Text(e.value)),
          ],
        ),
    ],
  );
}

class PersonMeasurementsPreview {
  const PersonMeasurementsPreview._();

  /// Opens a dialog with one person's measurements.
  static Future<void> show(
    BuildContext context, {
    required String name,
    required List<MeasurementValueEntity> measurements,
  }) => showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 560),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PersonAvatar(name: name, size: 44),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          PersonMeasurementRules.countLabel(
                            measurements.length,
                          ),
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.grey600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: 12.radiusBorder,
                      border: Border.all(color: AppColors.grey400),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: Column(
                      children: [
                        for (final (i, e) in measurements.indexed) ...[
                          if (i > 0)
                            const Divider(
                              height: 1,
                              color: AppColors.purpleLight,
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    e.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  e.value,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
