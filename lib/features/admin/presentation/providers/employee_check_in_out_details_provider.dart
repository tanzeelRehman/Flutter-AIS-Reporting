// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:ais_reporting/core/utils/enums/attendence_type.dart';
import 'package:ais_reporting/features/admin/data/model/attendence_details_request_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';
import '../../../dashboard/presentation/manager/dashboard_provider.dart';
import '../../data/model/attendence_details_response_model.dart';
import '../../domain/use_cases/admin_use_cases.dart';

class EmployeeCheckInOutDetailsProvider extends ChangeNotifier {
  EmployeeCheckInOutDetailsProvider({
    required this.getAttendenceDetailsUsecase,
  });

  //! Usecases
  GetAttendenceDetailsUsecase getAttendenceDetailsUsecase;

  ///! Providers
  DashboardProvider dashboardProvider = sl();

  /// Variables
  String selectedCheckInOutTiming = AttendenceType.checkIn.name;

  /// Value Notifiers
  ValueNotifier<DateTime> checkInOutStartdate =
      ValueNotifier(DateTime.now().subtract(const Duration(days: 10)));

  ValueNotifier<DateTime> checkInOutEnddate =
      ValueNotifier(DateTime.now().copyWith(hour: 23, minute: 59, second: 59));

  bool startdatePicked = false;
  bool enddatePicked = false;

  ValueNotifier<bool> fetchingAttendence = ValueNotifier(false);
  late ValueNotifier<List<AttendenceData>> queryAttendenceList;
  AttendenceDetailsResponseModel? attendenceDetailsResponseModel;

  Future<void> getAttendenceDetails() async {
    AttendenceDetailsRequestModel queryparms = AttendenceDetailsRequestModel(
        startDate: checkInOutStartdate.value.toString(),
        endDate: checkInOutEnddate.value
            .copyWith(hour: 23, minute: 59, second: 59)
            .toString(),
        userId: dashboardProvider.userProvider.userDetails!.user.userId,
        deptId: dashboardProvider.userProvider.userDetails!.departmentId,
        designationId:
            dashboardProvider.userProvider.userDetails!.designationId,
        roleId: dashboardProvider.userProvider.userDetails!.roleId);
    print(queryparms.startDate);
    print(queryparms.endDate);
    // print(queryparms.userId);
    // print(queryparms.deptId);
    // print(queryparms.designationId);
    // print(queryparms.roleId);
    fetchingAttendence.value = true;
    var attendenceDetailsEither =
        await getAttendenceDetailsUsecase.call(queryparms);
    if (attendenceDetailsEither.isLeft()) {
      handleError(attendenceDetailsEither);
      fetchingAttendence.value = false;
    } else if (attendenceDetailsEither.isRight()) {
      attendenceDetailsEither.foldRight(null, (r, previous) {
        attendenceDetailsResponseModel = r;

        fetchingAttendence.value = false;
        queryAttendenceList =
            ValueNotifier(attendenceDetailsResponseModel!.data);
      });
      fetchingAttendence.value = false;
    }
  }

  ///?=============================================================================================
  //!-------------------------------------------------------------------------------------------------
  /// Local Methods
  //!---------------------------------------------------------------------------------------------
  //?===========================================================================================
  void queryPersonsNames(String query) {
    List<AttendenceData> result = [];
    fetchingAttendence.value = true;

    if (query.isEmpty) {
      queryAttendenceList.value = attendenceDetailsResponseModel!.data;
      fetchingAttendence.value = false;
      return;
    }
    for (var name in attendenceDetailsResponseModel!.data) {
      if (name.fullName.toLowerCase().contains(query.toLowerCase())) {
        result.add(name);
      }
    }

    queryAttendenceList.value = result;
    fetchingAttendence.value = false;
  }

  void selectCheckInOutStartDate(BuildContext context) async {
    startdatePicked = false;

    DateTime? date = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: ThemeData(
                  appBarTheme: AppBarTheme(color: ColorsStyles.primaryColor),
                  canvasColor: ColorsStyles.canvasColor,
                  colorScheme:
                      ColorScheme.dark(primary: ColorsStyles.primaryColor)
                          .copyWith(background: ColorsStyles.canvasColor)),
              child: child!);
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(5000));

    if (date != null) {
      checkInOutStartdate.value = date;
      startdatePicked = true;
      getAttendenceDetails();
    }
  }

  void selectCheckInOutEndDate(BuildContext context) async {
    enddatePicked = false;

    DateTime? date = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: ThemeData(
                  appBarTheme: AppBarTheme(color: ColorsStyles.primaryColor),
                  canvasColor: ColorsStyles.canvasColor,
                  colorScheme:
                      ColorScheme.dark(primary: ColorsStyles.primaryColor)
                          .copyWith(background: ColorsStyles.canvasColor)),
              child: child!);
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(5000));
    if (date != null) {
      checkInOutEnddate.value = date;
      enddatePicked = true;
      getAttendenceDetails();
    }
  }

  void toogleselectedCheckInOutTiming() {
    if (selectedCheckInOutTiming == AttendenceType.checkOut.toString()) {
      selectedCheckInOutTiming = AttendenceType.checkIn.name;
    } else {
      selectedCheckInOutTiming = AttendenceType.checkOut.name;
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
