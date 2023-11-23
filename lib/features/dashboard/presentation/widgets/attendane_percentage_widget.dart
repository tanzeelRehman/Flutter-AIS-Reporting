import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../core/utils/theme/color_style.dart';

class AttendencePercentageWidget extends StatelessWidget {
  const AttendencePercentageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: SleekCircularSlider(
        appearance: CircularSliderAppearance(
            animationEnabled: true,
            customColors: CustomSliderColors(
                progressBarColor: ColorsStyles.primaryColor,
                dynamicGradient: false,
                trackColor: ColorsStyles.scaffoldBackgroundColor),
            infoProperties: InfoProperties(
                modifier: (percentage) {
                  final roundedValue = percentage.ceil().toInt().toString();
                  return '$roundedValue%';
                },
                mainLabelStyle:
                ColorsStyles.heading1.copyWith(color: Colors.white),
                bottomLabelText: "Attendence",
                bottomLabelStyle:
                ColorsStyles.subtitle1.copyWith(fontSize: 10)),
            customWidths: CustomSliderWidths(
              shadowWidth: 0,
              progressBarWidth: 10,
            )),
        min: 0,
        max: 100,
        initialValue: 18,
      ),
    );
  }
}
