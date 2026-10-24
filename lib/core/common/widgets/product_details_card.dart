import 'package:bookie_buddy_shared/core/core/constants/measurement_constants.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurement_rules.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurements_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/person_measurement_widgets.dart';
import 'package:bookie_buddy_web/core/common/widgets/zoomable_image_dialog.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:material_ui/material_ui.dart';

/// A product line as shown in the details screens: photo, name and specs,
/// price and quantity, and the line's measurements (see
/// [ProductMeasurementsSection]).
///
/// It takes plain values rather than an entity so booking and sales details
/// can both use it.
class ProductDetailsCard extends StatelessWidget {
  const ProductDetailsCard({
    required this.name,
    required this.amount,
    required this.quantity,
    this.imageUrl,
    this.zoomImageUrl,
    this.specs = const [],
    this.peopleMeasurements = const [],
    this.badge,
    super.key,
  });

  final String name;

  /// The price, already formatted for display.
  final String amount;
  final int quantity;
  final String? imageUrl;

  /// The larger picture opened when the photo is tapped; defaults to
  /// [imageUrl].
  final String? zoomImageUrl;

  /// Short facts about the variant, e.g. "Size: M" or "Colour: Green".
  final List<String> specs;
  final List<PersonMeasurementsEntity> peopleMeasurements;

  /// Shown above the price, e.g. a returned-status pill.
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ItemImage(
                name: name,
                imageUrl: imageUrl,
                zoomImageUrl: zoomImageUrl ?? imageUrl,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    if (specs.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [for (final s in specs) _SpecChip(s)],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (badge != null) ...[badge!, const SizedBox(height: 6)],
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Qty $quantity',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
          if (peopleMeasurements.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ProductMeasurementsSection(people: peopleMeasurements),
            ),
        ],
      ),
    );
  }
}

class _ItemImage extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String? zoomImageUrl;

  const _ItemImage({
    required this.name,
    required this.imageUrl,
    required this.zoomImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    final hasImage = url != null && url.isNotEmpty;
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: hasImage
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => ZoomableImageDialog.show(
                  context,
                  imageUrl: zoomImageUrl ?? url,
                  title: name,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.image, color: Colors.grey.shade400),
                  ),
                ),
              ),
            )
          : Icon(Icons.image, color: Colors.grey.shade400),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final String text;

  const _SpecChip(this.text);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
    ),
  );
}

/// The running kilometers and the measurements of a product line. One person
/// shows as plain tiles with no name; several show a row each with a Preview
/// button.
class ProductMeasurementsSection extends StatelessWidget {
  final List<PersonMeasurementsEntity> people;

  const ProductMeasurementsSection({required this.people, super.key});

  @override
  Widget build(BuildContext context) {
    final runningKm = people.allValues
        .where((m) => VehicleMeasurementKeys.isRunningKilometers(m.key))
        .firstOrNull;
    // The running kilometers are shown on their own, so it is left out of the people.
    final others = [
      for (final p in people)
        p.copyWith(
          measurements: p.measurements
              .where((m) => !VehicleMeasurementKeys.isRunningKilometers(m.key))
              .toList(),
        ),
    ].withoutEmptyPeople();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (runningKm != null)
          Align(
            alignment: Alignment.centerLeft,
            child: _InfoChip(
              name: VehicleMeasurementKeys.runningKilometersName,
              value: runningKm.value,
              icon: Icons.speed_rounded,
            ),
          ),
        if (runningKm != null && others.isNotEmpty) const SizedBox(height: 10),
        if (others.isNotEmpty) ...[
          Row(
            children: [
              Icon(Icons.straighten, size: 14, color: Colors.grey.shade600),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  'Measurements',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (others.haveMultiple)
            for (final (i, person) in others.indexed)
              _PersonMeasurementsRow(
                name: PersonMeasurementRules.displayName(person.name, i),
                measurements: person.measurements,
              )
          else
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final m in others.single.measurements)
                  _InfoChip(name: m.name, value: m.value),
              ],
            ),
        ],
      ],
    );
  }
}

/// A name and its value on one line, in a small grey chip. Used for every
/// measurement, and for the vehicle's running kilometers (with an [icon]).
class _InfoChip extends StatelessWidget {
  final String name;
  final String value;
  final IconData? icon;

  const _InfoChip({required this.name, required this.value, this.icon});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 6),
        ],
        Flexible(
          child: Text.rich(
            TextSpan(
              text: '$name:  ',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// One of several people on a line: avatar, name and a button that opens
/// their measurements.
class _PersonMeasurementsRow extends StatelessWidget {
  final String name;
  final List<MeasurementValueEntity> measurements;

  const _PersonMeasurementsRow({
    required this.name,
    required this.measurements,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 4, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          PersonAvatar(name: name, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  PersonMeasurementRules.countLabel(measurements.length),
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () => PersonMeasurementsPreview.show(
              context,
              name: name,
              measurements: measurements,
            ),
            style: TextButton.styleFrom(foregroundColor: AppColors.purple),
            icon: const Icon(Icons.visibility_outlined, size: 16),
            label: const Text('Preview', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}
