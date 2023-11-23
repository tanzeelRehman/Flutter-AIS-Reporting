import 'dart:async';

import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/core/utils/globals/globals.dart';
import 'package:ais_reporting/features/admin/data/model/attendence_details_response_model.dart';
import 'package:ais_reporting/features/admin/data/model/team_leave_requests_response_model.dart';
import 'package:ais_reporting/features/authentication/login/presentation/manager/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/modals/error_response_model.dart';
import '../../../../core/utils/constants/app_messages.dart';
import '../../../../core/utils/constants/app_url.dart';
import '../model/attendence_details_request_model.dart';

abstract class AdminRemoteDataSource {
  Future<AttendenceDetailsResponseModel> getAttendenceDetails(
      AttendenceDetailsRequestModel queryparms);
  Future<TeamLeaveRequestsResponseModel> getTeamLeaveRequests(
      NoParams noParams);
}

class AdminRemoteDataSourceImp implements AdminRemoteDataSource {
  AuthProvider authProvider = sl();
  Dio dio;
  AdminRemoteDataSourceImp({required this.dio});

  //*----------------------------------------------------------------------------
  /// Get all  employees,  [Attendence Details]
  //*----------------------------------------------------------------------------
  @override
  Future<AttendenceDetailsResponseModel> getAttendenceDetails(
      AttendenceDetailsRequestModel queryparms) async {
    String url =
        "${AppUrl.baseUrl}${AppUrl.getattendenceDetails}startDate=${queryparms.startDate}&endDate=${queryparms.endDate}&userId=${queryparms.userId}&deptId=${queryparms.deptId}&designationId=${queryparms.designationId}&roleId=${queryparms.roleId}";
    Logger().i(url);

    try {
      final response = await dio.get(url);
      print(response.data);
      //  print(response.data);
      if (response.statusCode == 200) {
        var object = AttendenceDetailsResponseModel.fromJson(response.data);

        return object;
      }
      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel.fromJson(exception.response?.data);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<TeamLeaveRequestsResponseModel> getTeamLeaveRequests(
      NoParams noParams) async {
    String url =
        "${AppUrl.baseUrl}${AppUrl.getLeaveRequests}${authProvider.uSerProvider.userDetails!.user.userId}?departmentId=${authProvider.uSerProvider.userDetails!.departmentId}&designationId==${authProvider.uSerProvider.userDetails!.designationId}&roleId=${authProvider.uSerProvider.userDetails!.roleId}&verticalId=${authProvider.uSerProvider.userDetails!.user.verticalId}";
    Logger().i(url);

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        Logger().i('DID I COME HERE');
        var object = TeamLeaveRequestsResponseModel.fromJson(response.data);
        Logger().i('Team leave requests ${object.toJson()}');
        return object;
      }
      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel.fromJson(exception.response?.data);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }
}
