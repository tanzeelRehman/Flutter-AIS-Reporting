import 'package:ais_reporting/core/router/app_state.dart';
import 'package:ais_reporting/core/router/models/page_config.dart';
import 'package:ais_reporting/core/services/user_provider.dart';
import 'package:ais_reporting/core/utils/constants/app_assets.dart';
import 'package:ais_reporting/core/utils/enums/page_state_enum.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';

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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profile  ',
                        style: ColorsStyles.heading1.copyWith(fontSize: 30),
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        userProvider.logout(context);
                        AppState appState = sl();
                        appState.goToNext(PageConfigs.loginPageConfig,
                            pageState: PageState.replaceAll);
                      },
                      child:
                          const Icon(size: 30, color: Colors.red, Icons.logout))
                ],
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
                        SizedBox(
                          width: 200,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            userProvider.userDetails!.user.firstName +
                                userProvider.userDetails!.user.lastName,
                            style: ColorsStyles.heading1.copyWith(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "Associate Flutter Developer",
                            style:
                                ColorsStyles.subtitle1.copyWith(fontSize: 10),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                      Text(
                        "Employee No  ${userProvider.userDetails!.user.employeeId}",
                        style: ColorsStyles.subtitle1.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: ColorsStyles.primaryColor),
                      ),
                      EmployeeDetailsWidget(
                        title: "Reporting To",
                        subtitle: userProvider.userDetails!.user.reportingTo,
                      ),
                      // EmployeeDetailsWidget(
                      //   title: "Age",
                      //   subtitle: "4 years old",
                      // ),
                      // EmployeeDetailsWidget(
                      //   title: "Tenure",
                      //   subtitle: "1.5 years",
                      // ),
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

class EmployeeDetailsWidget extends StatelessWidget {
  String title;
  String subtitle;
  EmployeeDetailsWidget({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: ColorsStyles.heading1.copyWith(fontSize: 15),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: ColorsStyles.subtitle1.copyWith(fontSize: 15),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          height: 2,
          color: Colors.grey.withOpacity(0.3),
          width: MediaQuery.of(context).size.width * 0.8,
        )
      ],
    );
  }
}
