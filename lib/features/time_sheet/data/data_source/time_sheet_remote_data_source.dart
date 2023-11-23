import 'dart:async';
import 'dart:convert';

import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/core/utils/globals/globals.dart';
import 'package:ais_reporting/core/utils/globals/snack_bar.dart';
import 'package:ais_reporting/features/authentication/login/presentation/manager/auth_provider.dart';
import 'package:ais_reporting/features/time_sheet/data/model/getAllProjectsResponseModel.dart';
import 'package:ais_reporting/features/time_sheet/data/model/get_all_timesheet.dart';
import 'package:ais_reporting/features/time_sheet/data/model/get_team_timesheet_response_model.dart';
import 'package:ais_reporting/features/time_sheet/data/model/time_sheet_details_post_model.dart';
import 'package:ais_reporting/features/time_sheet/data/model/update_timesheet_post_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/modals/error_response_model.dart';
import '../../../../../core/utils/constants/app_messages.dart';
import '../../../../../core/utils/constants/app_url.dart';

abstract class TimeSheetRemoteDataSource {
  Future<GetAllProjectsResponseModel> getAllProjects(NoParams params);
  Future<bool> addUserTimeSheet(TimeSheetDetailsPostModel params);
  Future<bool> updateTimeSheet(UpdateTimeSheetPostModel params);
  Future<GetAllTimeSheets> getAllTimeSheet(NoParams params);
  Future<GetTeamTimeSheetResponseModel> getTeamTimeSheet(NoParams params);
}

class TimeSheetRemoteDataSourceImp implements TimeSheetRemoteDataSource {
  Dio dio;
  TimeSheetRemoteDataSourceImp({required this.dio});

  AuthProvider authProvider = sl();

  @override
  Future<GetAllProjectsResponseModel> getAllProjects(NoParams params) async {
    String url = AppUrl.baseUrl + AppUrl.getAllProjectsDetails;

    try {
      final response = await dio.get(url);
      Logger().v(response.statusCode);

      if (response.statusCode == 200) {
        var object =
            GetAllProjectsResponseModel.fromJson(jsonDecode(response.data));
        Logger().v(object.toJson());

        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        Logger().v(exception.response!.data);

        // var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        // var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(msg: exception.response!.data['message']);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<bool> addUserTimeSheet(TimeSheetDetailsPostModel params) async {
    String url = AppUrl.baseUrl + AppUrl.addUserTimeSheet;

    try {
      final response = await dio.post(url,
          data: params.toJson(),
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization":
                "Bearer ${authProvider.uSerProvider.userDetails!.token}"
          }));
      Logger().i('This is status code');
      Logger().i(response.statusCode);

      if (response.statusCode == 200) {
        return true;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        Logger().i('is something wrong');
        Logger().v(exception.response!.data);

        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(msg: exception.response!.data['message']);

        ShowSnackBar.show(errorResponseModel.msg.toString());

        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<GetAllTimeSheets> getAllTimeSheet(NoParams params) async {
    String url = AppUrl.baseUrl +
        AppUrl.getAllTimeSheets +
        authProvider.uSerProvider.userDetails!.user.userId.toString();

    try {
      final response = await dio.get(url,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization":
                "Bearer ${authProvider.uSerProvider.userDetails!.token}"
          }));
      Logger().v(response.statusCode);

      if (response.statusCode == 200) {
        var object = GetAllTimeSheets.fromJson(jsonDecode(response.data));
        Logger().v(object.toJson());

        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        Logger().v(exception.response!.data);

        // var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        // var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(msg: exception.response!.data['message']);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<GetTeamTimeSheetResponseModel> getTeamTimeSheet(
      NoParams params) async {
    String url = AppUrl.baseUrl +
        AppUrl.getTeamTimeSheets +
        authProvider.uSerProvider.userDetails!.user.userId.toString();

    try {
      final response = await dio.get(url,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization":
                "Bearer ${authProvider.uSerProvider.userDetails!.token}"
          }));
      Logger().i(response.statusCode);

      if (response.statusCode == 200) {
        var object =
            GetTeamTimeSheetResponseModel.fromJson(jsonDecode(response.data));
        Logger().v(object.toJson());
        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        Logger().v(exception.response!.data);

        // var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        // var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(msg: exception.response!.data['message']);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<bool> updateTimeSheet(UpdateTimeSheetPostModel params) async {
    String url = AppUrl.baseUrl +
        AppUrl.updateTimeSheets +
        params.timesheet_id.toString();

    var data = {"timesheet_status_id": params.timesheet_status_id};

    try {
      final response = await dio.put(url,
          data: data,
          options: Options(headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization":
                "Bearer ${authProvider.uSerProvider.userDetails!.token}"
          }));
      Logger().i('This is status code');
      Logger().i(response.statusCode);

      if (response.statusCode == 200) {
        return true;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        Logger().i('is something wrong');
        Logger().v(exception.response!.data);

        ErrorResponseModel errorResponseModel =
            ErrorResponseModel(msg: exception.response!.data['message']);

        ShowSnackBar.show(errorResponseModel.msg.toString());

        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }
}
