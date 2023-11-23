// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ais_reporting/core/error/failures.dart';
import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/features/admin/data/model/team_leave_requests_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:ais_reporting/features/admin/domain/use_cases/admin_use_cases.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Adminprovider extends ChangeNotifier {
  Adminprovider({
    required this.getLeaveRequestsUsecase,
  });

  //! Usecase
  GetLeaveRequestsUsecase getLeaveRequestsUsecase;

  //! Valuenotifiers
  ValueNotifier<bool> gettingTeamLeaveRequests = ValueNotifier(false);

  //! Response Models
  TeamLeaveRequestsResponseModel? teamLeaveRequestsResponseModel;

  Future<void> getTeamLeaveRequests() async {
    gettingTeamLeaveRequests.value = true;
    var attendenceDetailsEither =
        await getLeaveRequestsUsecase.call(NoParams());
    if (attendenceDetailsEither.isLeft()) {
      handleError(attendenceDetailsEither);
      gettingTeamLeaveRequests.value = false;
    } else if (attendenceDetailsEither.isRight()) {
      attendenceDetailsEither.foldRight(null, (r, previous) {
        teamLeaveRequestsResponseModel = r;

        gettingTeamLeaveRequests.value = false;
      });
      gettingTeamLeaveRequests.value = false;
    }
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    either.fold(
        (l) => Fluttertoast.showToast(
            msg: l.toString(), backgroundColor: Colors.redAccent),
        (r) => null);
  }
}
