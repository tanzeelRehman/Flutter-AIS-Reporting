import 'package:ais_reporting/core/error/failures.dart';
import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/features/dashboard/data/data_sources/dashboard_remote_datasource.dart';
import 'package:ais_reporting/features/dashboard/data/models/get_status_response_model.dart';

import 'package:ais_reporting/features/dashboard/data/models/upload_status_request_model.dart';

import 'package:ais_reporting/features/dashboard/data/models/upload_status_response_model.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/utils/constants/app_messages.dart';
import '../../../../core/utils/network/network_info.dart';
import '../../domain/repositories/dashboard_repo.dart';

class DashboardRepoImp extends DashboardRepository {
  final NetworkInfo networkInfo;

  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepoImp({
    required this.networkInfo,
    required this.remoteDataSource,
  });




  @override
  Future<Either<Failure, UploadStatusResponseModel>> uploadStatus(UploadStatusRequestModel params) async {

    if (!await networkInfo.isConnected) {
      return Left( NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.uploadStatus(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetStatusResponseModel>> getStatus(String params) async {
    if (!await networkInfo.isConnected) {
      return Left( NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.getStatus(params));
    } on Failure catch (e) {
    return Left(e);
    } catch (e) {
    return Left(ServerFailure(e));
    }


  }




}