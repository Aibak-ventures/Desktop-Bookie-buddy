import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_device_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';

class RefreshPrinterStatusesUseCase {
  RefreshPrinterStatusesUseCase(this._repository);

  final IPrinterRepository _repository;

  Future<List<PrinterDeviceEntity>> call(List<PrinterDeviceEntity> printers) =>
      _repository.refreshPrinterStatuses(printers);
}
