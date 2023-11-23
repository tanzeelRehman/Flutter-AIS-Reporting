import 'package:ais_reporting/features/leave/data/models/get_leave_quota_response_model.dart';
import 'package:ais_reporting/features/leave/data/models/jobs_reassign_to_response_model.dart';
import 'package:ais_reporting/features/leave/data/models/post_leave_request_model.dart';
import 'package:ais_reporting/features/leave/data/models/post_leave_response_model.dart';
import 'package:ais_reporting/features/leave/domain/repositories/leave_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetEmployeesListUsecase
    extends UseCase<JobReAssignToResponseModel, String> {
  LeaveRepo repository;
  GetEmployeesListUsecase(this.repository);

  @override
  Future<Either<Failure, JobReAssignToResponseModel>> call(
      String params) async {
    return await repository.getJobsReAssignToEmployess(params);
  }
}

class GetEmployeeLeaveQuotaUsecase
    extends UseCase<GetLeaveQuotaResponseModel, String> {
  LeaveRepo repository;
  GetEmployeeLeaveQuotaUsecase(this.repository);

  @override
  Future<Either<Failure, GetLeaveQuotaResponseModel>> call(
      String params) async {
    return await repository.getEmployeeLeaveQuota(params);
  }
}

class RequestLeaveApplyUsecase
    extends UseCase<PostLeaveResponseModel, PostLeaveRequestModel> {
  LeaveRepo repository;
  RequestLeaveApplyUsecase(this.repository);

  @override
  Future<Either<Failure, PostLeaveResponseModel>> call(
      PostLeaveRequestModel params) async {
    return await repository.requestLeaveApply(params);
  }
}
