import 'package:bookie_buddy_shared/core/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurements_entity.dart';
import 'package:bookie_buddy_shared/core/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/selected_products_manager.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/selected_products_cubit/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/utils/fit_measurements_to_quantity.dart';
import 'package:flutter_test/flutter_test.dart';

ProductInfoEntity _variant(int id, int quantity) => ProductInfoEntity(
  id: id,
  variantId: id,
  productId: 1,
  name: 'Dress',
  thumbnailImage: null,
  quantity: quantity,
  fabricLength: 0,
  amount: 100,
  stock: 99,
  remainingStock: 99,
);

PersonMeasurementsEntity _person(String name) => PersonMeasurementsEntity(
  name: name,
  measurements: [
    const MeasurementValueEntity(name: 'Chest', key: 'chest', value: '30'),
  ],
);

ProductSelectedEntity _line(int id, int quantity, List<String> people) =>
    ProductSelectedEntity(
      variant: _variant(id, quantity),
      amount: 100,
      quantity: quantity,
      peopleMeasurements: people.map(_person).toList(),
    );

List<ProductSelectedEntity> _lines(SelectedProductsCubit c) =>
    c.state.map(selected: (s) => s.selectedProductsWithAmount);

List<String> _names(ProductSelectedEntity l) =>
    l.peopleMeasurements.map((p) => p.name).toList();

void main() {
  group('re-selecting a variant (changing its quantity)', () {
    late SelectedProductsCubit cubit;

    setUp(() => cubit = SelectedProductsCubit());
    tearDown(() => cubit.close());

    void reselect(int id, int quantity) =>
        cubit.addSelectedProduct(_variant(id, quantity), 100, quantity);

    List<String> peopleOf(int id) =>
        _names(_lines(cubit).firstWhere((l) => l.variant.variantId == id));

    test('increasing the quantity keeps every person', () {
      cubit.loadPreSelected([
        _line(1, 2, ['Afnan', 'John']),
      ]);

      reselect(1, 5);

      expect(peopleOf(1), ['Afnan', 'John']);
      expect(_lines(cubit).single.quantity, 5);
    });

    test('decreasing the quantity keeps everyone until the user moves on', () {
      cubit.loadPreSelected([
        _line(1, 4, ['A', 'B', 'C', 'D']),
      ]);

      reselect(1, 2);

      expect(peopleOf(1), ['A', 'B', 'C', 'D']);
    });

    test('lowering then raising the quantity again loses nobody', () {
      cubit.loadPreSelected([
        _line(1, 4, ['A', 'B', 'C', 'D']),
      ]);

      reselect(1, 1);
      reselect(1, 4);

      expect(peopleOf(1), ['A', 'B', 'C', 'D']);
    });

    test('other lines are left alone', () {
      cubit.loadPreSelected([
        _line(1, 3, ['A', 'B']),
        _line(2, 3, ['X', 'Y']),
      ]);

      reselect(1, 1);

      expect(peopleOf(1), ['A', 'B']);
      expect(peopleOf(2), ['X', 'Y']);
    });

    test('a product that was not selected before starts without people', () {
      reselect(7, 3);

      expect(peopleOf(7), isEmpty);
    });
  });

  group('changing a quantity in the booking form', () {
    test('increment, decrement and set keep the people as they are', () {
      final line = _line(1, 3, ['A', 'B', 'C']);

      final dec = SelectedProductsManager.decrementQuantity(
        currentProducts: [line],
        product: line,
      );
      expect(dec.single.quantity, 2);
      expect(_names(dec.single), ['A', 'B', 'C']);

      final set = SelectedProductsManager.setQuantity(
        currentProducts: dec,
        product: dec.single,
        quantity: 1,
        bookingType: BookingType.booking,
      );
      expect(set.products.single.quantity, 1);
      expect(_names(set.products.single), ['A', 'B', 'C']);

      final inc = SelectedProductsManager.incrementQuantity(
        currentProducts: set.products,
        product: set.products.single,
        bookingType: BookingType.booking,
      );
      expect(inc.single.quantity, 2);
      expect(_names(inc.single), ['A', 'B', 'C']);
    });

    test('saving measurements replaces only the people of that line', () {
      final a = _line(1, 2, ['A']);
      final b = _line(2, 2, ['X']);

      final updated = SelectedProductsManager.updateMeasurements(
        currentProducts: [a, b],
        updatedProduct: a,
        peopleMeasurements: [_person('A'), _person('B')],
      );

      expect(_names(updated[0]), ['A', 'B']);
      expect(updated[1], b);
    });
  });

  group('fitMeasurementsToQuantity (run when the user moves on)', () {
    test('drops the trailing people of a line whose quantity shrank', () {
      final fitted = [
        _line(1, 2, ['A', 'B', 'C', 'D']),
      ].fitMeasurementsToQuantity();

      expect(_names(fitted.lines.single), ['A', 'B']);
      expect(fitted.removals.single.names, ['C', 'D']);
    });

    test('leaves lines that still fit untouched and reports nobody', () {
      final lines = [
        _line(1, 3, ['A', 'B']),
        _line(2, 2, ['X', 'Y']),
      ];

      final fitted = lines.fitMeasurementsToQuantity();

      expect(fitted.lines, lines);
      expect(fitted.removals, isEmpty);
      expect(fitted.removalMessage, isNull);
    });

    test(
      'lines without any people are never touched, whatever the quantity',
      () {
        final lines = [_line(1, 0, []), _line(2, 1, []), _line(3, 9, [])];

        final fitted = lines.fitMeasurementsToQuantity();

        expect(fitted.lines, lines);
        expect(fitted.removals, isEmpty);
      },
    );

    test('names unnamed people by position', () {
      final fitted = [
        _line(1, 1, ['A', '', 'Mary']),
      ].fitMeasurementsToQuantity();

      expect(fitted.removals.single.names, ['Person 2', 'Mary']);
    });

    test('says which product lost whom, with the variant when it has one', () {
      final sized = _line(1, 1, ['A', 'John', 'Mary']);
      final fitted = [
        sized.copyWith(variant: sized.variant.copyWith(variantAttribute: 'M')),
        _line(2, 5, ['X']),
        _line(3, 1, [
          'P',
          'Priya',
        ]).copyWith(variant: _variant(3, 1).copyWith(name: 'Gown')),
      ].fitMeasurementsToQuantity();

      expect(fitted.lines.map((l) => l.peopleMeasurements.length), [1, 1, 1]);
      expect(
        fitted.removalMessage,
        'The quantity is lower than the number of people, so these '
        'measurements were removed. Dress (M): John, Mary; Gown: Priya',
      );
    });
  });
}
