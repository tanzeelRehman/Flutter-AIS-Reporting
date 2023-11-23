// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/theme/color_style.dart';

class LeaveWidget extends StatelessWidget {
  String leaveType;
  int availed;
  int noOfDays;
  LeaveWidget({
    super.key,
    required this.leaveType,
    this.availed = 0,
    required this.noOfDays,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          Positioned(
            left: 20.w,
            child: Container(
              decoration: ColorsStyles.roundedContainerDecoration,
              padding: EdgeInsets.only(left: 25.w),
              height: 70.h,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10.h,
                  ),
                  Text(
                    leaveType,
                    style: ColorsStyles.heading1.copyWith(
                        fontSize: 13.sp,
                        letterSpacing: 1,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 18.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "leaves availed, Out of ",
                        style: ColorsStyles.subtitle1.copyWith(fontSize: 12.sp),
                      ),
                      Text(
                        noOfDays.toString(),
                        style: ColorsStyles.subtitle1.copyWith(
                            fontSize: 12.sp,
                            color: ColorsStyles.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 17,
              child: Container(
                height: 35.h,
                width: 35.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorsStyles.primaryColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  availed.toString(),
                  textAlign: TextAlign.center,
                  style: ColorsStyles.heading1.copyWith(fontSize: 15.sp),
                ),
              )),
        ],
      ),
    );
  }
}
