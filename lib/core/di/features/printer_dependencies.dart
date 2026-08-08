import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/printer/data/datasources/qz_tray_datasource.dart';
import 'package:bookie_buddy_web/features/printer/data/repositories/qz_printer_repository_impl.dart';
import 'package:bookie_buddy_web/features/printer/domain/repositories/i_printer_repository.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/check_print_bridge_available_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/connect_print_bridge_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/find_printers_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/get_last_printer_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/print_receipt_usecase.dart';
import 'package:bookie_buddy_web/features/printer/domain/usecases/save_last_printer_usecase.dart';
import 'package:bookie_buddy_web/features/printer/presentation/print/bloc/qz_printer_cubit/qz_printer_cubit.dart';
import 'package:bookie_buddy_web/utils/shared_preference_helper.dart';

class PrinterDependencies {
  static void register() {
    getIt.registerLazySingleton(() => QzTrayDatasource());
    getIt.registerLazySingleton<IPrinterRepository>(
      () => QzPrinterRepositoryImpl(getIt(), getIt<SharedPreferenceHelper>()),
    );
    getIt.registerLazySingleton(
      () => CheckPrintBridgeAvailableUseCase(getIt<IPrinterRepository>()),
    );
    getIt.registerLazySingleton(
      () => ConnectPrintBridgeUseCase(getIt<IPrinterRepository>()),
    );
    getIt.registerLazySingleton(
      () => FindPrintersUseCase(getIt<IPrinterRepository>()),
    );
    getIt.registerLazySingleton(
      () => PrintReceiptUseCase(getIt<IPrinterRepository>()),
    );
    getIt.registerLazySingleton(
      () => SaveLastPrinterUseCase(getIt<IPrinterRepository>()),
    );
    getIt.registerLazySingleton(
      () => GetLastPrinterUseCase(getIt<IPrinterRepository>()),
    );
    // Factory, not singleton — QzPrinterCubit is screen-scoped (see its
    // own doc for why, unlike mobile's app-wide ThermalPrinterCubit), so
    // each QzPrintScreen must get a fresh instance.
    getIt.registerFactory(
      () => QzPrinterCubit(
        checkBridgeAvailableUseCase: getIt(),
        findPrintersUseCase: getIt(),
        printReceiptUseCase: getIt(),
        getLastPrinterUseCase: getIt(),
        saveLastPrinterUseCase: getIt(),
      ),
    );
  }
}
