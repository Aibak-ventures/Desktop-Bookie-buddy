import 'package:bookie_buddy_web/features/printer/domain/entities/print_ticket_entity/print_ticket_entity.dart';
import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';

class PrintReceiptUseCase {
  PrintReceiptUseCase(this._repository);

  final IPrinterRepository _repository;

  Future<void> call(String printerName, PrintTicketEntity ticket) =>
      _repository.print(printerName, ticket);
}
