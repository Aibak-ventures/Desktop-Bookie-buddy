import 'package:bookie_buddy_shared/bookie_buddy_shared.dart';

enum BookingListFilter implements BackendKeyedEnum {
  upcoming('upcoming', 'Upcoming'),
  returns('returns', 'Returns'),
  pending('pending', 'Pending'),
  notReturned('not_returned', 'Not Returned'),
  completed('completed', 'Completed'),
  cancelled('cancelled', 'Cancelled');

  const BookingListFilter(this.value, this.label);

  @override
  final String value;

  @override
  final String label;

  static BookingListFilter fromJson(String? value) =>
      EnumJsonCodec.fromJson(value, values, fallback: pending);
}
