import 'package:ais_reporting/core/error/failures.dart';
import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/features/authentication/login/data/modals/login_request_model.dart';
import 'package:ais_reporting/features/authentication/login/data/modals/login_response_modal.dart';
import 'package:ais_reporting/features/time_sheet/data/model/getAllProjectsResponseModel.dart';
import 'package:ais_reporting/features/time_sheet/data/model/get_all_timesheet.dart';
import 'package:ais_reporting/features/time_sheet/data/model/get_team_timesheet_response_model.dart';
import 'package:ais_reporting/features/time_sheet/data/model/time_sheet_details_post_model.dart';
import 'package:ais_reporting/features/time_sheet/data/model/update_timesheet_post_model.dart';
import 'package:ais_reporting/features/time_sheet/domain/repository/time_sheet_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';

class GetAllProjectsUsecase
    extends UseCase<GetAllProjectsResponseModel, NoParams> {
  TimeSheetRepository repository;
  GetAllProjectsUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllProjectsResponseModel>> call(
      NoParams params) async {
    return await repository.getAllProjects(params);
  }
}

class AddUserTimeSheetUsecase extends UseCase<bool, TimeSheetDetailsPostModel> {
  TimeSheetRepository repository;
  AddUserTimeSheetUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(TimeSheetDetailsPostModel params) async {
    return await repository.addUserTimeSeet(params);
  }
}

class GetAllTimeSheetUsecase extends UseCase<GetAllTimeSheets, NoParams> {
  TimeSheetRepository repository;
  GetAllTimeSheetUsecase(this.repository);

  @override
  Future<Either<Failure, GetAllTimeSheets>> call(NoParams params) async {
    return await repository.getAllTimeSeets(params);
  }
}

class GetTeamTimeSheetUsecase
    extends UseCase<GetTeamTimeSheetResponseModel, NoParams> {
  TimeSheetRepository repository;
  GetTeamTimeSheetUsecase(this.repository);

  @override
  Future<Either<Failure, GetTeamTimeSheetResponseModel>> call(
      NoParams params) async {
    return await repository.getTeamTimeSeets(params);
  }
}

class UpdateTimeSheetUsecase extends UseCase<bool, UpdateTimeSheetPostModel> {
  TimeSheetRepository repository;
  UpdateTimeSheetUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdateTimeSheetPostModel params) async {
    return await repository.updateUserTimeSheet(params);
  }
}
