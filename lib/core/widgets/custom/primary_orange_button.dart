import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/color_style.dart';

class PrimaryOrangeButton extends StatelessWidget {
  double width;
  double height;
  String text;
  Function() ontap;
  PrimaryOrangeButton({
    Key? key,
    this.width = 220,
    this.height = 55,
    this.text = "Continue",
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: ColorsStyles.primaryButtonDecoration,
        child: Center(
          child: Text(
            text,
            style: ColorsStyles.heading1.copyWith(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
