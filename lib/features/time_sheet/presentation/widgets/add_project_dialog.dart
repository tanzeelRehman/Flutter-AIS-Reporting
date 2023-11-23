// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ais_reporting/core/widgets/Custom%20Routes/custom_textfield.dart';
import 'package:ais_reporting/core/widgets/custom/primary_orange_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:ais_reporting/core/utils/globals/globals.dart';
import 'package:ais_reporting/core/utils/theme/color_style.dart';
import 'package:ais_reporting/features/time_sheet/presentation/provider/time_sheet_provider.dart';

class AddProjectDialog extends StatefulWidget {
  int index;
  int parentIndex;
  bool editList;
  AddProjectDialog({
    Key? key,
    required this.index,
    required this.editList,
    required this.parentIndex,
  }) : super(key: key);

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  TimeSheetProvider timesheetprovider = sl();
  TextEditingController hoursCon = TextEditingController(text: '0');
  TextEditingController taskDetailsCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsStyles.scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat.MEd().format(
              timesheetprovider.weekStartDate.add(Duration(days: widget.index)),
            ),
            style: ColorsStyles.heading1,
          ),
          SizedBox(
            height: 15.h,
          ),

          CustomTextField(
            controller: TextEditingController(),
            hintText: timesheetprovider.selectedProject,
            color: Colors.white,
            dropdownValues: timesheetprovider.allProjectsMap.keys.toList(),
            shouldShowSearchBar: true,
            onValueSelect: (p0) {
              setState(() {
                timesheetprovider.setSelectedProject(p0!);
              });
            },
          ),
          // Container(
          //   height: 55.h,
          //   width: MediaQuery.of(context).size.width * 8,
          //   padding: EdgeInsets.symmetric(horizontal: 10.w),
          //   decoration: ColorsStyles.roundedContainerDecoration,
          //   child: DropdownButtonHideUnderline(
          //     child: DropdownButton(
          //       value: timesheetprovider.selectedProject,
          //       items: timesheetprovider.allProjectsMap.keys.map((key) {
          //         return DropdownMenuItem(
          //             child: Text(
          //               key,
          //               style: TextStyle(color: Colors.white),
          //             ),
          //             value: key);
          //       }).toList(),
          //       onChanged: (value) {
          //         setState(() {
          //           timesheetprovider.setSelectedProject(value!);
          //         });
          //       },
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            width: MediaQuery.of(context).size.width * 8,
            decoration: ColorsStyles.roundedContainerDecoration,
            child: TextField(
              controller: hoursCon,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  hintText: "Hours",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 150.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            width: MediaQuery.of(context).size.width * 8,
            decoration: ColorsStyles.roundedContainerDecoration,
            child: TextField(
              maxLines: 10,
              controller: taskDetailsCon,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  hintText: "Task Details",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          PrimaryOrangeButton(
            ontap: () {
              timesheetprovider.addNewRows(
                timesheetprovider.selectedProject,
                timesheetprovider.weekStartDate
                    .add(Duration(days: widget.index))
                    .toIso8601String(),
                int.parse(hoursCon.text),
                widget.index,
                widget.editList,
                widget.parentIndex,
                taskDetailsCon.text,
              );
              Navigator.pop(context);
            },
            text: "Save",
          )
        ],
      ),
    );
  }
}
