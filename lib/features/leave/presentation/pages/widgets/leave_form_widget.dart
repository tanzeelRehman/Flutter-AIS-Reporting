// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:ais_reporting/core/utils/globals/snack_bar.dart';
import 'package:ais_reporting/core/widgets/custom/custom_text_form_field.dart';
import 'package:ais_reporting/features/leave/presentation/pages/widgets/persons_select_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/theme/color_style.dart';
import '../../../../../core/widgets/custom/continue_button.dart';
import '../../../data/models/jobs_reassign_to_response_model.dart';
import '../../provider/leave_provider.dart';

class LeaveFormWidget extends StatefulWidget {
  bool isMultipleLeavesSelected;
  LeaveFormWidget({
    Key? key,
    required this.isMultipleLeavesSelected,
  }) : super(key: key);

  @override
  State<LeaveFormWidget> createState() => _LeaveFormWidgetState();
}

class _LeaveFormWidgetState extends State<LeaveFormWidget> {
  ///* Controllers
  TextEditingController workToadyController = TextEditingController();
  TextEditingController reasonForLeaveController = TextEditingController();

  ///* Focus Nodes
  FocusNode workToadyFocusNode = FocusNode();
  FocusNode reasonForLeaveFocusNode = FocusNode();

  JobReAssignResponse? personToAssignJob;

  LeaveProvider leaveProvider = sl();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// [Multiple] leave switch is off
        /// ? Single Leave Selected
        if (!widget.isMultipleLeavesSelected)
          ValueListenableBuilder(
              valueListenable:
                  context.read<LeaveProvider>().selectedSingleLaveDate,
              builder: ((context, value, child) {
                return GestureDetector(
                  onTap: () async {
                    context
                        .read<LeaveProvider>()
                        .selectDateForSingleLeave(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15.h),
                    height: 55,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration:
                        ColorsStyles.roundedContainerDecoration.copyWith(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: ColorsStyles.primaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 200,
                            child: Text(
                              !context.read<LeaveProvider>().datePicked
                                  ? "Select date of leave"
                                  : "leave on day ${(DateFormat('EEEE').format(context.read<LeaveProvider>().selectedSingleLaveDate.value))}",
                              style: ColorsStyles.subtitle1.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                );
              })),

        /// [Multiple] leave switch is on
        /// ? Selelct Multiple Leaves
        if (widget.isMultipleLeavesSelected)
          ValueListenableBuilder(
              valueListenable: context.read<LeaveProvider>().selectedLeaveDates,
              builder: ((context, value, child) {
                return GestureDetector(
                  onTap: () async {
                    context
                        .read<LeaveProvider>()
                        .selectDateRangeForLeave(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 15.h),
                    height: 55,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration:
                        ColorsStyles.roundedContainerDecoration.copyWith(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: ColorsStyles.primaryColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 200,
                            child: Text(
                              !context.read<LeaveProvider>().datePicked
                                  ? "Select date range"
                                  : "You requested for ${context.read<LeaveProvider>().noOfDaysForTheLeave} days leave",
                              style: ColorsStyles.subtitle1.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                );
              })),
        SizedBox(
          height: 15.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              controller: reasonForLeaveController,
              focusNode: reasonForLeaveFocusNode,
              hintText: "Reason for leave",
              height: 55.h,
              width: double.infinity,
              prefixIcon: Icon(
                Icons.question_mark,
                color: ColorsStyles.primaryColor,
              ),
            ),

            /// [Multiple] leave switch is on
            ///? Atttach File
            // if (widget.isMultipleLeavesSelected)
            //   Container(
            //       height: 100.h,
            //       width: double.infinity,
            //       alignment: Alignment.center,
            //       padding: EdgeInsets.symmetric(horizontal: 8.sp),
            //       decoration: ColorsStyles.roundedContainerDecoration,
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.attach_file,
            //             color: ColorsStyles.primaryColor,
            //           )
            //         ],
            //       )),
            SizedBox(
              height: 15.h,
            ),

            Container(
              height: 100,
              decoration: ColorsStyles.roundedContainerDecoration,
              child: TextFormField(
                style: ColorsStyles.heading1
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                cursorColor: Colors.grey,
                focusNode: workToadyFocusNode,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    hintText: "Your today task",
                    hintStyle: ColorsStyles.subtitle1.copyWith(
                      fontSize: 12,
                    )),
                autovalidateMode: AutovalidateMode.always,
                controller: workToadyController,
                maxLines: 5,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              height: 55,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: ColorsStyles.roundedContainerDecoration.copyWith(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: ColorsStyles.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: ((context) {
                              return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                  child: PersonsSelectBottomSheet());
                            })).then((value) {
                          if (value != null) {
                            personToAssignJob = value;
                            context
                                .read<LeaveProvider>()
                                .personToAssignTaskSelected
                                .value = true;
                          }
                        });
                      },
                      child: ValueListenableBuilder(
                          valueListenable: context
                              .read<LeaveProvider>()
                              .personToAssignTaskSelected,
                          builder: ((context, value, child) {
                            return SizedBox(
                                width: 200,
                                child: Text(
                                  value
                                      ? personToAssignJob!.fullName
                                      : "Person to assign task",
                                  style: ColorsStyles.subtitle1.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ));
                          }))),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ContinueButton(
                loadingNotifier: leaveProvider.requestingLeave,
                text: "Get Leave",
                onPressed: (() {
                  validateAndApplyLeave();
                }))
          ],
        )
      ],
    );
  }
  //!---------------------------------------------------------------------------------------------------
  /// Local Methods
  //!-------------------------------------------------------------------------------------------------

  void validateAndApplyLeave() {
    if (leaveProvider.datePicked) {
      if (reasonForLeaveController.text.isEmpty ||
          reasonForLeaveController.text.length < 4) {
        ShowSnackBar.show("Please enter a valid leave reason");
        reasonForLeaveFocusNode.requestFocus();
        return;
      }
      if (workToadyController.text.isEmpty ||
          workToadyController.text.length < 4) {
        ShowSnackBar.show("Please enter a valid task");
        workToadyFocusNode.requestFocus();
        return;
      }
      context
          .read<LeaveProvider>()
          .applyForLeave(
              jobInHand: workToadyController.text,
              reason: reasonForLeaveController.text,
              leaveStartDate: decideLeaveStartDate(),
              leaveEndDate: decideLeaveEndDate(),
              noOfDays: context.read<LeaveProvider>().noOfDaysForTheLeave,
              taskAssignto: leaveProvider.personToAssignTaskSelected.value
                  ? personToAssignJob!.userId
                  : 0)
          .then((value) {
        if (Scaffold.of(context).isDrawerOpen) {
          Scaffold.of(context).closeDrawer();
        }
      });
    } else {
      ShowSnackBar.show("Please pick leave date");
    }
  }

  String decideLeaveStartDate() {
    if (widget.isMultipleLeavesSelected) {
      return DateFormat('yyyy-MM-dd')
          .format(context.read<LeaveProvider>().selectedLeaveDates.value.start);
    } else {
      return DateFormat('yyyy-MM-dd')
          .format(context.read<LeaveProvider>().selectedSingleLaveDate.value);
    }
  }

  String decideLeaveEndDate() {
    if (widget.isMultipleLeavesSelected) {
      return DateFormat('yyyy-MM-dd')
          .format(context.read<LeaveProvider>().selectedLeaveDates.value.end);
    } else {
      return DateFormat('yyyy-MM-dd')
          .format(context.read<LeaveProvider>().selectedSingleLaveDate.value);
    }
  }
}
