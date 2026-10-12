import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurement_rules.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurements_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/person_measurement_widgets.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Lists the people a product line has measurements for (one per unit, up to
/// [maxPeople]) and lets each be edited, added or removed.
class PersonMeasurementsPanel extends StatelessWidget {
  const PersonMeasurementsPanel({
    required this.people,
    required this.maxPeople,
    required this.onEdit,
    required this.onAdd,
    required this.onDelete,
    super.key,
  });

  final List<PersonMeasurementsEntity> people;

  /// The line's quantity: at most one person per unit.
  final int maxPeople;
  final ValueChanged<int> onEdit;
  final VoidCallback onAdd;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    final capacity = PersonMeasurementRules.capacity(people.length, maxPeople);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PeopleCapacityHeader(count: people.length, max: capacity),
          const SizedBox(height: 16),
          for (final (i, person) in people.indexed)
            PersonCard(
              name: PersonMeasurementRules.displayName(person.name, i),
              measurementCount: person.measurements.length,
              onTap: () => onEdit(i),
              onDelete: people.length > 1 ? () => onDelete(i) : null,
            ),
          if (people.length < capacity)
            OutlinedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.person_add_alt_1_outlined),
              label: const Text('Add person'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.purple,
                side: const BorderSide(color: AppColors.purple),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          else
            Center(
              child: Text(
                'All $capacity units have a person',
                style: TextStyle(fontSize: 13, color: AppColors.grey600),
              ),
            ),
          const SizedBox(height: 12),
          Text(
            'Each person gets their own set of measurements. '
            'People without any measurement are not saved.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.grey600),
          ),
        ],
      ),
    );
  }
}

/// "2 of 5" with a progress bar.
class PeopleCapacityHeader extends StatelessWidget {
  const PeopleCapacityHeader({
    required this.count,
    required this.max,
    super.key,
  });

  final int count;
  final int max;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.purpleLightShade,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'People',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              '$count of $max',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.purple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: max == 0 ? 0 : count / max,
            minHeight: 6,
            backgroundColor: Colors.white,
            color: AppColors.purple,
          ),
        ),
      ],
    ),
  );
}

class PersonCard extends StatelessWidget {
  const PersonCard({
    required this.name,
    required this.measurementCount,
    required this.onTap,
    this.onDelete,
    super.key,
  });

  final String name;
  final int measurementCount;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
          child: Row(
            children: [
              PersonAvatar(name: name),
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
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      measurementCount == 0
                          ? 'No measurements yet'
                          : PersonMeasurementRules.countLabel(measurementCount),
                      style: TextStyle(
                        fontSize: 12,
                        color: measurementCount == 0
                            ? AppColors.orangeVivid
                            : AppColors.grey600,
                      ),
                    ),
                  ],
                ),
              ),
              if (onDelete != null)
                IconButton(
                  tooltip: 'Remove',
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.redTomato,
                  ),
                  onPressed: onDelete,
                ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    ),
  );
}
