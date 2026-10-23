import 'package:bookie_buddy_shared/core/features/booking/data/models/person_measurements_model/person_measurements_model.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurements_entity.dart';
import 'package:bookie_buddy_shared/core/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/product/data/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/features/product/data/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:flutter_test/flutter_test.dart';

MeasurementValueEntity _m(String key, String value) =>
    MeasurementValueEntity(name: key, key: key, value: value);

PersonMeasurementsEntity _p(String name, Map<String, String> values) =>
    PersonMeasurementsEntity(
      name: name,
      measurements: [for (final e in values.entries) _m(e.key, e.value)],
    );

void main() {
  group('ProductInfoModel measurements', () {
    // Shapes the backend could plausibly hold. None may throw.
    final odd = <String, dynamic>{
      'null': null,
      'string': 'chest 30',
      'number': 7,
      'bool': true,
      'list': [1, 2],
      'list of maps': [
        {'name': 'Chest', 'value': '30'},
      ],
      'empty map': <String, dynamic>{},
      'null value': {'chest': null},
      'person with null': {'Afnan': null},
      'person with scalar list': {
        'Afnan': [1, 2],
      },
      'deep nesting': {
        'Afnan': {
          'chest': {'a': 1},
        },
      },
      'empty person': {'Afnan': <String, dynamic>{}},
      'empty key': {
        '': {'chest': 1},
      },
      'mixed': {
        'chest': 30,
        'Afnan': {'waist': 28},
      },
      'untyped map': <dynamic, dynamic>{
        1: {'chest': 1},
      },
    };

    group('through ProductInfoModel.fromJson', () {
      Map<String, dynamic> variant(dynamic measurements) => {
        'id': 1,
        'product_id': 1,
        'variant_id': 1,
        'product_name': 'Dress',
        'product_thumbnail': null,
        'quantity': 5,
        'fabric_length': 0,
        'amount': 100,
        'measurements': measurements,
      };

      for (final entry in {...odd, 'missing': null}.entries) {
        test('"${entry.key}" does not break parsing a booked item', () {
          final json = variant(entry.value);
          if (entry.key == 'missing') json.remove('measurements');

          expect(
            () => ProductInfoModel.fromJson(json).toEntity(),
            returnsNormally,
          );
        });
      }

      test('legacy and per-person payloads both load', () {
        final legacy = ProductInfoModel.fromJson(variant({'chest': 30}));
        final people = ProductInfoModel.fromJson(
          variant({
            'Afnan': {'chest': 30},
            'John': {'chest': 34},
          }),
        );

        expect(legacy.peopleMeasurements.single.name, isEmpty);
        expect(people.peopleMeasurements.map((p) => p.name), ['Afnan', 'John']);
      });
    });
  });

  group('write requests', () {
    ProductSelectedEntity line({
      List<PersonMeasurementsEntity> people = const [],
      String? km,
    }) => ProductSelectedEntity(
      variant: ProductInfoEntity(
        id: 1,
        variantId: 11,
        productId: 1,
        name: 'Dress',
        thumbnailImage: null,
        quantity: 2,
        fabricLength: 0,
        amount: 100,
      ),
      amount: 100,
      quantity: 2,
      peopleMeasurements: people,
      runningKilometers: km,
    );

    Map<String, dynamic> json(ProductSelectedEntity l, {bool m = true}) =>
        ProductSelectedModel.fromEntity(l).toCustomJson(includeMeasurement: m);

    test('a line without measurements sends no measurements key', () {
      expect(json(line()), {'id': 11, 'amount': 200, 'quantity': 2});
    });

    test('measurements are always sent keyed', () {
      expect(
        json(
          line(
            people: [
              _p('', {'chest': '30'}),
            ],
          ),
        ),
        {
          'id': 11,
          'amount': 200,
          'quantity': 2,
          'measurements': {
            'Person 1': {'chest': '30'},
          },
        },
      );
    });

    test('several people become one entry each', () {
      final body = json(
        line(
          people: [
            _p('Afnan', {'chest': '30'}),
            _p('John', {'chest': '34', 'waist': '28'}),
          ],
        ),
      );

      expect(body['measurements'], {
        'Afnan': {'chest': '30'},
        'John': {'chest': '34', 'waist': '28'},
      });
    });

    test('people without values are not written', () {
      final body = json(
        line(
          people: [
            _p('Afnan', {}),
            _p('John', {'chest': '34'}),
          ],
        ),
      );

      expect(body['measurements'], {
        'John': {'chest': '34'},
      });
    });

    test('sales requests never carry measurements', () {
      final body = json(
        line(
          people: [
            _p('', {'chest': '30'}),
          ],
          km: '100',
        ),
        m: false,
      );

      expect(body.containsKey('measurements'), isFalse);
    });

    test('running kilometers travel beside the people, not inside one', () {
      expect(json(line(km: '1000 Km'))['measurements'], {
        'running_kilometers': '1000 Km',
      });
      expect(
        json(
          line(
            people: [
              _p('Afnan', {'chest': '30'}),
              _p('John', {'chest': '34'}),
            ],
            km: '5',
          ),
        )['measurements'],
        {
          'Afnan': {'chest': '30'},
          'John': {'chest': '34'},
          'running_kilometers': '5',
        },
      );
    });

    test('a stored running kilometers value is replaced, never duplicated', () {
      final stored = [
        _p('', {'chest': '30', 'running_kilometers': 'old'}),
      ];

      expect(json(line(people: stored, km: 'new'))['measurements'], {
        'Person 1': {'chest': '30'},
        'running_kilometers': 'new',
      });
      // Without a current value the stored one is dropped, as it always was.
      expect(json(line(people: stored))['measurements'], {
        'Person 1': {'chest': '30'},
      });
      // The edit-booking handler passes the field's text, empty or not.
      expect(stored.toMeasurementsJson(runningKilometers: ''), {
        'Person 1': {'chest': '30'},
      });
    });

    test('nothing to send leaves the key out', () {
      expect(
        json(line(people: [_p('A', {})])).containsKey('measurements'),
        isFalse,
      );
      expect([_p('A', {})].toMeasurementsJson(runningKilometers: ''), isNull);
    });
  });

  group('bookings stored by older builds', () {
    Map<String, dynamic> item(dynamic measurements) => {
      'id': 1,
      'product_id': 1,
      'variant_id': 11,
      'product_name': 'Item',
      'product_thumbnail': null,
      'quantity': 1,
      'amount': 100,
      'measurements': measurements,
    };

    final stored = <String, Map<String, String>>{
      'web dress': {'chest': '30', 'shoulder_width': '28'},
      'web vehicle': {'running_kilometers': '55'},
      'mobile dress': {'Chest': '30', 'Shoulder Width': '28'},
      'mobile vehicle': {'Running Kilometers': '20500 Km'},
    };

    for (final e in stored.entries) {
      test(
        '${e.key}: values load, the odometer is found and edit-save keeps both',
        () {
          final info = ProductInfoModel.fromJson(item(e.value)).toEntity();
          final values = {
            for (final m in info.peopleMeasurements.allValues) m.key: m.value,
          };
          expect(values.length, e.value.length);

          // What the edit-booking initializer does to prefill the km field.
          final km = info.peopleMeasurements.allValues
              .where((m) => m.key == 'running_kilometers')
              .firstOrNull
              ?.value;

          // What the edit-booking save sends for the line.
          final sent = info.peopleMeasurements.toMeasurementsJson(
            runningKilometers: km ?? '',
          );
          final reread = ProductInfoModel.fromJson(item(sent)).toEntity();
          expect({
            for (final m in reread.peopleMeasurements.allValues) m.key: m.value,
          }, values);
          if (km != null) {
            expect(sent!['running_kilometers'], km);
            expect(
              sent.values.whereType<Map>().expand((p) => p.keys),
              isNot(contains('running_kilometers')),
            );
          }
        },
      );

      test('${e.key}: an untouched line is not flagged as changed', () {
        final a = ProductInfoModel.fromJson(item(e.value)).toEntity();
        final b = ProductInfoModel.fromJson(item(e.value)).toEntity();
        expect(
          a.peopleMeasurements.fingerprint,
          b.peopleMeasurements.fingerprint,
        );
      });
    }

    test('a new booking line sends the odometer exactly as the field says', () {
      final line = ProductSelectedEntity(
        variant: ProductInfoModel.fromJson(item(null)).toEntity(),
        amount: 100,
        quantity: 1,
        runningKilometers: '1000 Km',
      );
      expect(
        ProductSelectedModel.fromEntity(line).toCustomJson()['measurements'],
        {'running_kilometers': '1000 Km'},
      );
    });
  });
}
