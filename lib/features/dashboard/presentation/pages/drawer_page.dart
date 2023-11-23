// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:ais_reporting/core/utils/theme/color_style.dart';
import 'package:ais_reporting/features/dashboard/presentation/manager/dashboard_provider.dart';

import '../../../../core/router/app_state.dart';
import '../../../../core/router/models/page_config.dart';
import '../../../../core/utils/enums/page_state_enum.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../admin/presentation/providers/employee_check_in_out_details_provider.dart';

class DrawerPage extends StatelessWidget {
  ///! providers
  DashboardProvider provider = sl();
  EmployeeCheckInOutDetailsProvider checkInOutDetailsProvider = sl();

  ///! Source locator
  AppState appState = sl();

  DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Container(
        color: ColorsStyles.canvasColor,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 110.h,
                child: Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          "${provider.userProvider.userDetails!.user.firstName} ${provider.userProvider.userDetails!.user.middleName} ${provider.userProvider.userDetails!.user.lastName}",
                          style: ColorsStyles.heading1,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          provider.userProvider.userDetails!.user.email,
                          style:
                              ColorsStyles.subtitle1.copyWith(fontSize: 12.sp),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                )),
            Container(
              height: 2.h,
              width: double.infinity,
              color: Colors.grey,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleHeader("EMPLOYEES OPTIONS"),
                CustomExpansionTile(
                  heading: "Leave",
                  childrens: [
                    CustomListTile(
                        ontap: () {
                          appState.goToNext(PageConfigs.requestLeavePageConfig,
                              pageState: PageState.addPage);
                          drawerKey.currentState!.closeDrawer();
                        },
                        title: 'Request Leave')
                  ],
                ),
                titleHeader("ADMIN OPTIONS"),
                CustomExpansionTile(
                  heading: "Attendence",
                  childrens: [
                    CustomListTile(
                      title: "Consolidated Attendence",
                      ontap: () {
                        checkInOutDetailsProvider.getAttendenceDetails();
                        appState.goToNext(
                            PageConfigs.employeeCheckInOutDetailsPageConfig,
                            pageState: PageState.addPage);
                        drawerKey.currentState!.closeDrawer();
                      },
                    ),
                    CustomListTile(
                      title: "Team Leave Requests",
                      ontap: () {
                        checkInOutDetailsProvider.getAttendenceDetails();
                        appState.goToNext(
                            PageConfigs.teamLeaveRequestsPageConfig,
                            pageState: PageState.addPage);
                        drawerKey.currentState!.closeDrawer();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                //  if (provider.isManagerOrAdmin())
                CustomExpansionTile(
                  heading: "Time Sheets",
                  childrens: [
                    CustomListTile(
                      title: "Team timesheet",
                      ontap: () {
                        checkInOutDetailsProvider.getAttendenceDetails();
                        appState.goToNext(PageConfigs.teamTimeSheetPageConfig,
                            pageState: PageState.addPage);
                        drawerKey.currentState!.closeDrawer();
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            // ListTile(
            //   leading: const Icon(
            //     Icons.book,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     'See all Checkins',
            //     style: ColorsStyles.subtitle1,
            //   ),
            //   onTap: () {
            //     appState.goToNext(PageConfigs.employeesListPageConfig,
            //         pageState: PageState.addPage);
            //   },
            // ),

            ListTile(
              title: Text(
                'Logout',
                style: ColorsStyles.heading1.copyWith(
                    color: ColorsStyles.primaryColor,
                    fontWeight: FontWeight.w800),
              ),
              onTap: () {
                provider.logout(context);

                appState.goToNext(PageConfigs.loginPageConfig,
                    pageState: PageState.replaceAll);
              },
            ),
          ],
        ),
      ),
    );
  }

  Container titleHeader(String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      child: Text(text,
          style: ColorsStyles.heading1.copyWith(
            fontSize: 10.sp,
            color: ColorsStyles.primaryColor,
          )),
    );
  }
}

class CustomListTile extends StatelessWidget {
  Function() ontap;
  String title;
  CustomListTile({
    Key? key,
    required this.ontap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Padding(
          padding: EdgeInsets.only(left: 12.sp, bottom: 8.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title,
                  style: ColorsStyles.heading1.copyWith(fontSize: 12.sp)),
            ],
          ),
        ));
  }
}

class CustomExpansionTile extends StatelessWidget {
  final EmployeeCheckInOutDetailsProvider checkInOutDetailsProvider = sl();
  final AppState appState = sl();
  String heading;
  List<Widget> childrens;
  CustomExpansionTile({
    Key? key,
    required this.heading,
    required this.childrens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: SizedBox(
        child: ExpansionTile(
          collapsedBackgroundColor: Colors.grey.withOpacity(0.3),
          title: Row(
            children: [
              Text(
                heading,
                style: ColorsStyles.heading1
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
            ],
          ),
          childrenPadding: EdgeInsets.symmetric(vertical: 6.h),
          iconColor: ColorsStyles.primaryColor,
          collapsedIconColor: Colors.white,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          backgroundColor: Colors.grey.withOpacity(0.3),
          children: childrens,
        ),
      ),
    );
  }
}
