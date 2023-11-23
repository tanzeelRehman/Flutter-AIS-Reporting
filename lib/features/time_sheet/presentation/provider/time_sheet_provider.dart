import 'dart:ffi';

import 'package:ais_reporting/core/error/failures.dart';
import 'package:ais_reporting/core/modals/error_response_model.dart';
import 'package:ais_reporting/core/modals/no_params.dart';
import 'package:ais_reporting/core/utils/globals/globals.dart';
import 'package:ais_reporting/core/utils/globals/snack_bar.dart';
import 'package:ais_reporting/core/utils/theme/color_style.dart';
import 'package:ais_reporting/features/authentication/login/presentation/manager/auth_provider.dart';
import 'package:ais_reporting/features/time_sheet/data/model/getAllProjectsResponseModel.dart';
import 'package:ais_reporting/features/time_sheet/data/model/get_all_timesheet.dart';
import 'package:ais_reporting/features/time_sheet/data/model/get_team_timesheet_response_model.dart';
import 'package:ais_reporting/features/time_sheet/data/model/time_sheet_details_post_model.dart';
import 'package:ais_reporting/features/time_sheet/data/model/update_timesheet_post_model.dart';
import 'package:ais_reporting/features/time_sheet/domain/usecases/time_sheet_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../data/model/timeline_projects_list_model.dart';

class TimeSheetProvider extends ChangeNotifier {
  TimeSheetProvider(
      this.getAllProjectsUsecase,
      this.addUserTimeSheetUsecase,
      this.getAllTimeSheetUsecase,
      this.getteamTimeSheetUsecase,
      this.updateTimeSheetUsecase);

  /// UseCases
  final GetAllProjectsUsecase getAllProjectsUsecase;
  final AddUserTimeSheetUsecase addUserTimeSheetUsecase;
  final GetAllTimeSheetUsecase getAllTimeSheetUsecase;
  final GetTeamTimeSheetUsecase getteamTimeSheetUsecase;
  final UpdateTimeSheetUsecase updateTimeSheetUsecase;

  // Loaders
  ValueNotifier<bool> projectsLoading = ValueNotifier(false);
  ValueNotifier<bool> timeSheetsLoading = ValueNotifier(false);
  ValueNotifier<bool> teamProjectsLoading = ValueNotifier(false);

  // Objects
  GetAllProjectsResponseModel? getAllProjectsResponseModel;
  GetAllTimeSheets? getAllTimeSheetsResponseModel;
  GetTeamTimeSheetResponseModel? getTeamTimeSheetResponseModel;
  GetTeamTimeSheetResponseModel? getTeamTimeSheetDisplayResponseModel;
  late TimeSheetDetailsPostModel
      timeSheetDetailsPostModel; // POST TimeSheet  object [will store all timesheets details to post it to DB]

  /// Properties
  String selectedProject = '';
  DateTime weekStartDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime weekEndDate = DateTime.now();
  Map<String, int> allProjectsMap = {}; // see line 168 for explaination
  int tableColumnHeight = 0; // on timeSheet page
  int totalhours = 0; // Total hours a user had added in time sheet per day
  bool timeSheetListRowIsEmpty = true;
  int day = 0;

  // providers
  AuthProvider authProvider = sl();

  Future<void> getAllProjects() async {
    projectsLoading.value = true;

    var allProjectsEither = await getAllProjectsUsecase(NoParams());
    if (allProjectsEither.isLeft()) {
      handleError(allProjectsEither);
      projectsLoading.value = false;

      notifyListeners();
    } else if (allProjectsEither.isRight()) {
      allProjectsEither.foldRight(null, (r, previous) {
        getAllProjectsResponseModel = r;
        populateProjectsAndId(getAllProjectsResponseModel!.response);
        initilizeData();
      });
      projectsLoading.value = false;
    }
  }

  // Return Timesheets of specific user
  Future<void> getAllTimeSheets() async {
    timeSheetsLoading.value = true;

    var allProjectsEither = await getAllTimeSheetUsecase.call(NoParams());
    if (allProjectsEither.isLeft()) {
      handleError(allProjectsEither);
      timeSheetsLoading.value = false;
      print('false resz');
      notifyListeners();
    } else if (allProjectsEither.isRight()) {
      allProjectsEither.foldRight(null, (r, previous) {
        getAllTimeSheetsResponseModel = r;
        timeSheetsLoading.value = false;
        Logger().i(getAllTimeSheetsResponseModel!.toJson());
      });
    }
  }

  // Get timesheets of all team members [This call call when role is manager or admin]
  Future<void> getTeamTimeSheets() async {
    teamProjectsLoading.value = true;

    var allProjectsEither = await getteamTimeSheetUsecase.call(NoParams());
    if (allProjectsEither.isLeft()) {
      handleError(allProjectsEither);
      teamProjectsLoading.value = false;
      print('false resz');
      notifyListeners();
    } else if (allProjectsEither.isRight()) {
      allProjectsEither.foldRight(null, (r, previous) {
        getTeamTimeSheetResponseModel = r;
        getTeamTimeSheetDisplayResponseModel =
            GetTeamTimeSheetResponseModel.fromJson(
                getTeamTimeSheetResponseModel!.toJson());
        teamProjectsLoading.value = false;
        Logger().i(getTeamTimeSheetResponseModel!.toJson());
      });
    }
  }

  // Edit user added timesheet Object
  Future<void> updateTimeSheets(int timeSheetid, int timeSheetStatusId) async {
    UpdateTimeSheetPostModel updateTimeSheetPostModel =
        UpdateTimeSheetPostModel(
            timesheet_status_id: timeSheetStatusId, timesheet_id: timeSheetid);

    var allProjectsEither =
        await updateTimeSheetUsecase.call(updateTimeSheetPostModel);
    if (allProjectsEither.isLeft()) {
      handleError(allProjectsEither);
      teamProjectsLoading.value = false;

      notifyListeners();
    } else if (allProjectsEither.isRight()) {
      allProjectsEither.foldRight(null, (r, previous) {
        if (r) {
          ShowSnackBar.show('Time sheet updated');
          getTeamTimeSheets();
        }
      });
    }
  }

  // Upload all timesheets at backend
  Future<void> saveTimeSheet() async {
    Logger().i(weekStartDate.toIso8601String());
    Logger().i(weekEndDate.toIso8601String());

    // Check if difference between week start date and end date is equal to 7,(Start date and end date should be included in the count)
    if (weekStartDate.difference(weekEndDate).inDays.abs() + 2 != 7) {
      ShowSnackBar.show(
          'Difference from start date and end date should be equal to 7');
      return;
    }
    var allProjectsEither =
        await addUserTimeSheetUsecase(timeSheetDetailsPostModel);
    if (allProjectsEither.isLeft()) {
      handleError(allProjectsEither);
    } else if (allProjectsEither.isRight()) {
      allProjectsEither.foldRight(null, (r, previous) {
        if (r) {
          timeSheetDetailsPostModel.timesheetEntries.clear();
          ShowSnackBar.show('Time Sheet Sucessfully added');
          getAllTimeSheets();
        } else {}
      });
    }
    notifyListeners();
  }

  /*
  Extracting all projects name with their id from AllProjectsResponse object
  and add it in allProjectsMap, key:projectname value:projectId

  we will use this map to show in dropdown manu to show all projects and 
  when user will select any project it will save its id 
  */
  void populateProjectsAndId(List<AllProjectsResponse> allProjectsResponse) {
    for (var e in allProjectsResponse) {
      allProjectsMap.putIfAbsent(e.title, () => e.id);
    }

    selectedProject = allProjectsMap.keys.first;
    notifyListeners();
  }

  void setWeekStartDate(DateTime startdate) {
    weekStartDate = startdate;
    timeSheetDetailsPostModel.weekStartDate = weekStartDate.toIso8601String();
    notifyListeners();
  }

  void setSelectedProject(String project) {
    selectedProject = project;
    Logger().i(selectedProject);
    notifyListeners();
  }

  void setWeekEndDate(DateTime enddate) {
    weekEndDate = enddate;
    timeSheetDetailsPostModel.weekEndDate = weekEndDate.toIso8601String();
    notifyListeners();
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) => ShowSnackBar.show(l.message), (r) => null);
  }

  // List<Map> newRowsStateData = [];

  // initilizing timesheet Object
  Future<void> initilizeData() async {
    timeSheetDetailsPostModel = TimeSheetDetailsPostModel(
        userId: authProvider.uSerProvider.userDetails!.user.userId.toString(),
        weekStartDate: weekStartDate.toIso8601String(),
        weekEndDate: weekEndDate.toIso8601String(),
        timesheetEntries: [
          // TimesheetEntries(
          //     workDate: weekStartDate.toIso8601String(),
          //     workDetails: [
          //       WorkDetails(projectId: 1, hours: 0),
          //     ])
        ]);
  }

  // Days duration between week start date and end date in timesheet
  int getDaysDuration() {
    int diff = weekStartDate.difference(weekEndDate).inDays;
    Logger().i(diff);
    Logger().i(weekStartDate.difference(weekEndDate).inDays.abs() + 2);
    if (diff.abs() >= 7) {
      return diff.abs();
    } else {
      return diff.abs() + 1;
    }
  }

  // Adding  data in timesheet object
  void addNewRows(String projectName, String date, int hours, int dayIndex,
      bool editList, int parentIndex, String des) {
    bool alreadyAdded = false; // see line 278 for explaination
    timeSheetListRowIsEmpty = false;

    Logger().i('index details');
    Logger().i('parent $parentIndex');
    Logger().i('child $dayIndex');
    Logger().i('hours $hours');
    Logger().i('project $projectName');
    Logger().i('date $date');

    // if editlist is true it means user is editing already added data
    if (editList) {
      // User is not allow to add more then 24 hours of work per day
      //* checkNoofhours() function is not working properly, so you need to debug it; Good luck 🤓
      if (checkNoofhours(parentIndex)) {
        ShowSnackBar.show('You can not add more then 24 hours a day');
        return;
      }
      timeSheetDetailsPostModel
          .timesheetEntries[parentIndex].workDetails[dayIndex] = WorkDetails(
        projectId: allProjectsMap[projectName]!,
        hours: hours,
        description: des,
      );
      notifyListeners();
      return;
    }
    // if editlist is false it means user is adding data for first time
    for (var i = 0;
        i < timeSheetDetailsPostModel.timesheetEntries.length;
        i++) {
      if (timeSheetDetailsPostModel.timesheetEntries[i].workDate == date) {
        /*
        alreadyAdded variable tells the user that on this date [comming from frontend] projects is already added
        if projects is already added under the date it will add new rows under that date

        if not then it will make new instance 
        */
        alreadyAdded = true;

        if (checkNoofhours(i)) {
          ShowSnackBar.show('You can not add more then 24 hours a day');

          return;
        }
        timeSheetDetailsPostModel.timesheetEntries[i].workDetails.add(
            WorkDetails(
                projectId: allProjectsMap[projectName]!,
                hours: hours,
                description: des));
        notifyListeners();
        return;
      }
    }
    if (!alreadyAdded) {
      Logger().i('new data');
      List<WorkDetails> workDeatils = [
        WorkDetails(
          projectId: allProjectsMap[projectName]!,
          hours: hours,
          description: des,
        )
      ];

      if (editList) {
        timeSheetDetailsPostModel.timesheetEntries[parentIndex] =
            TimesheetEntries(
                workDate: timeSheetDetailsPostModel
                    .timesheetEntries[parentIndex].workDate,
                workDetails: workDeatils);
      } else {
        timeSheetDetailsPostModel.timesheetEntries
            .add(TimesheetEntries(workDate: date, workDetails: workDeatils));
      }
    }

    Logger().i(timeSheetDetailsPostModel.toJson());

    notifyListeners();
  }

  bool checkNoofhours(int index) {
    for (var workDetail
        in timeSheetDetailsPostModel.timesheetEntries[index].workDetails) {
      if (workDetail.hours >= 23) {
        Logger().i('hours exceeded');
        return true;
      }
    }

    Logger().i('$totalhours hours not exceeded');
    return false;
  }

  // Delete complete timesheet object with all the projects inside
  void deleteEntry(int index, int parentIndex) {
    Logger().i('Index to be removed');
    Logger().i(index);
    totalhours -
        timeSheetDetailsPostModel
            .timesheetEntries[parentIndex].workDetails[index].hours;
    Logger().i(totalhours);
    timeSheetDetailsPostModel.timesheetEntries[parentIndex].workDetails
        .removeAt(index);
    notifyListeners();
  }

  // Delete a single project under a time sheet entry
  void deleteRow(int index) {
    totalhours = 0;
    timeSheetDetailsPostModel.timesheetEntries.removeAt(index);
    notifyListeners();
  }

  // will used to get project id by giving it project name
  String getKeyFromValue(int targetValue) {
    // Iterate through the map entries
    for (var entry in allProjectsMap.entries) {
      if (entry.value == targetValue) {
        // Return the key when the value matches the targetValue
        return entry.key;
      }
    }
    // Return null if the target value is not found
    return '';
  }

  // Show status of time sheet, [These values are constant ]
  String getTeamTimeSheetStatus(int status) {
    switch (status) {
      case 1:
        return 'Pending';
      case 2:
        return 'Approved';
      case 3:
        return 'Rejected';
      default:
        return 'pending';
    }
  }

  Color getTeamTimeSheetStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  // Filter timesheets depending upoan status,
  void filterTimeSheetDisplay(String type) {
    if (type == 'all') {
      getTeamTimeSheetDisplayResponseModel!.response!.clear();
      getTeamTimeSheetDisplayResponseModel =
          GetTeamTimeSheetResponseModel.fromJson(
              getTeamTimeSheetResponseModel!.toJson());
    } else if (type == 'pending') {
      getTeamTimeSheetDisplayResponseModel!.response!.clear();
      for (var element in getTeamTimeSheetResponseModel!.response!) {
        Logger().i('looping');
        if (element.timesheetStatusId == 1) {
          getTeamTimeSheetDisplayResponseModel!.response!.add(element);
        }
      }
    } else if (type == 'accepted') {
      getTeamTimeSheetDisplayResponseModel!.response!.clear();
      for (var element in getTeamTimeSheetResponseModel!.response!) {
        Logger().i('looping');
        if (element.timesheetStatusId == 2) {
          getTeamTimeSheetDisplayResponseModel!.response!.add(element);
        }
      }
    } else if (type == 'rejected') {
      Logger().i('in rejected');
      getTeamTimeSheetDisplayResponseModel!.response!.clear();
      for (var element in getTeamTimeSheetResponseModel!.response!) {
        Logger().i('looping');
        if (element.timesheetStatusId == 3) {
          getTeamTimeSheetDisplayResponseModel!.response!.add(element);
        }
      }
    } else {
      getTeamTimeSheetDisplayResponseModel!.response!.clear();
      getTeamTimeSheetDisplayResponseModel =
          GetTeamTimeSheetResponseModel.fromJson(
              getTeamTimeSheetResponseModel!.toJson());
    }

    notifyListeners();
  }
}
