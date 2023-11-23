import 'package:ais_reporting/features/leave/data/models/get_leave_quota_response_model.dart';
import 'package:ais_reporting/features/leave/data/models/jobs_reassign_to_response_model.dart';
import 'package:ais_reporting/features/leave/data/models/post_leave_request_model.dart';
import 'package:ais_reporting/features/leave/data/models/post_leave_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class LeaveRepo {
  Future<Either<Failure, JobReAssignToResponseModel>>
      getJobsReAssignToEmployess(String empId);

  Future<Either<Failure, GetLeaveQuotaResponseModel>> getEmployeeLeaveQuota(
      String empId);

  Future<Either<Failure, PostLeaveResponseModel>> requestLeaveApply(
      PostLeaveRequestModel params);
}
