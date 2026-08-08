import 'package:freezed_annotation/freezed_annotation.dart';

part 'printer_device_entity.freezed.dart';

/// QZ Tray only ever returns a bare printer name (whatever the Windows/OS
/// print-driver list calls it) — no address/port/connection-type breakdown
/// like the mobile app's Bluetooth/USB/network scan gives, since QZ itself
/// abstracts the transport away.
@freezed
abstract class PrinterDeviceEntity with _$PrinterDeviceEntity {
  const factory PrinterDeviceEntity({required String name}) =
      _PrinterDeviceEntity;
}
