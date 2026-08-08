import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';

class GetLastPrinterUseCase {
  GetLastPrinterUseCase(this._repository);

  final IPrinterRepository _repository;

  Future<String?> call() => _repository.getLastPrinter();
}
