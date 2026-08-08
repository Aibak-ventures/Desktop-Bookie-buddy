import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';

class SaveLastPrinterUseCase {
  SaveLastPrinterUseCase(this._repository);

  final IPrinterRepository _repository;

  Future<void> call(String printerName) =>
      _repository.saveLastPrinter(printerName);
}
