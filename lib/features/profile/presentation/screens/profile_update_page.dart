import 'package:ais_reporting/core/widgets/custom/continue_button.dart';
import 'package:ais_reporting/features/profile/presentation/provider/profile_provider.dart';
import 'package:ais_reporting/features/profile/presentation/widgets/edit_employee_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/router/app_state.dart';
import '../../../../core/services/user_provider.dart';
import '../../../../core/utils/constants/app_assets.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';

class ProfileUpdatePage extends StatelessWidget {
  ProfileUpdatePage({super.key});
  ProfileProvider provider = sl();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: ProfileUpdatePageContent(),
    );
  }
}

class ProfileUpdatePageContent extends StatelessWidget {
  ProfileUpdatePageContent({super.key});
  //! Providers
  UserProvider userProvider = sl();
  ProfileProvider profileProvider = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: ColorsStyles.scaffoldBackgroundColor,
        child: SafeArea(
            child: ChangeNotifierProvider.value(
          value: profileProvider,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
            child: Center(child: Consumer<ProfileProvider>(
              builder: (context, value, child) {
                return Column(children: [
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
                        "Update Profile",
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 35, horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 85,
                          width: 85,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          width: 2,
                                          color: ColorsStyles.primaryColor)),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.3),
                                    child: profileProvider.profileImageFile ==
                                            null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child:
                                                Image.asset(AppAssets.profile))
                                        : Image.file(
                                            fit: BoxFit.cover,
                                            profileProvider.profileImageFile!),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 62,
                                child: GestureDetector(
                                  onTap: () {
                                    profileProvider.getFromGallery();
                                  },
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProvider.userDetails!.user.firstName.length +
                                          userProvider.userDetails!.user
                                              .lastName.length >
                                      10
                                  ? userProvider.userDetails!.user.lastName
                                  : "${userProvider.userDetails!.user.firstName} ${userProvider.userDetails!.user.lastName}",
                              style: ColorsStyles.heading1
                                  .copyWith(fontSize: 20.sp),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              userProvider.userDetails!.designationName,
                              style: ColorsStyles.subtitle1
                                  .copyWith(fontSize: 13.sp),
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
                          EditEmployeeDetailsWidget(
                            isActive: profileProvider.emailTextfieldIsActive,
                            title: "Email",
                            subtitleController: TextEditingController(
                                text: "tanzeel.rehman481@gmail.com"),
                            onTap: () {
                              activeEmailTextField();
                            },
                          ),
                          EditEmployeeDetailsWidget(
                            title: "Mobile No.",
                            isActive:
                                profileProvider.contactNumberTextfieldIsActive,
                            subtitleController:
                                TextEditingController(text: "03339959534"),
                            onTap: () {
                              activeContactNoTextField();
                            },
                          ),
                          EditEmployeeDetailsWidget(
                            isActive: profileProvider
                                .emergencyNumberTextfieldIsActive,
                            onTap: () {
                              activeEmergencyContactNoTextField();
                            },
                            title: "Emergency Contact No.",
                            subtitleController:
                                TextEditingController(text: "03339959534"),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ContinueButton(text: "Save", onPressed: (() {}))
                        ],
                      ),
                    ),
                  ),
                ]);
              },
            )),
          ),
        )),
      ),
    );
  }

  ///! Local Functions ===================================================================================================================
  ///*--------------------------------------------------------------------------------------------------------------------------------------

  /*
  These functions will make bottom border of textfield active [Change the color of bottom border] when click on it,
  But before that it will inactive all the others active textfields
  */

  /// For Email
  void activeEmailTextField() {
    profileProvider.inActiveAllfields();

    profileProvider.emailTextfieldIsActive.value =
        !profileProvider.emailTextfieldIsActive.value;
  }

  /// For Contact Number field
  void activeContactNoTextField() {
    profileProvider.inActiveAllfields();

    profileProvider.contactNumberTextfieldIsActive.value =
        !profileProvider.contactNumberTextfieldIsActive.value;
  }

  /// For Emergency Contact Number field
  void activeEmergencyContactNoTextField() {
    profileProvider.inActiveAllfields();

    profileProvider.emergencyNumberTextfieldIsActive.value =
        !profileProvider.emergencyNumberTextfieldIsActive.value;
  }
}
