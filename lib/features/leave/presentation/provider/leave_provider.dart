import 'package:ais_reporting/core/router/app_state.dart';
import 'package:ais_reporting/core/utils/enums/leave_type.dart';
import 'package:ais_reporting/core/utils/globals/globals.dart';
import 'package:ais_reporting/features/authentication/login/presentation/manager/auth_provider.dart';
import 'package:ais_reporting/features/dashboard/presentation/manager/dashboard_provider.dart';
import 'package:ais_reporting/features/leave/data/models/post_leave_request_model.dart';
import 'package:ais_reporting/features/leave/data/models/post_leave_response_model.dart';

import 'package:ais_reporting/features/leave/domain/use_cases/leave_use_cases.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/globals/snack_bar.dart';
import '../../../../core/utils/theme/color_style.dart';
import '../../data/models/get_leave_quota_response_model.dart';
import '../../data/models/jobs_reassign_to_response_model.dart';

class LeaveProvider extends ChangeNotifier {
  LeaveProvider(this.getEmployeeListUsecase, this.getEmployeeLeaveQuotaUsecase,
      this.requestLeaveApplyUsecase);

  //! External
  AppState appState = sl();

  //! Usecases
  GetEmployeesListUsecase getEmployeeListUsecase;
  GetEmployeeLeaveQuotaUsecase getEmployeeLeaveQuotaUsecase;
  RequestLeaveApplyUsecase requestLeaveApplyUsecase;

  //! Providers
  DashboardProvider dashboardProvider = sl();
  AuthProvider authProvider = sl();

  //* Leave types
  //! Value Notifiers
  ValueNotifier cusualLeaveSelected = ValueNotifier(true);
  ValueNotifier medicalLeaveSelected = ValueNotifier(false);
  ValueNotifier bereavementLeaveSelected = ValueNotifier(false);
  ValueNotifier annualLeaveSelected = ValueNotifier(false);
  ValueNotifier marriageLeaveSelected = ValueNotifier(false);
  ValueNotifier maternityLeaveSelected = ValueNotifier(false);
  ValueNotifier paternityLeaveSelected = ValueNotifier(false);

  /// Date Time Range Propterties use for [Multiple Leaves]
  ValueNotifier<DateTimeRange> selectedLeaveDates =
      ValueNotifier(DateTimeRange(start: DateTime.now(), end: DateTime.now()));

  /// Date TimeProperty use for [Single Leave]
  ValueNotifier<DateTime> selectedSingleLaveDate =
      ValueNotifier(DateTime.now());

  /// personToAssignTaskSelected tells Select Person UI container to show the name of person
  /// if this is false, it will show hint to select Person
  ValueNotifier<bool> personToAssignTaskSelected = ValueNotifier(false);

  //! Variables
  /// datePicked tells datepick UI container to show the no of days / date
  /// if this is false, it will show hint to pick the date
  bool datePicked = false;
  bool multipleLeaveSelected = false;
  int noOfDaysForTheLeave = 0;

  /// LeaveType is an [Enum] containius all leave types
  Enum selectedLeaveType = LeaveType.Casual;

  //String selectedPersonToAssignWork = "";

  ///?=============================================================================================
  //!-------------------------------------------------------------------------------------------------
  /// API CALLS
  //!---------------------------------------------------------------------------------------------
  //?===========================================================================================

  //*----------------------------------------------------------------------------
  /// Get Employee [Leave Details] leave Quota
  //*----------------------------------------------------------------------------

  /// JobsReassignResponse
  late ValueNotifier<List<JobReAssignResponse>> queryNameList;
  JobReAssignToResponseModel? jobsReAssignResponseModel;

  //*----------------------------------------------------------------------------
  /// Get list of [Employees] to assign task
  //*----------------------------------------------------------------------------
  Future<void> getEmployees() async {
    var loginEither = await getEmployeeListUsecase.call("148");
    if (loginEither.isLeft()) {
      handleError(loginEither);
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (r, previous) {
        jobsReAssignResponseModel = r;
        print("data get");
        //print(jobsReAssignResponseModel!.toJson());

        queryNameList = ValueNotifier(jobsReAssignResponseModel!.response);
      });
    }
  }

  //*----------------------------------------------------------------------------
  /// Get Employee [Leave Details] leave Quota
  //*----------------------------------------------------------------------------

  ValueNotifier<bool> loadingEmployeeLeavesData = ValueNotifier(false);
  GetLeaveQuotaResponseModel? getLeaveQuotaResponseModel;

  ValueNotifier<bool> isNoInternet = ValueNotifier(false);

  Future<void> getEmployeeLeaveQuota() async {
    loadingEmployeeLeavesData.value = true;
    String empId = dashboardProvider.userProvider.userDetails!.user.employeeId;
    var leaveDataEither = await getEmployeeLeaveQuotaUsecase(empId);
    if (leaveDataEither.isLeft()) {
      handleError(leaveDataEither);
      leaveDataEither.fold((l) => noInternet(l), (r) => null);

      loadingEmployeeLeavesData.value = false;
    } else if (leaveDataEither.isRight()) {
      leaveDataEither.foldRight(null, (r, previous) {
        getLeaveQuotaResponseModel = r;
        loadingEmployeeLeavesData.value = false;
        isNoInternet.value = false;
      });
      loadingEmployeeLeavesData.value = false;
    }
  }

  ValueNotifier<bool> requestingLeave = ValueNotifier(false);
  PostLeaveResponseModel? postLeaveResponseModel;
  Future<void> applyForLeave({
    required String jobInHand,
    required String reason,
    required String leaveStartDate,
    required String leaveEndDate,
    int noOfDays = 1,
    int taskAssignto = 0,
  }) async {
    PostLeaveRequestModel params = PostLeaveRequestModel(
        jobInHand: jobInHand,
        justificationForLeave: reason,
        leaveStartDate: leaveStartDate,
        leaveEndDate: leaveEndDate,
        leaveTypeId: leaveTypeToLeaveId(selectedLeaveType),
        userId:
            dashboardProvider.userProvider.userDetails!.user.userId.toString(),
        no_of_days: noOfDays,
        taskReassignedTo: taskAssignto);
    Logger().e(params.toJson());
    requestingLeave.value = true;
    var postLeaveEither = await requestLeaveApplyUsecase.call(params);
    if (postLeaveEither.isLeft()) {
      handleError(postLeaveEither);
      requestingLeave.value = false;
    } else if (postLeaveEither.isRight()) {
      postLeaveEither.foldRight(null, (r, previous) {
        postLeaveResponseModel = r;
        requestingLeave.value = false;
        ShowSnackBar.show(
          postLeaveResponseModel!.msg,
        );
        appState.moveToBackScreen();
      });
      requestingLeave.value = false;
    }
  }

  ///?=============================================================================================
  //!-------------------------------------------------------------------------------------------------
  /// Local Methods
  //!---------------------------------------------------------------------------------------------
  //?===========================================================================================

  noInternet(Failure l) {
    if (l.message == 'No Internet') {
      isNoInternet.value = true;
    } else {
      isNoInternet.value = false;
      return;
    }
  }

  void queryPersonsNames(String query) {
    List<JobReAssignResponse> result = [];
    if (query.isEmpty) {
      queryNameList.value = jobsReAssignResponseModel!.response;
      return;
    }
    for (var name in jobsReAssignResponseModel!.response) {
      if (name.fullName.toLowerCase().contains(query.toLowerCase())) {
        result.add(name);
      }
    }
    queryNameList.value = result;
  }

  ///
  void makeAllLeavesFalse() {
    cusualLeaveSelected.value = false;
    bereavementLeaveSelected.value = false;
    annualLeaveSelected.value = false;
    medicalLeaveSelected.value = false;
    marriageLeaveSelected.value = false;
    maternityLeaveSelected.value = false;
    paternityLeaveSelected.value = false;
  }

  /// Will be used to select [Single Leave]
  void selectDateForSingleLeave(BuildContext context) async {
    datePicked = false;
    noOfDaysForTheLeave = 0; // To Start the calculation of levaes from 0
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
      if (DateFormat('EEEE').format(date) == "Saturday" ||
          DateFormat('EEEE').format(date) == "Sunday") {
        Fluttertoast.showToast(
            msg: "You cannot request leave on holiday",
            backgroundColor: ColorsStyles.primaryColor);
      } else {
        selectedSingleLaveDate.value = date;
        datePicked = true;
        noOfDaysForTheLeave = 1;
      }
    }
  }

  /// Will be used to select [Multiple Leaves]
  void selectDateRangeForLeave(BuildContext context) async {
    //datePicked = false;
    noOfDaysForTheLeave = 0; // To Start the calculation of levaes from 0
    final DateTimeRange? dateTimeRange = await showDateRangePicker(
        initialDateRange: datePicked
            ? DateTimeRange(
                start: selectedLeaveDates.value.start,
                end: selectedLeaveDates.value.end)
            : null,
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
        firstDate: DateTime(2023),
        lastDate: DateTime(5000));
    if (dateTimeRange != null) {
      selectedLeaveDates.value = dateTimeRange;

      /// This function determine that either their is a [ holiday ] betwwen leave Start date & End date
      /// If there is a holiday, It won't be counted it in leaves
      //? Levave from Thursday - Sunday will be counted as 2 days leave
      for (int i = 0; i <= selectedLeaveDates.value.duration.inDays; i++) {
        /// [ EEEE ] format tells the day on that day,
        /// for more info go on this link,
        /// https://stackoverflow.com/questions/58934390/how-to-get-the-current-day-in-flutter
        if (DateFormat('EEEE').format(
                    selectedLeaveDates.value.start.add(Duration(days: i))) ==
                "Saturday" ||
            DateFormat('EEEE').format(
                    selectedLeaveDates.value.start.add(Duration(days: i))) ==
                "Sunday") {
        } else {
          noOfDaysForTheLeave += 1;
        }
      }
      datePicked = true;
    }
  }

  void toogleMultipleLeaveSelected() {
    multipleLeaveSelected = !multipleLeaveSelected;
    notifyListeners();
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    either.fold(
        (l) => Fluttertoast.showToast(
            msg: l.toString(), backgroundColor: Colors.redAccent),
        (r) => null);
  }
}
