import 'dart:ui';

import 'package:ais_reporting/core/router/app_state.dart';
import 'package:ais_reporting/core/router/models/page_config.dart';
import 'package:ais_reporting/core/services/user_provider.dart';
import 'package:ais_reporting/core/utils/enums/page_state_enum.dart';
import 'package:ais_reporting/core/widgets/custom/primary_orange_button.dart';
import 'package:ais_reporting/features/dashboard/presentation/manager/dashboard_provider.dart';
import 'package:ais_reporting/features/dashboard/presentation/widgets/manual_attendence_bottom_sheet.dart';
import 'package:ais_reporting/features/leave/presentation/provider/leave_provider.dart';
import 'package:ais_reporting/features/profile/presentation/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constants/app_assets.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';
import '../widgets/attendane_percentage_widget.dart';
import '../widgets/checin_checkout_detail_widget.dart';
import '../widgets/leave_widget.dart';

class AttendencePage extends StatefulWidget {
  const AttendencePage({super.key});

  @override
  State<AttendencePage> createState() => _AttendencePageState();
}

class _AttendencePageState extends State<AttendencePage> {
  ///! Providers
  DashboardProvider dashboardProvider = sl();
  LeaveProvider leaveProvider = sl();
  @override
  void initState() {
    super.initState();
    dashboardProvider.getStatus();

    print(dashboardProvider.lastDate);
    print(dashboardProvider.lastTime);
    leaveProvider.getEmployeeLeaveQuota();
  }

  UserProvider authProvider = sl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsStyles.scaffoldBackgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Consumer<DashboardProvider>(builder: (_, provider, __) {
              return Column(
                children: [
                  // appbar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: (() {
                            Scaffold.of(context).openDrawer();
                          }),
                          icon: Icon(
                            size: 35,
                            Icons.menu,
                            color: ColorsStyles.primaryColor,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello ${authProvider.userDetails!.user.lastName}',
                            style: ColorsStyles.subtitle1,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          print("tapped");
                          AppState appState = sl();
                          appState.goToNext(PageConfigs.profilePageConfig,
                              pageState: PageState.addPage);
                          // Navigator.of(context).push(PageRouteBuilder(
                          //     pageBuilder: (context, animation, _) {
                          //       return const ProfilePage();
                          //     },
                          //     opaque: false));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Hero(
                                  tag: "profile-img",
                                  child: Image.asset(AppAssets.profile))),
                        ),
                      )
                    ],
                  ),

                  /// rest body
                  ValueListenableBuilder(
                    valueListenable: leaveProvider.isNoInternet,
                    builder: (context, value, child) {
                      return value
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(AppAssets.noInternet),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Whoops!",
                                    style: ColorsStyles.heading1
                                        .copyWith(fontSize: 30.sp),
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "No internet connection found. Check your connection and refresh again",
                                    style: ColorsStyles.subtitle1
                                        .copyWith(fontSize: 12.sp),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  CustomOutlineButton(
                                      text: "    Retry    ",
                                      onPressed: () async {
                                        await dashboardProvider.getStatus();
                                        await leaveProvider
                                            .getEmployeeLeaveQuota();
                                      })
                                ],
                              ),
                            )
                          : SizedBox(
                              height:
                                  MediaQuery.of(context).size.height - 150 - 50,
                              child: NestedScrollView(
                                headerSliverBuilder:
                                    (context, innerBoxIsScrolled) {
                                  return [
                                    SliverAppBar(
                                      backgroundColor: Colors.transparent,
                                      expandedHeight: 150.h + 155.h + 40.h,
                                      flexibleSpace: FlexibleSpaceBar(
                                        stretchModes: const [
                                          StretchMode.zoomBackground
                                        ],
                                        collapseMode: CollapseMode.parallax,
                                        background: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 25.h),
                                              child: Text("Attendance",
                                                  style: ColorsStyles.heading1),
                                            ),
                                            Container(
                                              height: 150.h,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30.w,
                                                  vertical: 15.h),
                                              width: double.infinity,
                                              decoration: ColorsStyles
                                                  .roundedContainerDecoration,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const AttendencePercentageWidget(),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      provider.lastType ==
                                                              'Check-Out'
                                                          ? CheckedInOutDetailsWidget(
                                                              isCheckedInWidget:
                                                                  true,
                                                              time: provider
                                                                  .lastTime,
                                                              date: provider
                                                                  .lastDate,
                                                              // location: "Gulberg Street office",
                                                            )
                                                          : CheckedInOutDetailsWidget(
                                                              isCheckedInWidget:
                                                                  false,
                                                              time: provider
                                                                  .lastTime,
                                                              date: provider
                                                                  .lastDate
                                                              // location: "Gulberg Street office",
                                                              )
                                                      // SizedBox(
                                                      //   height: 20,
                                                      // ),
                                                      // CheckedInOutDetailsWidget(
                                                      //   isCheckedInWidget: false,
                                                      // )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    PrimaryOrangeButton(
                                                        text: provider
                                                                    .lastType ==
                                                                ''
                                                            ? 'Check-In'
                                                            : provider.lastType,
                                                        ontap: (() {
                                                          showModalBottomSheet(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              context: context,
                                                              builder:
                                                                  ((context) {
                                                                return BackdropFilter(
                                                                    filter: ImageFilter.blur(
                                                                        sigmaX:
                                                                            2,
                                                                        sigmaY:
                                                                            2),
                                                                    child:
                                                                        const ManualAttendenceBottomSheet());
                                                              }));
                                                        })),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    // CheckInOutButton(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ];
                                },
                                body: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Leaves",
                                            style: ColorsStyles.heading1),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text("details",
                                            style: ColorsStyles.subtitle1)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: ValueListenableBuilder(
                                          valueListenable: leaveProvider
                                              .loadingEmployeeLeavesData,
                                          builder: ((context, value, child) {
                                            if (value) {
                                              return SizedBox(
                                                height: 100,
                                                child: Center(
                                                  child: Lottie.asset(
                                                      height: 100.h,
                                                      AppAssets.loader2),
                                                ),
                                              );
                                            } else {
                                              return SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.8,
                                                child: ListView.builder(
                                                    itemCount: leaveProvider
                                                        .getLeaveQuotaResponseModel!
                                                        .response
                                                        .length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      ///* Leave type 5 => Metarnity Leave
                                                      ///   Only Females have Metarnity Leave
                                                      if (dashboardProvider
                                                                  .userProvider
                                                                  .userDetails!
                                                                  .user
                                                                  .gender ==
                                                              "Male" &&
                                                          leaveProvider
                                                                  .getLeaveQuotaResponseModel!
                                                                  .response[
                                                                      index]
                                                                  .leaveTypeId ==
                                                              5) {
                                                        return const SizedBox
                                                            .shrink();
                                                      }

                                                      ///* Leave type 6 => Paternity Leave
                                                      ///  Only Males have paternity Leave
                                                      if (dashboardProvider
                                                                  .userProvider
                                                                  .userDetails!
                                                                  .user
                                                                  .gender ==
                                                              "Female" &&
                                                          leaveProvider
                                                                  .getLeaveQuotaResponseModel!
                                                                  .response[
                                                                      index]
                                                                  .leaveTypeId ==
                                                              6) {
                                                        return const SizedBox
                                                            .shrink();
                                                      }

                                                      ///* Leave type 3 => Bravernment Leave
                                                      ///  Bravernment Leave are not allowed to show
                                                      if (leaveProvider
                                                              .getLeaveQuotaResponseModel!
                                                              .response[index]
                                                              .leaveTypeId ==
                                                          3) {
                                                        return const SizedBox
                                                            .shrink();
                                                      } else {
                                                        return LeaveWidget(
                                                          leaveType: leaveProvider
                                                              .getLeaveQuotaResponseModel!
                                                              .response[index]
                                                              .LeaveTypeName
                                                              .split(' ')[0]
                                                              .toString(),
                                                          noOfDays: leaveProvider
                                                              .getLeaveQuotaResponseModel!
                                                              .response[index]
                                                              .noOfDays,
                                                          availed: leaveProvider
                                                              .getLeaveQuotaResponseModel!
                                                              .response[index]
                                                              .availed,
                                                        );
                                                      }
                                                    })),
                                              );
                                            }
                                          })),
                                    )
                                  ],
                                ),
                              ),
                            );
                    },
                  )
                ],
              );
            }),
          ),
        )));
  }
}
