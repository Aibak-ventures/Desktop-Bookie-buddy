import 'package:bookie_buddy_web/features/booking/domain/entities/desktop_booking_item_entity/desktop_booking_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_search_entity.freezed.dart';

@freezed
abstract class GlobalSearchEntity with _$GlobalSearchEntity {
  const factory GlobalSearchEntity({DesktopBookingItemEntity? booking}) =
      _GlobalSearchEntity;
}
