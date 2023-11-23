import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/features/admin/data/model/attendence_details_request_model.dart';
import 'package:ais_reporting/features/admin/data/model/team_leave_requests_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/attendence_details_response_model.dart';

abstract class AdminRepo {
  Future<Either<Failure, AttendenceDetailsResponseModel>> getAttendenceDetails(
      AttendenceDetailsRequestModel queryparms);
  Future<Either<Failure, TeamLeaveRequestsResponseModel>> getTeamLeaveRequests(
      NoParams noParams);
}
