import 'package:ais_reporting/core/router/models/page_config.dart';
import 'package:ais_reporting/core/utils/theme/color_style.dart';
import 'package:ais_reporting/features/admin/presentation/providers/employee_check_in_out_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/router/app_state.dart';
import '../../../../core/utils/constants/app_assets.dart';
import '../../../../core/utils/globals/globals.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //! Providers
    EmployeeCheckInOutDetailsProvider provider = sl();
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: provider)],
      child: EmployeeListPageContent(),
    );
  }
}

class EmployeeListPageContent extends StatelessWidget {
  EmployeeListPageContent({super.key});
  AppState appState = sl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyles.scaffoldBackgroundColor,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (() {
                      appState.moveToBackScreen();
                    }),
                    icon: Icon(
                      size: 18,
                      Icons.arrow_back_ios,
                      color: ColorsStyles.primaryColor,
                    )),
                Text(
                  "AIS Employees",
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
            const SizedBox(
              height: 25,
            ),
            Column(
              children: List.generate(5, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: ColorsStyles.roundedContainerDecoration,
                  child: ListTile(
                    onTap: () {
                      appState.goToNext(PageConfigs.employeeDetailsPageConfig);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(AppAssets.profile)),
                    ),
                    title: Text(
                      "Tanzeel",
                      style: ColorsStyles.heading1.copyWith(fontSize: 15),
                    ),
                    subtitle: const Text("Flutter developer"),
                  ),
                );
              }),
            )
          ],
        ),
      )),
    );
  }
}
