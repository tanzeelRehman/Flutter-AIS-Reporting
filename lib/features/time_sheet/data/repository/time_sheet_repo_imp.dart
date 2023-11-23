import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/features/time_sheet/data/data_source/time_sheet_remote_data_source.dart';
import 'package:ais_reporting/features/time_sheet/data/model/getAllProjectsResponseModel.dart';
import 'package:ais_reporting/features/time_sheet/data/model/get_all_timesheet.dart';
import 'package:ais_reporting/features/time_sheet/data/model/get_team_timesheet_response_model.dart';
import 'package:ais_reporting/features/time_sheet/data/model/time_sheet_details_post_model.dart';
import 'package:ais_reporting/features/time_sheet/data/model/update_timesheet_post_model.dart';
import 'package:ais_reporting/features/time_sheet/domain/repository/time_sheet_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/constants/app_messages.dart';
import '../../../../../core/utils/network/network_info.dart';

class TimeSheetRepoImp extends TimeSheetRepository {
  final NetworkInfo networkInfo;

  final TimeSheetRemoteDataSource remoteDataSource;

  TimeSheetRepoImp({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  Future<Either<Failure, GetAllProjectsResponseModel>> getAllProjects(
      NoParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.getAllProjects(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> addUserTimeSeet(
      TimeSheetDetailsPostModel params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.addUserTimeSheet(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetAllTimeSheets>> getAllTimeSeets(
      NoParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.getAllTimeSheet(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetTeamTimeSheetResponseModel>> getTeamTimeSeets(
      NoParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.getTeamTimeSheet(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserTimeSheet(
      UpdateTimeSheetPostModel params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.updateTimeSheet(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }
}
