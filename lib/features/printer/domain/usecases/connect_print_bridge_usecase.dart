import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';

class ConnectPrintBridgeUseCase {
  ConnectPrintBridgeUseCase(this._repository);

  final IPrinterRepository _repository;

  Future<void> call() => _repository.connectToBridge();
}
