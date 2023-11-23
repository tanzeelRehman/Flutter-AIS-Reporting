import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/features/dashboard/data/models/upload_status_request_model.dart';
import 'package:ais_reporting/features/dashboard/data/models/upload_status_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../authentication/login/data/modals/login_response_modal.dart';
import '../../data/models/get_status_response_model.dart';

abstract class DashboardRepository {

  Future<Either<Failure, UploadStatusResponseModel>> uploadStatus(UploadStatusRequestModel params);
  Future<Either<Failure, GetStatusResponseModel>> getStatus(String params);


}