import 'package:ais_reporting/features/admin/presentation/providers/employee_check_in_out_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';

class AnimatedButtonSwitcher extends StatefulWidget {
  @override
  State<AnimatedButtonSwitcher> createState() => _AnimatedButtonSwitcherState();
}

class _AnimatedButtonSwitcherState extends State<AnimatedButtonSwitcher> {
  bool tapOnRight = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 55,
            width: double.infinity,
            decoration: ColorsStyles.roundedContainerDecoration,
          ),

          ///! Right Side button
          AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: tapOnRight
                  ? EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.40.w)
                  : const EdgeInsets.only(left: 0),
              child: GestureDetector(
                onTap: (() {}),
                child: Container(
                  height: 55.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                      color: ColorsStyles.primaryColor,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Center(
                    child: Text(
                      tapOnRight ? "Check-Out time" : "Check-In time",
                      style: ColorsStyles.heading1.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ),
              )),
          GestureDetector(
            onTap: () {
              setState(() {
                tapOnRight = !tapOnRight;
                EmployeeCheckInOutDetailsProvider provider = sl();
                provider.toogleselectedCheckInOutTiming();
              });
            },

            ///! Left Side button
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              child: Align(
                alignment:
                    tapOnRight ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  height: 55.h,
                  width: MediaQuery.of(context).size.width * 0.4.w,
                  alignment: Alignment.center,
                  child: Text(
                    tapOnRight ? "Check-In time" : "Check-Out time",
                    style: ColorsStyles.heading1.copyWith(fontSize: 12.sp),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
