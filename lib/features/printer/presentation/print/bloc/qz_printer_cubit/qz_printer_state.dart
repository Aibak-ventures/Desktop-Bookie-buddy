part of 'qz_printer_cubit.dart';

@freezed
abstract class QzPrinterState with _$QzPrinterState {
  const factory QzPrinterState({
    @Default(PrinterBridgeStatus.unknown) PrinterBridgeStatus status,
    @Default([]) List<PrinterDeviceEntity> printers,
    String? selectedPrinterName,
    String? errorMessage,
  }) = _QzPrinterState;
}
