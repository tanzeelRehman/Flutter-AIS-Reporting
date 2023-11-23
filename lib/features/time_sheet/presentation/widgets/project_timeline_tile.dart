import 'package:flutter/material.dart';

import '../../../../core/utils/theme/color_style.dart';
import '../screens/timeline_project_detail_page.dart';

class ProjectsTimelineTile extends StatelessWidget {
  String projectTitle;
  String employeeID;
  String totalHoursWork;
  String date;
  bool submitted;
  ProjectsTimelineTile({
    Key? key,
    required this.projectTitle,
    required this.employeeID,
    this.totalHoursWork = "0h 0min",
    required this.date,
    this.submitted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 13),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                date,
                style: ColorsStyles.heading1.copyWith(fontSize: 15),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
              Text(
                "Drag left to delete the project",
                style: ColorsStyles.subtitle1.copyWith(fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TimeLineProjectDetailPage(),
                  ));
            },
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  print("Deleting");
                }
                if (direction == DismissDirection.endToStart) {
                  print("Updating");
                }
              },
              background: const SizedBox.shrink(),
              // This will show up when the user performs dismissal action
              // It is a red background and a trash icon

              secondaryBackground: Container(
                decoration: ColorsStyles.roundedContainerDecoration
                    .copyWith(color: Colors.red),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),

              child: Container(
                decoration: ColorsStyles.roundedContainerDecoration,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      projectTitle,
                      style: ColorsStyles.heading1.copyWith(fontSize: 20),
                    ),
                    Text(
                      totalHoursWork,
                      style: ColorsStyles.subtitle1.copyWith(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
