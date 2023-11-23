import 'package:flutter/material.dart';

import '../../../../../core/utils/theme/color_style.dart';

class LeaveTypeButton extends StatelessWidget {
  ValueNotifier leaveNotifier;
  String title;
  Function() ontap;
  LeaveTypeButton({
    Key? key,
    required this.leaveNotifier,
    required this.title,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: leaveNotifier,
        builder: ((context, value, child) {
          return GestureDetector(
            onTap: ontap,
            child: Container(
              decoration: ColorsStyles.roundedContainerDecoration.copyWith(
                color: value
                    ? ColorsStyles.primaryColor
                    : ColorsStyles.canvasColor,
                gradient: value
                    ? LinearGradient(colors: [
                        ColorsStyles.primaryIsDark,
                        ColorsStyles.primaryColor
                      ])
                    : null,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              height: 80,
              width: MediaQuery.of(context).size.width * 0.35,
              child: Text(
                title,
                style: value
                    ? ColorsStyles.heading1.copyWith(fontSize: 20)
                    : ColorsStyles.subtitle1,
              ),
            ),
          );
        }));
  }
}
