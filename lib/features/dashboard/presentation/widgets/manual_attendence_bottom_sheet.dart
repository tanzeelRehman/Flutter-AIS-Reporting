// ignore_for_file: avoid_print

import 'package:ais_reporting/core/widgets/custom/pick_date_container_field.dart';
import 'package:ais_reporting/features/dashboard/presentation/manager/dashboard_provider.dart';
import 'package:ais_reporting/features/dashboard/presentation/widgets/checkInOutbutton.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';

class ManualAttendenceBottomSheet extends StatefulWidget {
  const ManualAttendenceBottomSheet({super.key});

  @override
  State<ManualAttendenceBottomSheet> createState() =>
      _ManualAttendenceBottomSheetState();
}

class _ManualAttendenceBottomSheetState
    extends State<ManualAttendenceBottomSheet> {
  //! Providers
  DashboardProvider dashboardProvider = sl();

  TimeOfDay timeToDisplayOnField = TimeOfDay.now();

  @override
  void dispose() {
    timeToDisplayOnField = TimeOfDay.now();
    dashboardProvider.manualSelectedtime.value = DateTime.now();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: dashboardProvider,
      builder: ((context, child) => child!),
      child: Container(
        decoration: ColorsStyles.roundedContainerDecoration
            .copyWith(color: ColorsStyles.canvasColor),
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Text(
              "Add Attendence",
              style: ColorsStyles.heading1.copyWith(fontSize: 25),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 20.h,
            ),
            ValueListenableBuilder(
                valueListenable: dashboardProvider.checkInOutDateNotifier,
                builder: ((context, value, child) {
                  return PickDateContainerField(
                    style: ColorsStyles.subtitle1
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                    ontap: () async {
                      dashboardProvider.selectCheckInOutDate(context);
                    },
                    text: DateFormat('dd-MM-yyyy')
                        .format(dashboardProvider.checkInOutDateNotifier.value),
                  );
                })),
            SizedBox(
              height: 20.h,
            ),
            ValueListenableBuilder(
                valueListenable: dashboardProvider.manualSelectedtime,
                builder: ((context, value, child) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        showPicker(
                            okStyle: ColorsStyles.subtitle1
                                .copyWith(color: ColorsStyles.primaryColor),
                            okText: "Select",
                            cancelStyle: ColorsStyles.subtitle1
                                .copyWith(color: ColorsStyles.primaryColor),
                            blurredBackground: true,
                            context: context,
                            accentColor: ColorsStyles.primaryColor,
                            themeData: ThemeData(
                              scaffoldBackgroundColor: Colors.transparent,
                              cardColor: ColorsStyles.canvasColor,
                              // colorScheme:
                              //     ColorScheme(background: Colors.transparent, brightness: Brightness.dark, primary: Colors.transparent),
                            ),
                            value: Time(
                              hour: dashboardProvider
                                  .manualSelectedtime.value.hour,
                              minute: dashboardProvider
                                  .manualSelectedtime.value.minute,
                            ),
                            onChange: ((p0) {}),
                            minuteInterval: TimePickerInterval.FIVE,
                            // Optional onChange to receive value as DateTime
                            onChangeDateTime: (DateTime dateTime) {
                              dashboardProvider.manualSelectedtime.value =
                                  dateTime;
                              timeToDisplayOnField =
                                  TimeOfDay.fromDateTime(dateTime);
                            }),
                      );
                    },
                    child: Container(
                      decoration: ColorsStyles.roundedContainerDecoration,
                      height: 55,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.hourglass_bottom,
                            color: ColorsStyles.primaryColor,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            timeToDisplayOnField.format(context),
                            style: ColorsStyles.subtitle1.copyWith(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
            SizedBox(
              height: 25.h,
            ),
            ValueListenableBuilder(
              valueListenable: dashboardProvider.manualSelectedtime,
              builder: (context, value, child) {
                return CheckInOutButton(
                    dateTime: DateTime(
                        dashboardProvider.checkInOutDateNotifier.value.year,
                        dashboardProvider.checkInOutDateNotifier.value.month,
                        dashboardProvider.checkInOutDateNotifier.value.day,
                        dashboardProvider.manualSelectedtime.value.hour,
                        dashboardProvider.manualSelectedtime.value.minute,
                        dashboardProvider.manualSelectedtime.value.second));
              },
            )
          ],
        ),
      ),
    );
  }

  // void submitMannualCheckInOut(BuildContext context) async {
  //   try {
  //     if () {

  //     }
  //     final result = await LocationApi.determinePosition();
  //     print('this is the lat,lng $result');
  //     dashboardProvider.gpsLatController.text = result.latitude.toString();
  //     dashboardProvider.gpsLngController.text = result.longitude.toString();
  //     dashboardProvider
  //         .uploadStatus(
  //             dashboardProvider.lastType == 'Check-Out'
  //                 ? 'checkIn'
  //                 : 'checkOut',
  //             dashboardProvider.manualSelectedtime.value)
  //         .then((value) => {Navigator.pop(context)});
  //   } catch (e) {
  //     ShowSnackBar.show(e.toString());
  //   }
  // }
}
