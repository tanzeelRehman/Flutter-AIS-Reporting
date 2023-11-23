import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/modals/login_request_model.dart';
import '../../data/modals/login_response_modal.dart';

abstract class AuthRepository {

  Future<Either<Failure, LoginResponseModel>> loginUser(LoginRequestModel params);


}
