import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';

class ClearLastPrinterUseCase {
  ClearLastPrinterUseCase(this._repository);

  final IPrinterRepository _repository;

  Future<void> call() => _repository.clearLastPrinter();
}
