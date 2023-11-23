import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/features/admin/data/model/team_leave_requests_response_model.dart';
import 'package:ais_reporting/features/admin/domain/repositories/admin_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/model/attendence_details_request_model.dart';
import '../../data/model/attendence_details_response_model.dart';

class GetAttendenceDetailsUsecase extends UseCase<
    AttendenceDetailsResponseModel, AttendenceDetailsRequestModel> {
  AdminRepo repository;
  GetAttendenceDetailsUsecase(this.repository);

  @override
  Future<Either<Failure, AttendenceDetailsResponseModel>> call(
      AttendenceDetailsRequestModel params) async {
    return await repository.getAttendenceDetails(params);
  }
}

class GetLeaveRequestsUsecase
    extends UseCase<TeamLeaveRequestsResponseModel, NoParams> {
  AdminRepo repository;
  GetLeaveRequestsUsecase(this.repository);

  @override
  Future<Either<Failure, TeamLeaveRequestsResponseModel>> call(
      NoParams noParams) async {
    return await repository.getTeamLeaveRequests(noParams);
  }
}
