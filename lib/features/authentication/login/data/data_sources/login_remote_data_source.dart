import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/modals/error_response_model.dart';
import '../../../../../core/utils/constants/app_messages.dart';
import '../../../../../core/utils/constants/app_url.dart';
import '../modals/login_request_model.dart';
import '../modals/login_response_modal.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> loginUser(LoginRequestModel params);
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  Dio dio;
  AuthRemoteDataSourceImp({required this.dio});

  @override
  Future<LoginResponseModel> loginUser(LoginRequestModel params) async {
    String url = AppUrl.baseUrl + AppUrl.loginUrl;

    try {
      final response = await dio.post(url, data: params.toJson());

      // var decryptedResponse = Encryption.decryptObject(response.data['Text']);
      // var jsonResponse = jsonDecode(decryptedResponse);

      if (response.statusCode == 200) {
        var object = LoginResponseModel.fromJson(response.data);

        // var object = GetPaymentRateListResponse.fromJson(jsonResponse);

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
}
