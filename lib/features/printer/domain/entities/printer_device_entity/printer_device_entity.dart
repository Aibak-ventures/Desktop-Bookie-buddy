import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_online_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'printer_device_entity.freezed.dart';

/// QZ Tray only ever returns a bare printer name (whatever the Windows/OS
/// print-driver list calls it) — no address/port/connection-type breakdown
/// like the mobile app's Bluetooth/USB/network scan gives, since QZ itself
/// abstracts the transport away.
@freezed
abstract class PrinterDeviceEntity with _$PrinterDeviceEntity {
  const factory PrinterDeviceEntity({
    required String name,

    /// Live reachability from QZ's status API — [PrinterOnlineStatus.unknown]
    /// until a status check has run (or if it timed out/isn't supported by
    /// this printer's driver), never used to hide a printer from the list.
    @Default(PrinterOnlineStatus.unknown) PrinterOnlineStatus onlineStatus,
  }) = _PrinterDeviceEntity;
}
