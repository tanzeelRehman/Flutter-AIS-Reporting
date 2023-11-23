import 'package:flutter/material.dart';

import '../../../../core/utils/theme/color_style.dart';

class EmployeeDetailsWidget extends StatelessWidget {
  String title;
  String subtitle;
  EmployeeDetailsWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: ColorsStyles.heading1.copyWith(fontSize: 15),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: ColorsStyles.subtitle1.copyWith(fontSize: 15),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 2,
          color: Colors.grey.withOpacity(0.3),
          width: MediaQuery.of(context).size.width * 0.8,
        )
      ],
    );
  }
}
