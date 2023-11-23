// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/utils/theme/color_style.dart';

class CheckedInOutDetailsWidget extends StatelessWidget {
  String? time;
  String? date;

  final bool isCheckedInWidget;
  CheckedInOutDetailsWidget({
    Key? key,
    this.time,
    this.date,
    required this.isCheckedInWidget,
  }) : super(key: key);

  late TextStyle dateStyle = ColorsStyles.subtitle1.copyWith(fontSize: 12);

  @override
  Widget build(BuildContext context) {
    if (date == null || date == '') {
      date = 'Not Checked-In yet';
      dateStyle =
          ColorsStyles.subtitle1.copyWith(color: Colors.red, fontSize: 12);
    }
    if (time == null || time == '') {
      time = '- - -';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isCheckedInWidget ? "Checked In" : "Checked Out",
          style: ColorsStyles.heading1.copyWith(fontSize: 16),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          date!,
          style: dateStyle,
        ),
        const SizedBox(
          height: 4,
        ),
        Column(
          children: [
            Text(time!,
                style: ColorsStyles.subtitle1.copyWith(
                    color: ColorsStyles.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 6,
            ),
          ],
        )
      ],
    );
  }
}
