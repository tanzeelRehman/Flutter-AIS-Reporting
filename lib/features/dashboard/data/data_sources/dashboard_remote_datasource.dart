import 'dart:async';

import 'package:ais_reporting/core/utils/globals/snack_bar.dart';
import 'package:ais_reporting/features/dashboard/data/models/get_status_response_model.dart';
import 'package:ais_reporting/features/dashboard/data/models/upload_status_request_model.dart';
import 'package:ais_reporting/features/dashboard/data/models/upload_status_response_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/modals/error_response_model.dart';
import '../../../../core/utils/constants/app_messages.dart';
import '../../../../core/utils/constants/app_url.dart';

abstract class DashboardRemoteDataSource {
  Future<UploadStatusResponseModel> uploadStatus(
      UploadStatusRequestModel params);
  Future<GetStatusResponseModel> getStatus(String params);
}

class DashboardRemoteDataSourceImp implements DashboardRemoteDataSource {
  Dio dio;
  DashboardRemoteDataSourceImp({required this.dio});

  @override
  @override
  Future<UploadStatusResponseModel> uploadStatus(
      UploadStatusRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.uploadStatus;

    try {
      final response = await dio.post(url, data: params.toJson());
      Logger().v(params.toJson());
      // var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      // var jsonResponse = jsonDecode(decryptedResponse);

      if (response.statusCode == 200) {
        print('hello');
        var object = UploadStatusResponseModel.fromJson(response.data);

        // var object = GetPaymentRateListResponse.fromJson(jsonResponse);
        ShowSnackBar.show(object.message);

        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        // var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        // var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel.fromJson(exception.response?.data);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<GetStatusResponseModel> getStatus(String params) async {
    String url = AppUrl.baseUrl + AppUrl.getStatus + params;

    try {
      final response = await dio.get(url);

      // var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      // var jsonResponse = jsonDecode(decryptedResponse);

      if (response.statusCode == 200) {
        Logger().v(response.data);
        print('hello');
        var object = GetStatusResponseModel.fromJson(response.data);

        // var object = GetPaymentRateListResponse.fromJson(jsonResponse);
        //ShowSnackBar.show(object.message);
        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        // var decryptedResponse = Encryption.decryptObject(exception.response?.data['Text']);
        // var jsonResponse = jsonDecode(decryptedResponse);
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel.fromJson(exception.response?.data);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }
}
