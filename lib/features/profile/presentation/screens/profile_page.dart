import 'package:ais_reporting/core/router/models/page_config.dart';
import 'package:ais_reporting/core/services/user_provider.dart';
import 'package:ais_reporting/core/utils/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/router/app_state.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';
import '../widgets/employee_details_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent, body: ProfilePageContent());
  }
}

class ProfilePageContent extends StatelessWidget {
  ProfilePageContent({
    Key? key,
  }) : super(key: key);
  //! Providers
  UserProvider userProvider = sl();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: ColorsStyles.scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
          child: Center(
            child: Column(children: [
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
                    "Profile",
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
                height: 20,
              ),
              Container(
                decoration: ColorsStyles.roundedContainerDecoration,
                padding:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Hero(
                              tag: "profile-img",
                              child: Image.asset(AppAssets.profile))),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProvider.userDetails!.user.firstName.length +
                                      userProvider
                                          .userDetails!.user.lastName.length >
                                  10
                              ? userProvider.userDetails!.user.lastName
                              : "${userProvider.userDetails!.user.firstName} ${userProvider.userDetails!.user.lastName}",
                          style:
                              ColorsStyles.heading1.copyWith(fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          width: 120.w,
                          height: 35.h,
                          child: CustomOutlineButton(
                              text: "Edit Profile",
                              onPressed: (() {
                                AppState appState = sl();
                                print("Calling");
                                appState.goToNext(
                                    PageConfigs.profileUpdatePageConfig);
                              })),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      EmployeeDetailsWidget(
                        title: "Employee ID",
                        subtitle: userProvider.userDetails!.user.employeeId,
                      ),
                      EmployeeDetailsWidget(
                        title: "Full name",
                        subtitle:
                            "${userProvider.userDetails!.user.firstName} ${userProvider.userDetails!.user.middleName} ${userProvider.userDetails!.user.lastName}",
                      ),
                      EmployeeDetailsWidget(
                        title: "Designation",
                        subtitle: userProvider.userDetails!.designationName,
                      ),
                      EmployeeDetailsWidget(
                        title: "Department",
                        subtitle: userProvider.userDetails!.departmentName,
                      ),
                      EmployeeDetailsWidget(
                        title: "Reporting To",
                        subtitle: userProvider.userDetails!.user.reportingTo,
                      ),
                      EmployeeDetailsWidget(
                        title: "Cell No",
                        subtitle: userProvider.userDetails!.user.contactNo,
                      ),
                      EmployeeDetailsWidget(
                        title: "Emergency",
                        subtitle:
                            userProvider.userDetails!.user.emergencyContact,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const CustomOutlineButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          alignment: Alignment.center,
          side: MaterialStateProperty.all(
              BorderSide(width: 1, color: ColorsStyles.primaryColor)),
          padding: MaterialStateProperty.all(EdgeInsets.only(
              right: 5.sp, left: 5.sp, top: 3.sp, bottom: 3.sp)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0.r)))),
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: ColorsStyles.primaryColor, fontSize: 12.sp),
      ),
    );
  }
}
