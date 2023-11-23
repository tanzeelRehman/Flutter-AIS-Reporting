import 'dart:async';

import 'package:ais_reporting/features/authentication/login/presentation/manager/auth_provider.dart';
import 'package:ais_reporting/features/leave/data/models/get_leave_quota_response_model.dart';
import 'package:ais_reporting/features/leave/data/models/jobs_reassign_to_response_model.dart';
import 'package:ais_reporting/features/leave/data/models/post_leave_request_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/modals/error_response_model.dart';
import '../../../../core/utils/constants/app_messages.dart';
import '../../../../core/utils/constants/app_url.dart';
import '../../../../core/utils/globals/globals.dart';
import '../models/post_leave_response_model.dart';

abstract class LeavesRemoteDataSource {
  Future<JobReAssignToResponseModel> getEmployees(String empId);
  Future<GetLeaveQuotaResponseModel> getEmployeeLeavesQuota(String empId);
  Future<PostLeaveResponseModel> postEmployeeLeaveRequest(
      PostLeaveRequestModel params);
}

class LeavesRemoteDataSourceImp implements LeavesRemoteDataSource {
  Dio dio;
  LeavesRemoteDataSourceImp({required this.dio});

  //*----------------------------------------------------------------------------
  /// Get List of employees, To [Asign Taks]
  //*----------------------------------------------------------------------------
  @override
  Future<JobReAssignToResponseModel> getEmployees(String empId) async {
    String url = AppUrl.baseUrl + AppUrl.getJobsReAssignToEmployess + empId;

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        var object = JobReAssignToResponseModel.fromJson(response.data);
        print(object.message);

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

  //*----------------------------------------------------------------------------
  /// Get Employee [Leave Details] leave Quota
  //*----------------------------------------------------------------------------

  @override
  Future<GetLeaveQuotaResponseModel> getEmployeeLeavesQuota(
      String empId) async {
    String url = AppUrl.baseUrl + AppUrl.getLeaveQuota + empId;

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        var object = GetLeaveQuotaResponseModel.fromJson(response.data);

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
  //*----------------------------------------------------------------------------
  ///  [Post] Employee Leave requesr //! Post request
  //*----------------------------------------------------------------------------

  @override
  Future<PostLeaveResponseModel> postEmployeeLeaveRequest(
      PostLeaveRequestModel params) async {
    print(params.jobInHand);
    print(params.leaveEndDate);
    print(params.leaveStartDate);
    print(params.leaveTypeId);
    print(params.no_of_days);
    print(params.justificationForLeave);
    print(params.taskReassignedTo);
    print(params.userId);

    String url = AppUrl.baseUrl + AppUrl.addLeaveInformation;
    print(url);
    AuthProvider provider = sl();
    String token = provider.uSerProvider.userDetails!.token;

    try {
      final response = await dio.post(url,
          data: params.toJson(),
          options: Options(headers: {"authorization": "Bearer $token"}));

      Logger().v(response.statusCode);
      Logger().v(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var object = PostLeaveResponseModel.fromJson(response.data);

        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().v("comming here");
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel.fromJson(exception.response?.data);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      Logger().e(e.toString());
      throw SomethingWentWrong(e.toString());
    }
  }
}
