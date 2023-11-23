import 'package:ais_reporting/features/dashboard/presentation/manager/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/location_services.dart';
import '../../../../core/utils/constants/app_assets.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';

class CheckInOutButton extends StatefulWidget {
  late double buttonWidth;
  DateTime dateTime;

  CheckInOutButton({
    super.key,
    this.buttonWidth = 120,
    required this.dateTime,
  });

  @override
  State<CheckInOutButton> createState() => _CheckInOutButtonState();
}

class _CheckInOutButtonState extends State<CheckInOutButton>
    with SingleTickerProviderStateMixin {
  DashboardProvider attendenceProvider = sl();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    attendenceProvider.animationController = AnimationController(
        lowerBound: 0,
        upperBound: 177,
        vsync: this,
        duration: const Duration(milliseconds: 450))
      ..addListener(() {
        //   print(attendenceProvider.animationController.value);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width * 0.7);
    return GestureDetector(
        onTap: () async {
          print("Selected Date time");
          print(widget.dateTime);
          bool locationPermissionIsOn =
              await LocationApi.checkAndRequestLocationPermission();
          if (locationPermissionIsOn) {
            upLoadSAttendence();
          } else {
            print("here");
            Fluttertoast.showToast(
                msg: "Please turn on your location",
                backgroundColor: Colors.redAccent);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: ColorsStyles.primaryColor,
                  gradient: LinearGradient(colors: [
                    ColorsStyles.primaryIsDark,
                    ColorsStyles.primaryColor
                  ]),
                  borderRadius: BorderRadius.circular(30)),
              width: (MediaQuery.of(context).size.width * 0.6) -
                  attendenceProvider.animationController.value,
              height: 55,
              child: attendenceProvider.isClosed
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 45.0,
                          width: 35.0,
                          child: Center(
                              child: Lottie.asset(
                                  height: 53.h, AppAssets.loaderWhite)),
                        ),
                      ],
                    )
                  : Consumer<DashboardProvider>(builder: (_, provider, __) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            provider.lastType == ''
                                ? 'Check-In'
                                : provider.lastType,
                            style: ColorsStyles.heading1.copyWith(fontSize: 14),
                          )
                        ],
                      );
                    }),
            ),
          ],
        ));
  }

  void upLoadSAttendence() async {
    try {
      attendenceProvider.isClosed = true;
      attendenceProvider.animationController.forward();
      final result = await LocationApi.determinePosition();
      print('this is the lat,lng $result');
      attendenceProvider.gpsLatController.text = result.latitude.toString();
      attendenceProvider.gpsLngController.text = result.longitude.toString();
      print("NEW DAT IS");
      print(widget.dateTime);
      await attendenceProvider
          .uploadStatus(
              attendenceProvider.lastType == 'Check-Out'
                  ? 'checkIn'
                  : 'checkOut',
              widget.dateTime)
          .then((value) => {
                attendenceProvider.animationController.reverse().then((value) =>
                    {
                      attendenceProvider.isClosed = false,
                      Navigator.pop(context)
                    }),
              });
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(), backgroundColor: Colors.redAccent);
    }
  }
}
