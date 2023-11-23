import 'package:ais_reporting/core/utils/theme/color_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickDateContainerField extends StatelessWidget {
  Function() ontap;
  String text;
  TextStyle? style;
  PickDateContainerField({
    Key? key,
    required this.ontap,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(top: 15.h),
        height: 55,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: ColorsStyles.roundedContainerDecoration.copyWith(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month,
              color: ColorsStyles.primaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 200,
                child: Text(
                  text,
                  style: style ??
                      ColorsStyles.subtitle1
                          .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
