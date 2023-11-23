import 'package:ais_reporting/core/error/failures.dart';
import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/features/time_sheet/data/model/getAllProjectsResponseModel.dart';
import 'package:ais_reporting/features/time_sheet/data/model/get_all_timesheet.dart';
import 'package:ais_reporting/features/time_sheet/data/model/get_team_timesheet_response_model.dart';
import 'package:ais_reporting/features/time_sheet/data/model/time_sheet_details_post_model.dart';
import 'package:ais_reporting/features/time_sheet/data/model/update_timesheet_post_model.dart';
import 'package:dartz/dartz.dart';

abstract class TimeSheetRepository {
  Future<Either<Failure, GetAllProjectsResponseModel>> getAllProjects(
      NoParams params);
  Future<Either<Failure, bool>> addUserTimeSeet(
      TimeSheetDetailsPostModel params);
  Future<Either<Failure, bool>> updateUserTimeSheet(
      UpdateTimeSheetPostModel params);
  Future<Either<Failure, GetAllTimeSheets>> getAllTimeSeets(NoParams params);
  Future<Either<Failure, GetTeamTimeSheetResponseModel>> getTeamTimeSeets(
      NoParams params);
}
