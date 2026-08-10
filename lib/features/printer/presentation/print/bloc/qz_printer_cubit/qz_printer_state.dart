part of 'qz_printer_cubit.dart';

@freezed
abstract class QzPrinterState with _$QzPrinterState {
  const factory QzPrinterState({
    @Default(PrinterBridgeStatus.unknown) PrinterBridgeStatus status,
    @Default([]) List<PrinterDeviceEntity> printers,
    String? selectedPrinterName,
    String? errorMessage,

    /// The printer that was saved as default *before* this session's
    /// selection changed anything — purely for the picker UI to label a
    /// "(default)" tag; never mutated by [QzPrinterCubit.selectPrinter].
    String? lastUsedPrinterName,
  }) = _QzPrinterState;
}
