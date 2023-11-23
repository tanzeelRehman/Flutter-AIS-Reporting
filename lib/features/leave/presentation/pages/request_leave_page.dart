import 'package:ais_reporting/core/router/app_state.dart';
import 'package:ais_reporting/core/utils/constants/app_assets.dart';
import 'package:ais_reporting/features/dashboard/presentation/manager/dashboard_provider.dart';
import 'package:ais_reporting/features/leave/presentation/pages/widgets/leave_type_button.dart';
import 'package:ais_reporting/features/leave/presentation/pages/widgets/leave_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/enums/leave_type.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';
import '../provider/leave_provider.dart';

class RequestLeaveScreen extends StatelessWidget {
  RequestLeaveScreen({super.key});

  LeaveProvider leaveProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: leaveProvider,
      child: const RequestLeaveScreenContent(),
    );
  }
}

class RequestLeaveScreenContent extends StatefulWidget {
  const RequestLeaveScreenContent({super.key});

  @override
  State<RequestLeaveScreenContent> createState() =>
      _RequestLeaveScreenContentState();
}

class _RequestLeaveScreenContentState extends State<RequestLeaveScreenContent> {
  DashboardProvider dashboardProvider = sl();
  @override
  void initState() {
    getValuesFromAPi();
    discardAllSelectedValuesForLeave();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getValuesFromAPi() async {
    await context.read<LeaveProvider>().getEmployees();
  }

  /// If user have selected leave days and exit the screen,
  /// When he will again open the request leave page,
  /// Then the number of selected leave dates are 0 again
  void discardAllSelectedValuesForLeave() {
    context.read<LeaveProvider>().noOfDaysForTheLeave = 0;
    context.read<LeaveProvider>().makeAllLeavesFalse();
    context.read<LeaveProvider>().selectedLeaveType = LeaveType.Casual;
    context.read<LeaveProvider>().cusualLeaveSelected.value =
        !context.read<LeaveProvider>().cusualLeaveSelected.value;
    context.read<LeaveProvider>().personToAssignTaskSelected =
        ValueNotifier(false);
    context.read<LeaveProvider>().datePicked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyles.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.h),
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
                      "Request Leave",
                      style: ColorsStyles.heading1,
                    ),
                    // Image.asset(
                    //     color: Colors.white,
                    //     height: 40.h,
                    //     AppAssets.aisLogoPng),
                    SizedBox(
                      width: 50.w,
                    )
                  ],
                ),
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey.withOpacity(0.3),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select leave type",
                                style: ColorsStyles.subtitle1
                                    .copyWith(fontSize: 12.sp),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              //* Leave Row 1 -------------------------------------------------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LeaveTypeButton(
                                    title: LeaveType.Casual.name,
                                    leaveNotifier: context
                                        .read<LeaveProvider>()
                                        .cusualLeaveSelected,
                                    ontap: () {
                                      requestCausalLeave();
                                    },
                                  ),
                                  LeaveTypeButton(
                                    title: LeaveType.Medical.name,
                                    leaveNotifier: context
                                        .read<LeaveProvider>()
                                        .medicalLeaveSelected,
                                    ontap: () {
                                      requestMediaclLeave();
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              //* Leave Row 2 -------------------------------------------------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LeaveTypeButton(
                                    title: LeaveType.Annual.name,
                                    leaveNotifier: context
                                        .read<LeaveProvider>()
                                        .annualLeaveSelected,
                                    ontap: () {
                                      requestAnnualLeave();
                                    },
                                  ),
                                  dashboardProvider.userProvider.userDetails!
                                              .user.gender ==
                                          "Male"
                                      ? LeaveTypeButton(
                                          title: LeaveType.Paternity.name,
                                          leaveNotifier: context
                                              .read<LeaveProvider>()
                                              .paternityLeaveSelected,
                                          ontap: () {
                                            requestPaternityLeave();
                                          },
                                        )
                                      : LeaveTypeButton(
                                          title: LeaveType.Maternity.name,
                                          leaveNotifier: context
                                              .read<LeaveProvider>()
                                              .maternityLeaveSelected,
                                          ontap: () {
                                            requestMaternityLeave();
                                          },
                                        )
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              //* Leave Row 3 -------------------------------------------------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LeaveTypeButton(
                                    title: LeaveType.Marriage.name,
                                    leaveNotifier: context
                                        .read<LeaveProvider>()
                                        .marriageLeaveSelected,
                                    ontap: () {
                                      requestMarriageLeave();
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              Selector<LeaveProvider, bool>(
                                  builder: ((context, value, child) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Switch(
                                                inactiveTrackColor:
                                                    ColorsStyles.canvasColor,
                                                activeColor:
                                                    ColorsStyles.primaryColor,
                                                value: value,
                                                onChanged: ((value) {
                                                  context
                                                      .read<LeaveProvider>()
                                                      .toogleMultipleLeaveSelected();
                                                })),
                                            Text(
                                              "Multiple leaves",
                                              style: ColorsStyles.subtitle1
                                                  .copyWith(fontSize: 12.sp),
                                            )
                                          ],
                                        ),
                                        LeaveFormWidget(
                                            isMultipleLeavesSelected: value)
                                      ],
                                    );
                                  }),
                                  selector: ((p0, p1) => context
                                      .read<LeaveProvider>()
                                      .multipleLeaveSelected)),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///! Local Functions ===================================================================================================================
  ///*--------------------------------------------------------------------------------------------------------------------------------------

  ///* 1. Annual
  void requestAnnualLeave() {
    if (!context.read<LeaveProvider>().annualLeaveSelected.value) {
      context.read<LeaveProvider>().makeAllLeavesFalse();
    }
    context.read<LeaveProvider>().selectedLeaveType = LeaveType.Annual;
    context.read<LeaveProvider>().annualLeaveSelected.value =
        !context.read<LeaveProvider>().annualLeaveSelected.value;
  }

  ///* 2. Bravernment
  void requestBravermentLeave() {
    if (!context.read<LeaveProvider>().bereavementLeaveSelected.value) {
      context.read<LeaveProvider>().makeAllLeavesFalse();
    }
    context.read<LeaveProvider>().selectedLeaveType = LeaveType.Bereavement;
    context.read<LeaveProvider>().bereavementLeaveSelected.value =
        !context.read<LeaveProvider>().bereavementLeaveSelected.value;
  }

  ///* 3. Marriage
  void requestMarriageLeave() {
    if (!context.read<LeaveProvider>().marriageLeaveSelected.value) {
      context.read<LeaveProvider>().makeAllLeavesFalse();
    }
    context.read<LeaveProvider>().selectedLeaveType = LeaveType.Marriage;
    context.read<LeaveProvider>().marriageLeaveSelected.value =
        !context.read<LeaveProvider>().marriageLeaveSelected.value;
  }

  ///* 4. Mediacl
  void requestMediaclLeave() {
    if (!context.read<LeaveProvider>().medicalLeaveSelected.value) {
      context.read<LeaveProvider>().makeAllLeavesFalse();
    }
    context.read<LeaveProvider>().selectedLeaveType = LeaveType.Medical;
    context.read<LeaveProvider>().medicalLeaveSelected.value =
        !context.read<LeaveProvider>().medicalLeaveSelected.value;
  }

  ///* 5. Maternity
  void requestMaternityLeave() {
    if (!context.read<LeaveProvider>().maternityLeaveSelected.value) {
      context.read<LeaveProvider>().makeAllLeavesFalse();
    }
    context.read<LeaveProvider>().selectedLeaveType = LeaveType.Maternity;
    context.read<LeaveProvider>().maternityLeaveSelected.value =
        !context.read<LeaveProvider>().maternityLeaveSelected.value;
  }

  ///* 6. Paternity
  void requestPaternityLeave() {
    if (!context.read<LeaveProvider>().paternityLeaveSelected.value) {
      context.read<LeaveProvider>().makeAllLeavesFalse();
    }
    context.read<LeaveProvider>().selectedLeaveType = LeaveType.Paternity;
    context.read<LeaveProvider>().paternityLeaveSelected.value =
        !context.read<LeaveProvider>().paternityLeaveSelected.value;
  }

  ///* 7. Casual
  void requestCausalLeave() {
    if (!context.read<LeaveProvider>().cusualLeaveSelected.value) {
      context.read<LeaveProvider>().makeAllLeavesFalse();
    }

    context.read<LeaveProvider>().selectedLeaveType = LeaveType.Casual;

    context.read<LeaveProvider>().cusualLeaveSelected.value =
        !context.read<LeaveProvider>().cusualLeaveSelected.value;
  }
}
