// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ais_reporting/core/router/models/page_config.dart';
import 'package:ais_reporting/core/utils/globals/snack_bar.dart';
import 'package:ais_reporting/core/widgets/custom/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:ais_reporting/features/admin/presentation/providers/employee_check_in_out_details_provider.dart';
import 'package:ais_reporting/features/dashboard/presentation/widgets/animated_custom_switcher.dart';

import '../../../../core/router/app_state.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';
import '../../../../core/widgets/custom/pick_date_container_field.dart';

class EmployeeDetailsPage extends StatelessWidget {
  const EmployeeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //! Providers
    EmployeeCheckInOutDetailsProvider provider = sl();
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: provider)],
      child: const EmployeeDetailsPageContent(),
    );
  }
}

class EmployeeDetailsPageContent extends StatelessWidget {
  const EmployeeDetailsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyles.scaffoldBackgroundColor,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                  "Employee details",
                  style: ColorsStyles.heading1,
                ),
                SizedBox(
                  width: 50.w,
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey.withOpacity(0.3),
            ),
            SizedBox(
              height: 25.h,
            ),
            Text(
              "Tanzeel ur Rehman",
              style: ColorsStyles.heading1,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Flutter Developer",
              style: ColorsStyles.subtitle1,
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Select time you want to see details",
              style: ColorsStyles.subtitle1.copyWith(fontSize: 12),
            ),
            SizedBox(
              height: 10.h,
            ),
            AnimatedButtonSwitcher(),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "Select dates betweent you want to see check-In/Out details",
              style: ColorsStyles.subtitle1.copyWith(fontSize: 12),
            ),
            //! Start date
            ValueListenableBuilder(
                valueListenable: context
                    .read<EmployeeCheckInOutDetailsProvider>()
                    .checkInOutStartdate,
                builder: ((context, value, child) {
                  return PickDateContainerField(
                    ontap: () async {
                      context
                          .read<EmployeeCheckInOutDetailsProvider>()
                          .selectCheckInOutStartDate(context);
                    },
                    text: !context
                            .read<EmployeeCheckInOutDetailsProvider>()
                            .startdatePicked
                        ? "Select start date"
                        : DateFormat('dd-MM-yyyy').format(context
                            .read<EmployeeCheckInOutDetailsProvider>()
                            .checkInOutStartdate
                            .value),
                  );
                })),
            //! End date
            ValueListenableBuilder(
                valueListenable: context
                    .read<EmployeeCheckInOutDetailsProvider>()
                    .checkInOutEnddate,
                builder: ((context, value, child) {
                  return PickDateContainerField(
                    ontap: () async {
                      context
                          .read<EmployeeCheckInOutDetailsProvider>()
                          .selectCheckInOutEndDate(context);
                    },
                    text: !context
                            .read<EmployeeCheckInOutDetailsProvider>()
                            .enddatePicked
                        ? "Select end date"
                        : DateFormat('dd-MM-yyyy').format(context
                            .read<EmployeeCheckInOutDetailsProvider>()
                            .checkInOutEnddate
                            .value),
                  );
                })),
            SizedBox(
              height: 20.h,
            ),
            ContinueButton(
                text: "Search",
                onPressed: (() {
                  if (context
                          .read<EmployeeCheckInOutDetailsProvider>()
                          .startdatePicked &&
                      context
                          .read<EmployeeCheckInOutDetailsProvider>()
                          .enddatePicked) {
                    AppState appState = sl();
                    appState.goToNext(
                        PageConfigs.employeeCheckInOutDetailsPageConfig);
                  } else {
                    ShowSnackBar.show("Please select start and end date");
                  }
                }))
          ],
        ),
      )),
    );
  }
}
