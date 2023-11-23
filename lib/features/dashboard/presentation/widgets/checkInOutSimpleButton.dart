import 'package:flutter/material.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:ais_reporting/features/dashboard/presentation/manager/dashboard_provider.dart';

import '../../../../core/services/location_services.dart';
import '../../../../core/utils/globals/snack_bar.dart';
import '../../../../core/utils/theme/color_style.dart';

class CheckInOutSimpleButton extends StatefulWidget {
  DateTime? checkInOutTime;

  CheckInOutSimpleButton({
    this.checkInOutTime,
  });
  @override
  State<CheckInOutSimpleButton> createState() => _CheckInOutSimpleButtonState();
}

class _CheckInOutSimpleButtonState extends State<CheckInOutSimpleButton> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width * 0.7);
    return GestureDetector(
        onTap: () async {
          try {
            final result = await LocationApi.determinePosition();
            print('this is the lat,lng $result');
            context.read<DashboardProvider>().gpsLatController.text =
                result.latitude.toString();
            context.read<DashboardProvider>().gpsLngController.text =
                result.longitude.toString();

            /// If datetime is not provided, it means we are performing automatic [checkIn/Out]
            // await context
            //     .read<DashboardProvider>()
            //     .uploadStatus(widget.checkInOutTime ?? DateTime.now());
          } catch (e) {
            ShowSnackBar.show(e.toString());
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: ColorsStyles.primaryColor,
              borderRadius: BorderRadius.circular(30)),
          width: 220,
          height: 55.h,
          child: context.read<DashboardProvider>().isClosed
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 35.0,
                      width: 35.0,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              : Consumer<DashboardProvider>(builder: (_, provider, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!provider.animationController.isAnimating)
                        Text(
                          provider.lastType == 'Check-Out'
                              ? "Check-In"
                              : 'Check-Out',
                          style: ColorsStyles.heading1.copyWith(fontSize: 15),
                        ),
                      // AnimatedCrossFade(
                      //     firstChild: const SizedBox.shrink(),
                      //     secondChild: Text(
                      //       provider.lastType == 'Check-Out'
                      //           ? "CheckIn"
                      //           : 'CheckOut',
                      //       style: ColorsStyles.heading1.copyWith(fontSize: 14),
                      //     ),
                      //     crossFadeState: CrossFadeState.showSecond,
                      //     duration: const Duration(milliseconds: 450))
                      // SizedBox(
                      //   width: 70,
                      //   child:
                      // )
                    ],
                  );
                }),
        ));
  }
}
