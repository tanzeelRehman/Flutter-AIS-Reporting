import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/features/admin/data/model/attendence_details_response_model.dart';
import 'package:ais_reporting/features/admin/data/model/attendence_details_request_model.dart';
import 'package:ais_reporting/core/error/failures.dart';
import 'package:ais_reporting/features/admin/data/model/team_leave_requests_response_model.dart';
import 'package:ais_reporting/features/admin/domain/repositories/admin_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/constants/app_messages.dart';
import '../../../../core/utils/network/network_info.dart';
import '../data_source/admin_remote_datasource.dart';

class AdminRepoImp extends AdminRepo {
  final NetworkInfo networkInfo;

  final AdminRemoteDataSource remoteDataSource;

  AdminRepoImp({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, AttendenceDetailsResponseModel>> getAttendenceDetails(
      AttendenceDetailsRequestModel queryparms) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.getAttendenceDetails(queryparms));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, TeamLeaveRequestsResponseModel>> getTeamLeaveRequests(
      NoParams noParams) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.getTeamLeaveRequests(noParams));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }
}
