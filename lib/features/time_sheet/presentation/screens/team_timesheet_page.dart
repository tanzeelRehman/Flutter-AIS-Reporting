// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ais_reporting/core/router/app_state.dart';
import 'package:ais_reporting/features/time_sheet/presentation/provider/time_sheet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';

class TeamTimeSheetPage extends StatelessWidget {
  TimeSheetProvider timeSheetProvider = sl();

  TeamTimeSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: timeSheetProvider, child: TeamTimeSheetPageContent());
  }
}

class TeamTimeSheetPageContent extends StatefulWidget {
  const TeamTimeSheetPageContent({super.key});

  @override
  State<TeamTimeSheetPageContent> createState() =>
      _TeamTimeSheetPageContentState();
}

class _TeamTimeSheetPageContentState extends State<TeamTimeSheetPageContent> {
  TimeSheetProvider timeSheetProvider = sl();

  @override
  void initState() {
    super.initState();
    callData();
  }

  void callData() async {
    await timeSheetProvider.getTeamTimeSheets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsStyles.scaffoldBackgroundColor,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  print('here');
                  // AppState appState = sl();
                  // appState.moveToBackScreen();
                  Navigator.pop(context, true);
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
              Consumer<TimeSheetProvider>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Team Projects",
                        style: ColorsStyles.subtitle1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Timeline sheet", style: ColorsStyles.heading1),
                          PopupMenuButton(
                            icon: Icon(
                              Icons.sort,
                              color: ColorsStyles.primaryColor,
                            ),
                            onSelected: (value) {
                              timeSheetProvider.filterTimeSheetDisplay(value);
                            },
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: 'all',
                                  child: Text("All"),
                                ),
                                PopupMenuItem(
                                  value: 'pending',
                                  child: Text("Pending"),
                                ),
                                PopupMenuItem(
                                  value: 'accepted',
                                  child: Text("Accepted"),
                                ),
                                PopupMenuItem(
                                  value: 'rejected',
                                  child: Text("Rejected"),
                                ),
                              ];
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ValueListenableBuilder(
                        valueListenable: timeSheetProvider.teamProjectsLoading,
                        builder: (context, value, child) {
                          if (value == false) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.65,
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: ListView.builder(
                                itemCount: timeSheetProvider
                                        .getTeamTimeSheetDisplayResponseModel
                                        ?.response
                                        ?.length ??
                                    0,
                                itemBuilder: (context, teamtimesheetindex) {
                                  return StickyHeader(
                                    header: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 5.h),
                                      color: ColorsStyles.primaryColor,
                                      child: Row(
                                        children: [
                                          Text(
                                            DateFormat.MEd().format(
                                                DateTime.parse(timeSheetProvider
                                                    .getTeamTimeSheetDisplayResponseModel!
                                                    .response![
                                                        teamtimesheetindex]
                                                    .weekStartDate!)),
                                            style: ColorsStyles.subtitle1
                                                .copyWith(
                                                    fontSize: 14.sp,
                                                    color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            DateFormat.MEd().format(
                                                DateTime.parse(timeSheetProvider
                                                    .getTeamTimeSheetDisplayResponseModel!
                                                    .response![
                                                        teamtimesheetindex]
                                                    .weekEndDate!)),
                                            style: ColorsStyles.subtitle1
                                                .copyWith(
                                                    fontSize: 14.sp,
                                                    color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    content: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        margin: EdgeInsets.zero,
                                        child: Banner(
                                          location: BannerLocation.topStart,
                                          color: timeSheetProvider
                                              .getTeamTimeSheetStatusColor(
                                                  timeSheetProvider
                                                          .getTeamTimeSheetDisplayResponseModel!
                                                          .response![
                                                              teamtimesheetindex]
                                                          .timesheetStatusId ??
                                                      1),
                                          message: timeSheetProvider
                                              .getTeamTimeSheetStatus(
                                                  timeSheetProvider
                                                          .getTeamTimeSheetDisplayResponseModel!
                                                          .response![
                                                              teamtimesheetindex]
                                                          .timesheetStatusId ??
                                                      1),
                                          child: SizedBox(
                                            child: ExpansionTile(
                                              collapsedBackgroundColor:
                                                  Colors.grey.withOpacity(0.3),
                                              childrenPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8.h),
                                              iconColor:
                                                  ColorsStyles.primaryColor,
                                              collapsedIconColor: Colors.white,
                                              expandedCrossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              backgroundColor:
                                                  Colors.grey.withOpacity(0.3),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      if (timeSheetProvider
                                                              .getTeamTimeSheetDisplayResponseModel!
                                                              .response![
                                                                  teamtimesheetindex]
                                                              .timesheetStatusId ==
                                                          1)
                                                        PopupMenuButton(
                                                          icon:
                                                              Icon(Icons.edit),
                                                          onSelected: (value) {
                                                            Logger().i(value);
                                                            timeSheetProvider.updateTimeSheets(
                                                                timeSheetProvider
                                                                    .getTeamTimeSheetDisplayResponseModel!
                                                                    .response![
                                                                        teamtimesheetindex]
                                                                    .timesheetId!,
                                                                value);
                                                          },
                                                          itemBuilder:
                                                              (context) {
                                                            return [
                                                              PopupMenuItem(
                                                                value: 2,
                                                                child: Text(
                                                                    "Approve"),
                                                              ),
                                                              PopupMenuItem(
                                                                value: 3,
                                                                child: Text(
                                                                    "Reject"),
                                                              ),
                                                            ];
                                                          },
                                                        )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Expanded(
                                                          child: Text(
                                                            timeSheetProvider
                                                                    .getTeamTimeSheetDisplayResponseModel!
                                                                    .response![
                                                                        teamtimesheetindex]
                                                                    .firstName ??
                                                                'Undefined',
                                                            style: ColorsStyles
                                                                .heading1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15.w,
                                                      ),
                                                      SizedBox(
                                                        width: 90.w,
                                                        child: Text(
                                                          timeSheetProvider
                                                              .getTeamTimeSheetDisplayResponseModel!
                                                              .response![
                                                                  teamtimesheetindex]
                                                              .userDepartment
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: ColorsStyles
                                                              .subtitle1
                                                              .copyWith(
                                                                  fontSize:
                                                                      14.sp),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              children: List.generate(
                                                  timeSheetProvider
                                                          .getTeamTimeSheetDisplayResponseModel!
                                                          .response?[
                                                              teamtimesheetindex]
                                                          .workEntries
                                                          ?.length ??
                                                      0, (childindex) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 12.w,
                                                      top: 8.h,
                                                      bottom: 8.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            DateFormat
                                                                    .yMMMMEEEEd()
                                                                .format(DateTime.parse(timeSheetProvider
                                                                    .getTeamTimeSheetDisplayResponseModel!
                                                                    .response![
                                                                        teamtimesheetindex]
                                                                    .workEntries![
                                                                        childindex]
                                                                    .workDate!)),
                                                            style: ColorsStyles
                                                                .subtitle1
                                                                .copyWith(
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: List.generate(
                                                              timeSheetProvider
                                                                  .getTeamTimeSheetDisplayResponseModel!
                                                                  .response![
                                                                      teamtimesheetindex]
                                                                  .workEntries![
                                                                      childindex]
                                                                  .workDetails!
                                                                  .length,
                                                              (workItemIndex) {
                                                            return ExpansionTile(
                                                              title: Text(
                                                                '${timeSheetProvider.getTeamTimeSheetDisplayResponseModel!.response![teamtimesheetindex].workEntries![childindex].workDetails![workItemIndex].hoursWorked}  on ${timeSheetProvider.getTeamTimeSheetDisplayResponseModel!.response![teamtimesheetindex].workEntries![childindex].workDetails![workItemIndex].projectName}',
                                                                style: ColorsStyles
                                                                    .subtitle1
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                              ),
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(
                                                                      bottom:
                                                                          5.h,
                                                                      left:
                                                                          15.w),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        timeSheetProvider
                                                                            .getTeamTimeSheetDisplayResponseModel!
                                                                            .response![teamtimesheetindex]
                                                                            .workEntries![childindex]
                                                                            .workDetails![workItemIndex]
                                                                            .description
                                                                            .toString(),
                                                                        style: ColorsStyles
                                                                            .subtitle1
                                                                            .copyWith(fontSize: 12),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          })),
                                                    ],
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
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
                  );
                },
              )
            ],
          ),
        )));
  }
}
