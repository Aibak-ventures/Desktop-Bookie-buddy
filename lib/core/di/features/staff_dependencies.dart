import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/staff/data/datasources/staff_remote_datasource.dart';
import 'package:bookie_buddy_web/features/staff/data/repositories/staff_repository_impl.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/add_staff_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/delete_staff_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/edit_staff_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staff_analytics_report_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staff_monthly_bookings_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staff_monthly_sales_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staffs_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class StaffDependencies {
  static void register() {
    getIt.registerLazySingleton(
        () => StaffRemoteDatasource(dio: DioClient.dio));
    getIt.registerLazySingleton<IStaffRepository>(
        () => StaffRepositoryImpl(getIt()));
    getIt.registerLazySingleton(
        () => GetStaffsUseCase(getIt<IStaffRepository>()));
    getIt.registerLazySingleton(
        () => AddStaffUseCase(getIt<IStaffRepository>()));
    getIt.registerLazySingleton(
        () => EditStaffUseCase(getIt<IStaffRepository>()));
    getIt.registerLazySingleton(
        () => DeleteStaffUseCase(getIt<IStaffRepository>()));
    getIt.registerLazySingleton(
        () => GetStaffAnalyticsReportUseCase(getIt<IStaffRepository>()));
    getIt.registerLazySingleton(
        () => GetStaffMonthlyBookingsUseCase(getIt<IStaffRepository>()));
    getIt.registerLazySingleton(
        () => GetStaffMonthlySalesUseCase(getIt<IStaffRepository>()));
  }
}
