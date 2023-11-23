// ignore_for_file: non_constant_identifier_names

import 'package:ais_reporting/core/services/auth_services.dart';
import 'package:ais_reporting/core/services/user_provider.dart';
import 'package:ais_reporting/features/authentication/login/presentation/manager/auth_provider.dart';
import 'package:ais_reporting/features/dashboard/data/models/get_status_response_model.dart';
import 'package:ais_reporting/features/dashboard/data/models/upload_status_request_model.dart';
import 'package:ais_reporting/features/dashboard/data/models/upload_status_response_model.dart';
import 'package:ais_reporting/features/dashboard/domain/use_cases/dashboard_usecase.dart';
import 'package:ais_reporting/features/time_sheet/presentation/screens/time_sheet_page.dart';
import 'package:dartz/dartz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:logger/logger.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/modals/on_error_message_model.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';
import '../pages/all_checkin_page.dart';
import '../pages/attendance_page.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider(this.uploadStatusUsecase, this.getStatusUsecase);

  ///?=============================================================================================
  //!-------------------------------------------------------------------------------------------------
  /// Local Properties
  //!---------------------------------------------------------------------------------------------
  //?===========================================================================================

  /// Screens List
  List<Widget> pages = [
    const AttendencePage(),
    TimeSheetPage(),
  ];

  /// Controllers
  late AnimationController animationController;
  final PageController pageController = PageController();

  /// Valuenotifiers
  ValueNotifier<int> currentPageIndexNotifier = ValueNotifier(0);
  ValueNotifier<DateTime> manualSelectedtime = ValueNotifier(DateTime.now());
  ValueNotifier<bool> isUploadingStatusLoadingCheck = ValueNotifier(false);
  ValueNotifier<bool> firstTimeUSer = ValueNotifier(false);
  ValueNotifier<bool> isUploadingStatusLoadingCheck2 = ValueNotifier(false);
  ValueNotifier<bool> isGotAllUsersListLoadingCheck = ValueNotifier(false);
  ValueNotifier<bool> isGotStatusLoadingCheck = ValueNotifier(false);
  ValueNotifier<File?> docsImgFile = ValueNotifier(null);
  ValueNotifier<String> dateTime = ValueNotifier(
      "${DateFormat('yyyy-MM-dd').format(DateTime.now())} 00:00:00");
  ValueNotifier<DateTime> checkInOutDateNotifier =
      ValueNotifier(DateTime.now());

  /// Text Editing Controllers
  final TextEditingController gpsLatController = TextEditingController();
  final TextEditingController gpsLngController = TextEditingController();

  /// Variables
  late bool isClosed = false; // Open/Close Check In/out button
  bool checkInOutDatePicked = false;
  bool disableCheckInOutbutton = false;
  //bool checkInOutCompleted = false;
  String Type = '';
  String msg = '';
  // XFile? selectedFile;
  String? checkImg;

  ///Button State  [Check In state] or [Check Out State]
  String lastType = '';
  String lastTime = '';
  String lastDate = '';
  DateTime lastTimeCompletedatetime = DateTime.now();
  DateTime date = DateTime.now();

  // Usecases
  UploadStatusUsecase uploadStatusUsecase;
  GetStatusUsecase getStatusUsecase;

  // Response Models
  UploadStatusResponseModel? uploadStatusResponseModel;
  GetStatusResponseModel? getStatusResponseModel;

  ValueChanged<OnErrorMessageModel>? onErrorMessage;

  // Providers
  AuthProvider authProvider = sl();
  UserProvider userProvider = sl();

  ///?=============================================================================================
  //!-------------------------------------------------------------------------------------------------
  /// API CALLS
  //!---------------------------------------------------------------------------------------------
  //?===========================================================================================

  //*--------------------------------------------------------------------------------------
  /// Submitting [ Check In/Out ] details
  //*-----------------------------------------------------------------------------------

  Future<void> uploadStatus(String type, DateTime dateTime) async {
    isUploadingStatusLoadingCheck.value = true;
    // print("Real DATE IS");
    // print(DateTime.now());
    // print("ACTUAL DATE IS");
    // print(DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime));

    var params = UploadStatusRequestModel(
        userId: userProvider.userDetails!.user.userId.toString(),
        channel: '9890',
        time: DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime),
        image: "",
        type: type,
        latitute: gpsLatController.text,
        longitude: gpsLngController.text);
    var loginEither = await (uploadStatusUsecase.call(params));
    if (loginEither.isLeft()) {
      handleError(loginEither);
      await turnOffCheckInOutButtonLoading();
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (response, login) {
        uploadStatusResponseModel = response;

        getStatus();

        notifyListeners();
      });
      isUploadingStatusLoadingCheck.value = false;
    }
  }

  //*--------------------------------------------------------------------------------------
  /// Getting User [ Check In/Out ] Status
  //*-----------------------------------------------------------------------------------
  Future<void> getStatus() async {
    print("getting sttaus");
    isUploadingStatusLoadingCheck.value = true;
    var params = userProvider.userDetails!.user.userId.toString();
    var loginEither = await (getStatusUsecase.call(params));
    if (loginEither.isLeft()) {
      handleError(loginEither);
      await turnOffCheckInOutButtonLoading();
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (response, login) {
        getStatusResponseModel = response;
        Logger().v(getStatusResponseModel!.toJson());

        /// User is logged in for the [First Time]
        //* No Check in or Out Data is present
        if (getStatusResponseModel!.selfCheckOutDbResponse.isEmpty &&
            getStatusResponseModel!.selfCheckInDbResponse.isEmpty) {
          /// His[ date & time details are empty String
          lastTime = '';
          lastDate = '';

          /// After  logging in, It will see [Check-Out] button now
          lastType = 'Check-Out';
          firstTimeUSer.value = true;
          notifyListeners();
        }

        /// User is already  [Checked-In] and now need to [Check-out]
        if (getStatusResponseModel!.selfCheckInDbResponse.isNotEmpty &&
            getStatusResponseModel!.selfCheckOutDbResponse.isEmpty) {
          var dt = DateTime.parse(
              getStatusResponseModel!.selfCheckInDbResponse.last.time);
          lastTimeCompletedatetime = dt;
          lastTime = DateFormat('hh:mm a').format(dt);
          lastDate = DateFormat('yyyy-MM-dd').format(dt);
          print("CHANGINGGGGGG");
          print(lastTime);
          print(lastDate);
          lastType = 'Check-In';

          Logger().v('lastcheckin');
          notifyListeners();
        }

        /// User is   [Checked-Out] and need to [Check-In]
        if (getStatusResponseModel!.selfCheckInDbResponse.isEmpty &&
            getStatusResponseModel!.selfCheckOutDbResponse.isNotEmpty) {
          var dt = DateTime.parse(
              getStatusResponseModel!.selfCheckOutDbResponse.last.time);
          lastTimeCompletedatetime = dt;
          lastTime = DateFormat('hh:mm a').format(dt);
          lastDate = DateFormat('yyyy-MM-dd').format(dt);
          lastType = 'Check-Out';
          Logger().v('last check out');
          notifyListeners();
        }

        /// If user has both [Check Ins] & [Checkout] present in their databse
        /// This method will return [greatest] value, Which is based on the time
        /// for example if we have two times [2:10] & [4:10] it will return [4:10]

        if (getStatusResponseModel!.selfCheckInDbResponse.isNotEmpty &&
            getStatusResponseModel!.selfCheckOutDbResponse.isNotEmpty) {
          if (getStatusResponseModel!.selfCheckInDbResponse.last.createdAt
                  .compareTo(getStatusResponseModel!
                      .selfCheckOutDbResponse.last.createdAt) <
              0) {
            var dt = DateTime.parse(
                getStatusResponseModel!.selfCheckOutDbResponse.last.time);
            lastTimeCompletedatetime = dt;
            lastTime = DateFormat('hh:mm a').format(dt);
            lastDate = DateFormat('yyyy-MM-dd').format(dt);
            lastType = 'Check-Out';
            Logger().v('lastcheckout date');
            notifyListeners();
          } else {
            var dt = DateTime.parse(
                getStatusResponseModel!.selfCheckInDbResponse.last.time);
            lastTime = DateFormat('hh:mm a').format(dt);
            lastDate = DateFormat('yyyy-MM-dd').format(dt);
            lastType = 'Check-In';
            Logger().v('last checin date');
            Logger().i(lastType);
            notifyListeners();
          }
        }

        notifyListeners();

        isUploadingStatusLoadingCheck.value = false;
      });
      //isUploadingStatusLoadingCheck.value = false;
      //isUploadingStatusLoadingCheck.value = false;
    }
  }

  void logout(BuildContext context) {
    AuthServices authServices = sl();
    authServices.logoutUser(context);
  }

  //!-------------------------------------------------------------------------------------------------
  /// Local METHODS
  //!---------------------------------------------------------------------------------------------

  Future<void> turnOffCheckInOutButtonLoading() async {
    animationController.reverse();
    isClosed = false;
    isUploadingStatusLoadingCheck.value = false;
    notifyListeners();
  }

  void handleError(Either<Failure, dynamic> either) {
    either.fold(
        (l) => Fluttertoast.showToast(
            msg: l.message, backgroundColor: Colors.redAccent),
        (r) => null);
  }

  changePageIndex(int index) {
    currentPageIndexNotifier.value = index;
    if (index > 1) {
      pageController.animateToPage(index + 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutQuad);
    } else {
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutQuad);
    }
  }

  void selectCheckInOutDate(BuildContext context) async {
    checkInOutDatePicked = false;

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
        firstDate: DateTime.now().subtract(const Duration(days: 1)),
        lastDate: DateTime.now());
    if (date != null) {
      checkInOutDateNotifier.value = date;
      checkInOutDatePicked = true;
      // if (DateFormat('EEEE').format(date) == "Saturday" ||
      //     DateFormat('EEEE').format(date) == "Sunday") {
      //   ShowSnackBar.show("You cannot request leave on holiday");
      // } else {
      //   selectedSingleLaveDate.value = date;
      //   datePicked = true;
      // }
    }
  }

  bool isManagerOrAdmin() {
    switch (userProvider.userDetails?.designationId ?? 0) {
      case 3:
        return true;
      case 5:
        return true;
      case 6:
        return true;
      case 13:
        return true;
      case 25:
        return true;
      case 27:
        return true;
      case 30:
        return true;
      default:
        return false;
    }
  }
}
