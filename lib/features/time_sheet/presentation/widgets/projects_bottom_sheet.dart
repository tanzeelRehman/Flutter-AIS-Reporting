import 'package:flutter/material.dart';

import '../../../../core/utils/theme/color_style.dart';

class ProjectsBottomSheet extends StatelessWidget {
  const ProjectsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ColorsStyles.roundedContainerDecoration
          .copyWith(color: ColorsStyles.canvasColor),
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        "Add today time sheet",
        style: ColorsStyles.heading1.copyWith(fontSize: 20),
      ),
    );
  }
}
