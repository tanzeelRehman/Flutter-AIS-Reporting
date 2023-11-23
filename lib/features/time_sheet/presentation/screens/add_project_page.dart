// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:ais_reporting/core/router/app_state.dart';
import 'package:ais_reporting/core/utils/globals/globals.dart';
import 'package:ais_reporting/core/utils/globals/snack_bar.dart';
import 'package:ais_reporting/core/widgets/custom/pick_date_container_field.dart';
import 'package:ais_reporting/features/time_sheet/data/model/time_sheet_details_post_model.dart';
import 'package:ais_reporting/features/time_sheet/presentation/provider/time_sheet_provider.dart';
import 'package:ais_reporting/features/time_sheet/presentation/screens/timeline_project_detail_page.dart';
import 'package:ais_reporting/features/time_sheet/presentation/widgets/add_project_dialog.dart';

import '../../../../core/utils/theme/color_style.dart';
import '../../../../core/widgets/custom/primary_orange_button.dart';
import '../widgets/projects_bottom_sheet.dart';

class AddProjectPage extends StatelessWidget {
  TimeSheetProvider timeSheetProvider = sl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: ChangeNotifierProvider.value(
          value: timeSheetProvider,
          child: AddProjectPageContent(),
        ));
  }
}

class AddProjectPageContent extends StatefulWidget {
  const AddProjectPageContent({super.key});

  @override
  State<AddProjectPageContent> createState() => _AddProjectPageContentState();
}

class _AddProjectPageContentState extends State<AddProjectPageContent> {
  TimeSheetProvider timeSheetProvider = sl();

  @override
  void initState() {
    getData();

    super.initState();
  }

  void getData() async {
    await timeSheetProvider.getAllProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        color: ColorsStyles.scaffoldBackgroundColor,
        child: Consumer<TimeSheetProvider>(
          builder: (context, timesheetprovider, child) {
            return SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('here');
                            // AppState appState = sl();
                            // appState.moveToBackScreen();
                            Navigator.pop(context, true);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: (() {
                                      AppState appState = sl();
                                      appState.moveToBackScreen();
                                    }),
                                    icon: Icon(
                                      size: 18,
                                      Icons.arrow_back_ios,
                                      color: ColorsStyles.primaryColor,
                                    )),
                                Text(
                                  "Go Back",
                                  style: ColorsStyles.heading1,
                                ),
                                SizedBox(
                                  width: 50.w,
                                )
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Add weekley timesheet, of",
                          style: ColorsStyles.subtitle1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Current Working Project",
                            style: ColorsStyles.heading1),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder(
                          valueListenable: timeSheetProvider.projectsLoading,
                          builder: (context, loading, child) {
                            if (loading) {
                              return Text(
                                'Loading data...',
                                style: ColorsStyles.heading1,
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      child: PickDateContainerField(
                                          ontap: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(
                                                        2010, 9, 7, 17, 30),
                                                    lastDate: DateTime.now());
                                            if (picked != null) {
                                              timeSheetProvider
                                                  .setWeekStartDate(picked);
                                            }
                                          },
                                          text: DateFormat.yMMMEd().format(
                                              timeSheetProvider
                                                  .weekStartDate))),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      child: PickDateContainerField(
                                          ontap: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(
                                                        2010, 9, 7, 17, 30),
                                                    lastDate: DateTime.now());
                                            if (picked != null) {
                                              timeSheetProvider
                                                  .setWeekEndDate(picked);
                                            }
                                          },
                                          text: DateFormat.yMMMEd().format(
                                              timeSheetProvider.weekEndDate))),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: List.generate(
                                                        timesheetprovider
                                                                .getDaysDuration() +
                                                            1, (index) {
                                                      return DateButton(
                                                        date: timesheetprovider
                                                            .weekStartDate
                                                            .add(Duration(
                                                                days: index)),
                                                        index: index,
                                                      );
                                                    }),
                                                  )
                                                ])),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "Time Sheet Entries",
                          style: ColorsStyles.subtitle1,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        SizedBox(
                          //height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: timeSheetProvider.timeSheetListRowIsEmpty
                              ? SizedBox.shrink()
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    dataRowMaxHeight: double.infinity,
                                    dataRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) {
                                      // Customize the background color of data rows here
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Colors
                                            .blue; // Color when row is selected
                                      }
                                      return ColorsStyles
                                          .scaffoldBackgroundColor; // Default color
                                    }),
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) {
                                      // Customize the background color of the heading row here
                                      return ColorsStyles
                                          .canvasColor; // Default color for heading row
                                    }),
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        "Date",
                                        style: ColorsStyles.subtitle1,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Details",
                                        style: ColorsStyles.subtitle1,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Actions",
                                        style: ColorsStyles.subtitle1,
                                      )),
                                    ],
                                    rows: List.generate(
                                        timeSheetProvider
                                            .timeSheetDetailsPostModel
                                            .timesheetEntries
                                            .length, (timeSheetEntriesIndex) {
                                      return DataRow(cells: [
                                        DataCell(Text(
                                          DateFormat.yMMMEd().format(
                                              DateTime.parse(timeSheetProvider
                                                  .timeSheetDetailsPostModel
                                                  .timesheetEntries[
                                                      timeSheetEntriesIndex]
                                                  .workDate)),
                                          style: ColorsStyles.subtitle1
                                              .copyWith(fontSize: 14.sp),
                                        )),
                                        DataCell(Column(
                                          children: List.generate(
                                              timeSheetProvider
                                                  .timeSheetDetailsPostModel
                                                  .timesheetEntries[
                                                      timeSheetEntriesIndex]
                                                  .workDetails
                                                  .length, (childindex) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0.w,
                                                  top: 0.h,
                                                  bottom: 0.h),
                                              child: SizedBox(
                                                width: 220.w,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          " ${timeSheetProvider.timeSheetDetailsPostModel.timesheetEntries[timeSheetEntriesIndex].workDetails[childindex].hours.toString()} Hours on ",
                                                          style: ColorsStyles
                                                              .subtitle1
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.sp),
                                                        ),
                                                        Text(
                                                            timesheetprovider.getKeyFromValue(timeSheetProvider
                                                                .timeSheetDetailsPostModel
                                                                .timesheetEntries[
                                                                    timeSheetEntriesIndex]
                                                                .workDetails[
                                                                    childindex]
                                                                .projectId),
                                                            style: ColorsStyles
                                                                .subtitle1
                                                                .copyWith(
                                                                    fontSize:
                                                                        14.sp)),
                                                        SizedBox(
                                                          width: 8.w,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      ((context) {
                                                                    return AlertDialog(
                                                                        backgroundColor:
                                                                            ColorsStyles
                                                                                .scaffoldBackgroundColor,
                                                                        content:
                                                                            AddProjectDialog(
                                                                          parentIndex:
                                                                              timeSheetEntriesIndex,
                                                                          index:
                                                                              childindex,
                                                                          editList:
                                                                              true,
                                                                        ));
                                                                  }));
                                                            },
                                                            child: Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                        GestureDetector(
                                                            onTap: () {
                                                              timeSheetProvider
                                                                  .deleteEntry(
                                                                      childindex,
                                                                      timeSheetEntriesIndex);
                                                            },
                                                            child: Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        )),
                                        DataCell(Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                timeSheetProvider.deleteRow(
                                                    timeSheetEntriesIndex);
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r)),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  )),
                                            )
                                          ],
                                        ))
                                      ]);
                                    }),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        timeSheetProvider.timeSheetListRowIsEmpty
                            ? SizedBox.shrink()
                            : PrimaryOrangeButton(
                                width: MediaQuery.of(context).size.width * 0.8,
                                text: "Draft",
                                ontap: (() {
                                  Logger().i(timesheetprovider
                                      .timeSheetDetailsPostModel
                                      .toJson());
                                  timeSheetProvider.saveTimeSheet();
                                })),
                        SizedBox(
                          height: 15.h,
                        ),
                        timeSheetProvider.timeSheetListRowIsEmpty
                            ? SizedBox.shrink()
                            : PrimaryOrangeButton(
                                width: MediaQuery.of(context).size.width * 0.8,
                                text: "Save",
                                ontap: (() {
                                  Logger().i(timesheetprovider
                                      .timeSheetDetailsPostModel
                                      .toJson());
                                  timeSheetProvider.saveTimeSheet();
                                }))
                      ],
                    ),
                  ],
                ),
              ),
            ));
          },
        ));
  }
}

class DateButton extends StatefulWidget {
  DateTime date;
  int index;

  DateButton({
    Key? key,
    required this.index,
    required this.date,
  }) : super(key: key);

  @override
  State<DateButton> createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  bool onTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                  backgroundColor: ColorsStyles.scaffoldBackgroundColor,
                  content: AddProjectDialog(
                    parentIndex: 0,
                    index: widget.index,
                    editList: false,
                  ));
            }));
        setState(() {
          onTapped = true;
        });
      },
      child: Container(
          margin: EdgeInsets.only(right: 6.w),
          padding: EdgeInsets.all(8),
          decoration: ColorsStyles.roundedContainerDecoration.copyWith(
              color: onTapped ? Colors.green : ColorsStyles.primaryColor),
          child: Text(
            DateFormat.MEd().format(
              widget.date,
            ),
            style: ColorsStyles.subtitle1.copyWith(color: Colors.white),
          )),
    );
  }
}
