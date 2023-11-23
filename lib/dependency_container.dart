import 'package:ais_reporting/features/admin/data/data_source/admin_remote_datasource.dart';
import 'package:ais_reporting/features/admin/data/repositories/admin_repo_impl.dart';
import 'package:ais_reporting/features/admin/domain/repositories/admin_repo.dart';
import 'package:ais_reporting/features/admin/domain/use_cases/admin_use_cases.dart';
import 'package:ais_reporting/features/admin/presentation/providers/admin_provider.dart';
import 'package:ais_reporting/features/admin/presentation/providers/employee_check_in_out_details_provider.dart';
import 'package:ais_reporting/features/dashboard/data/data_sources/dashboard_remote_datasource.dart';
import 'package:ais_reporting/features/dashboard/data/repositories/dashboard_repo_imp.dart';
import 'package:ais_reporting/features/dashboard/domain/repositories/dashboard_repo.dart';
import 'package:ais_reporting/features/dashboard/domain/use_cases/dashboard_usecase.dart';
import 'package:ais_reporting/features/leave/data/data_source/leaves_remote_data_source.dart';
import 'package:ais_reporting/features/leave/domain/repositories/leave_repo.dart';
import 'package:ais_reporting/features/leave/domain/use_cases/leave_use_cases.dart';
import 'package:ais_reporting/features/leave/presentation/provider/leave_provider.dart';
import 'package:ais_reporting/features/profile/presentation/provider/profile_provider.dart';
import 'package:ais_reporting/features/time_sheet/data/data_source/time_sheet_remote_data_source.dart';
import 'package:ais_reporting/features/time_sheet/data/repository/time_sheet_repo_imp.dart';
import 'package:ais_reporting/features/time_sheet/domain/repository/time_sheet_repository.dart';
import 'package:ais_reporting/features/time_sheet/domain/usecases/time_sheet_usecase.dart';
import 'package:ais_reporting/features/time_sheet/presentation/provider/time_sheet_provider.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/router/app_state.dart';
import 'core/services/auth_services.dart';
import 'core/services/secure_storage_service.dart';
import 'core/services/user_provider.dart';
import 'core/utils/globals/globals.dart';
import 'core/utils/network/network_info.dart';
import 'features/authentication/login/data/data_sources/login_remote_data_source.dart';
import 'features/authentication/login/data/repository/auth_repo_imp.dart';
import 'features/authentication/login/domain/repository/auth_repo.dart';
import 'features/authentication/login/domain/usecases/login_usecase.dart';
import 'features/authentication/login/presentation/manager/auth_provider.dart';
import 'features/dashboard/presentation/manager/dashboard_provider.dart';
import 'features/leave/data/repositories/leave_repo_imp.dart';

Future<void> init() async {
  ///! UseCases
  // Auth
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  // Dashboard
  sl.registerLazySingleton(() => UploadStatusUsecase(sl()));
  sl.registerLazySingleton(() => GetStatusUsecase(sl()));

  /// Leave [Employee List to Assign task to one of them] in leave module
  sl.registerLazySingleton(() => GetEmployeesListUsecase(sl()));
  sl.registerLazySingleton(() => GetEmployeeLeaveQuotaUsecase(sl()));
  sl.registerLazySingleton(() => RequestLeaveApplyUsecase(sl()));
  // Admin
  sl.registerLazySingleton(() => GetAttendenceDetailsUsecase(sl()));
  //Timesheet
  sl.registerLazySingleton(() => GetAllProjectsUsecase(sl()));
  sl.registerLazySingleton(() => AddUserTimeSheetUsecase(sl()));
  sl.registerLazySingleton(() => GetAllTimeSheetUsecase(sl()));
  sl.registerLazySingleton(() => GetTeamTimeSheetUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTimeSheetUsecase(sl()));
  sl.registerLazySingleton(() => GetLeaveRequestsUsecase(sl()));

  //! Repositories
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(dio: sl()));
  sl.registerLazySingleton<DashboardRemoteDataSource>(
      () => DashboardRemoteDataSourceImp(dio: sl()));
  sl.registerLazySingleton<LeavesRemoteDataSource>(
      () => LeavesRemoteDataSourceImp(dio: sl()));
  sl.registerLazySingleton<AdminRemoteDataSource>(
      () => AdminRemoteDataSourceImp(dio: sl()));
  sl.registerLazySingleton<TimeSheetRemoteDataSource>(
      () => TimeSheetRemoteDataSourceImp(dio: sl()));

  //!Data sources
  sl.registerLazySingleton<AuthRepository>(
      () => LoginRepoImp(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<DashboardRepository>(
      () => DashboardRepoImp(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<LeaveRepo>(() => LeaveRepoImp(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));
  sl.registerLazySingleton<AdminRepo>(
      () => AdminRepoImp(networkInfo: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<TimeSheetRepository>(
      () => TimeSheetRepoImp(networkInfo: sl(), remoteDataSource: sl()));

  /// Configs

  /// Repository

  /// External
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///! Providers
  sl.registerLazySingleton(() => AuthProvider(sl()));
  sl.registerLazySingleton(() => UserProvider());
  sl.registerLazySingleton(() => SecureStorageService());
  sl.registerLazySingleton(() => AuthServices());
  sl.registerLazySingleton(() => LeaveProvider(sl(), sl(), sl()));
  sl.registerLazySingleton(() => Adminprovider(getLeaveRequestsUsecase: sl()));
  sl.registerLazySingleton(() => DashboardProvider(sl(), sl()));
  sl.registerLazySingleton(() =>
      EmployeeCheckInOutDetailsProvider(getAttendenceDetailsUsecase: sl()));
  sl.registerLazySingleton(() => ProfileProvider());
  // TimeSheet
  sl.registerLazySingleton(
      () => TimeSheetProvider(sl(), sl(), sl(), sl(), sl()));

  /// Navigator
  sl.registerLazySingleton(() => AppState());
  sl.registerLazySingleton<Dio>(() => Dio());
}
