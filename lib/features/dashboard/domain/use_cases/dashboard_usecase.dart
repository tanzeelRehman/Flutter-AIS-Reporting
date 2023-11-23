import 'package:ais_reporting/core/usecases/usecase.dart';
import 'package:ais_reporting/features/dashboard/data/models/upload_status_request_model.dart';
import 'package:ais_reporting/features/dashboard/data/models/upload_status_response_model.dart';
import 'package:ais_reporting/features/dashboard/domain/repositories/dashboard_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/modals/no_params.dart';
import '../../data/models/get_status_response_model.dart';

class UploadStatusUsecase extends UseCase<UploadStatusResponseModel, UploadStatusRequestModel> {
  DashboardRepository repository;
  UploadStatusUsecase(this.repository);

  @override
  Future<Either<Failure, UploadStatusResponseModel>> call(UploadStatusRequestModel params) async {
    return await repository.uploadStatus(params);
  }
}

class GetStatusUsecase extends UseCase<GetStatusResponseModel, String> {
  DashboardRepository repository;
  GetStatusUsecase(this.repository);

  @override
  Future<Either<Failure, GetStatusResponseModel>> call(String params) async {
    return await repository.getStatus(params);
  }
}