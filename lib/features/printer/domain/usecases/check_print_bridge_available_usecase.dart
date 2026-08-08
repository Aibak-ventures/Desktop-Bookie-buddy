import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';

class CheckPrintBridgeAvailableUseCase {
  CheckPrintBridgeAvailableUseCase(this._repository);

  final IPrinterRepository _repository;

  Future<bool> call() => _repository.isBridgeAvailable();
}
