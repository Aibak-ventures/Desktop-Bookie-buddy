import 'package:bookie_buddy_shared/core/core/constants/measurement_constants.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurements_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';

/// The people dropped from one product line because its quantity is lower
/// than the number of people.
typedef RemovedPeople = ({String product, List<String> names});

/// The selected lines once their measurements fit their quantity, and who
/// had to be dropped to get there.
class FittedSelection {
  const FittedSelection({required this.lines, required this.removals});

  final List<ProductSelectedEntity> lines;
  final List<RemovedPeople> removals;

  /// What to tell the user, or `null` when nobody was removed. Names the
  /// product, as several lines can lose people at once:
  /// "Dress (M): John, Mary; Gown: Priya".
  String? get removalMessage {
    if (removals.isEmpty) return null;
    final detail = removals
        .map((r) => '${r.product}: ${r.names.join(', ')}')
        .join('; ');
    return 'The quantity is lower than the number of people, so these '
        'measurements were removed. $detail';
  }
}

extension FitMeasurementsToQuantityX on List<ProductSelectedEntity> {
  /// A line holds one person per unit, so a line whose quantity is lower than
  /// its number of people loses the trailing ones.
  ///
  /// This is meant to run when the user moves on from the product list (to
  /// the measurements, or to saving), not on every quantity change: until
  /// then a quantity that was lowered and raised again should get everyone
  /// back.
  FittedSelection fitMeasurementsToQuantity() {
    final removals = <RemovedPeople>[];
    final lines = <ProductSelectedEntity>[];
    for (final line in this) {
      if (line.peopleMeasurements.length <= line.quantity) {
        lines.add(line);
        continue;
      }
      removals.add((
        product: _productLabel(line),
        names: _namesBeyond(line.peopleMeasurements, line.quantity),
      ));
      lines.add(
        line.copyWith(
          peopleMeasurements: line.peopleMeasurements.limitedTo(line.quantity),
        ),
      );
    }
    return FittedSelection(lines: lines, removals: removals);
  }
}

/// "Dress (M)", or just "Dress" when the variant has no attribute.
String _productLabel(ProductSelectedEntity line) {
  final attribute = line.variant.variantAttribute?.trim() ?? '';
  return attribute.isEmpty
      ? line.variant.name
      : '${line.variant.name} ($attribute)';
}

List<String> _namesBeyond(List<PersonMeasurementsEntity> people, int count) => [
  for (final (i, person) in people.indexed)
    if (i >= count)
      person.name.trim().isNotEmpty
          ? person.name.trim()
          : MeasurementConstants.personNameAt(i),
];
