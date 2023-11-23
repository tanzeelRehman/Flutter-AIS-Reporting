import 'package:ais_reporting/features/leave/data/data_source/leaves_remote_data_source.dart';
import 'package:ais_reporting/features/leave/data/models/get_leave_quota_response_model.dart';
import 'package:ais_reporting/features/leave/data/models/post_leave_response_model.dart';
import 'package:ais_reporting/features/leave/data/models/post_leave_request_model.dart';
import 'package:dartz/dartz.dart';
import 'package:ais_reporting/features/leave/data/models/jobs_reassign_to_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/constants/app_messages.dart';
import '../../../../core/utils/network/network_info.dart';
import '../../domain/repositories/leave_repo.dart';

class LeaveRepoImp extends LeaveRepo {
  final NetworkInfo networkInfo;

  final LeavesRemoteDataSource remoteDataSource;

  LeaveRepoImp({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, JobReAssignToResponseModel>>
      getJobsReAssignToEmployess(String empId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.getEmployees(empId));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetLeaveQuotaResponseModel>> getEmployeeLeaveQuota(
      String empId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.getEmployeeLeavesQuota(empId));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, PostLeaveResponseModel>> requestLeaveApply(
      PostLeaveRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }

    try {
      return Right(await remoteDataSource.postEmployeeLeaveRequest(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }
}
