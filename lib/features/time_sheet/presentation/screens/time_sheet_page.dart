// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ais_reporting/features/time_sheet/presentation/provider/time_sheet_provider.dart';
import 'package:ais_reporting/features/time_sheet/presentation/screens/add_project_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';
import '../widgets/project_timeline_tile.dart';

class TimeSheetPage extends StatelessWidget {
  TimeSheetProvider timeSheetProvider = sl();

  TimeSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: timeSheetProvider, child: TimeSheetPageContent());
  }
}

class TimeSheetPageContent extends StatefulWidget {
  const TimeSheetPageContent({super.key});

  @override
  State<TimeSheetPageContent> createState() => _TimeSheetPageContentState();
}

class _TimeSheetPageContentState extends State<TimeSheetPageContent> {
  TimeSheetProvider timeSheetProvider = sl();
  @override
  void initState() {
    super.initState();
    callData();
  }

  void callData() async {
    await timeSheetProvider.getAllTimeSheets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsStyles.scaffoldBackgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, _) {
                  return AddProjectPage();
                },
                opaque: false));
          },
          child: Container(
            decoration: BoxDecoration(
                color: ColorsStyles.primaryColor,
                borderRadius: BorderRadius.circular(30)),
            height: 55,
            width: 55,
            margin: const EdgeInsets.only(bottom: 70),
            child: const Icon(
              size: 30,
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Projects",
                    style: ColorsStyles.subtitle1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Timeline sheet", style: ColorsStyles.heading1),
                  const SizedBox(
                    height: 30,
                  ),
                  ValueListenableBuilder(
                    valueListenable: timeSheetProvider.timeSheetsLoading,
                    builder: (context, value, child) {
                      if (value == false) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.69,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: ListView.builder(
                            itemCount: timeSheetProvider
                                    .getAllTimeSheetsResponseModel
                                    ?.response
                                    .length ??
                                0,
                            itemBuilder: (context, allTimeSheetsindex) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  margin: EdgeInsets.zero,
                                  child: SizedBox(
                                    child: ExpansionTile(
                                      collapsedBackgroundColor:
                                          Colors.grey.withOpacity(0.3),
                                      childrenPadding:
                                          EdgeInsets.symmetric(vertical: 6.h),
                                      iconColor: ColorsStyles.primaryColor,
                                      collapsedIconColor: Colors.white,
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.3),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            timeSheetProvider
                                                    .getAllTimeSheetsResponseModel
                                                    ?.response[
                                                        allTimeSheetsindex]
                                                    .user
                                                    .firstName ??
                                                'Undefined',
                                          ),
                                          Text(
                                            DateFormat.MEd().format(
                                                DateTime.parse(timeSheetProvider
                                                    .getAllTimeSheetsResponseModel!
                                                    .response[
                                                        allTimeSheetsindex]
                                                    .weekStartDate)),
                                            style: ColorsStyles.subtitle1
                                                .copyWith(fontSize: 14.sp),
                                          ),
                                          Text(
                                            DateFormat.MEd().format(
                                                DateTime.parse(timeSheetProvider
                                                    .getAllTimeSheetsResponseModel!
                                                    .response[
                                                        allTimeSheetsindex]
                                                    .weekEndDate)),
                                            style: ColorsStyles.subtitle1
                                                .copyWith(fontSize: 14.sp),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                color:
                                                    ColorsStyles.primaryColor),
                                            child: Text(
                                              timeSheetProvider
                                                  .getAllTimeSheetsResponseModel!
                                                  .response[allTimeSheetsindex]
                                                  .timesheetStatus
                                                  .timesheetStatus,
                                              style: ColorsStyles.subtitle1
                                                  .copyWith(
                                                      fontSize: 12.sp,
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      children: List.generate(
                                          timeSheetProvider
                                                  .getAllTimeSheetsResponseModel
                                                  ?.response[allTimeSheetsindex]
                                                  .timesheetEntries
                                                  .length ??
                                              0, (childindex) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 12.w,
                                              top: 8.h,
                                              bottom: 8.h),
                                          child: Row(
                                            children: [
                                              Text(
                                                " ${timeSheetProvider.getAllTimeSheetsResponseModel?.response[allTimeSheetsindex].timesheetEntries[childindex].hoursWorked.toString()} Hours added on ",
                                                style: ColorsStyles.subtitle1
                                                    .copyWith(fontSize: 14.sp),
                                              ),
                                              Text(
                                                  timeSheetProvider
                                                          .getAllTimeSheetsResponseModel
                                                          ?.response[
                                                              allTimeSheetsindex]
                                                          .timesheetEntries[
                                                              childindex]
                                                          .project
                                                          .title ??
                                                      'Undefined',
                                                  style: ColorsStyles.subtitle1
                                                      .copyWith(
                                                          fontSize: 14.sp)),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        )));
  }
}
