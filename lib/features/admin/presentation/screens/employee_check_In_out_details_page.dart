// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:ais_reporting/features/admin/presentation/providers/employee_check_in_out_details_provider.dart';

import '../../../../core/router/app_state.dart';
import '../../../../core/utils/constants/app_assets.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';

class EmployeeCheckInOutDetailsPage extends StatelessWidget {
  const EmployeeCheckInOutDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //! Providers
    EmployeeCheckInOutDetailsProvider provider = sl();
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: provider)],
      child: EmployeeCheckInOutDetailsPageContent(),
    );
  }
}

class EmployeeCheckInOutDetailsPageContent extends StatelessWidget {
  EmployeeCheckInOutDetailsPageContent({super.key});

  //! Providers
  EmployeeCheckInOutDetailsProvider provider = sl();

  //! Controllers
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyles.scaffoldBackgroundColor,
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: SingleChildScrollView(
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
                    "Attendence",
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
              // * Body -----------------------------------------------------------
              Column(
                children: [
                  SizedBox(
                    height: 40.h,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //! Start date
                        ValueListenableBuilder(
                            valueListenable: context
                                .read<EmployeeCheckInOutDetailsProvider>()
                                .checkInOutStartdate,
                            builder: ((context, value, child) {
                              return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<
                                            EmployeeCheckInOutDetailsProvider>()
                                        .selectCheckInOutStartDate(context);
                                  },
                                  child: Text(
                                    style: ColorsStyles.subtitle1.copyWith(
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline,
                                    ),
                                    DateFormat('dd-MM-yyyy').format(context
                                        .read<
                                            EmployeeCheckInOutDetailsProvider>()
                                        .checkInOutStartdate
                                        .value),
                                  ));
                            })),

                        //! End date
                        ValueListenableBuilder(
                            valueListenable: context
                                .read<EmployeeCheckInOutDetailsProvider>()
                                .checkInOutEnddate,
                            builder: ((context, value, child) {
                              return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<
                                            EmployeeCheckInOutDetailsProvider>()
                                        .selectCheckInOutEndDate(context);
                                  },
                                  child: Text(
                                    style: ColorsStyles.subtitle1.copyWith(
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline,
                                    ),
                                    DateFormat('dd-MM-yyyy').format(
                                      context
                                          .read<
                                              EmployeeCheckInOutDetailsProvider>()
                                          .checkInOutEnddate
                                          .value,
                                    ),
                                  ));
                            })),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    height: 45.h,
                    decoration: ColorsStyles.roundedContainerDecoration,
                    alignment: Alignment.center,
                    child: TextFormField(
                      style: ColorsStyles.heading1.copyWith(fontSize: 15),
                      onChanged: (value) {
                        context
                            .read<EmployeeCheckInOutDetailsProvider>()
                            .queryPersonsNames(value);
                      },
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: ColorsStyles.primaryColor,
                          ),
                          hintText: "Search person",
                          hintStyle: ColorsStyles.subtitle1.copyWith(
                            fontSize: 12,
                          )),
                      autovalidateMode: AutovalidateMode.always,
                      controller: searchController,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ValueListenableBuilder(
                    valueListenable: provider.fetchingAttendence,
                    builder: (context, value, child) {
                      return value
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Center(
                                child: Lottie.asset(
                                    height: 100.h, AppAssets.loader2),
                              ))
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.62,
                              child: ListView.builder(
                                  itemCount:
                                      provider.queryAttendenceList.value.length,
                                  itemBuilder: ((context, index) {
                                    return ScheaduleTile(
                                      name:
                                          "${provider.queryAttendenceList.value[index].firstName} ${provider.queryAttendenceList.value[index].lastName}",
                                      dept: provider.queryAttendenceList
                                          .value[index].departmentType,
                                      designation: provider.queryAttendenceList
                                          .value[index].designationName,
                                      checkInTime: provider.queryAttendenceList
                                          .value[index].checkIn,
                                      checkOutTime: provider.queryAttendenceList
                                          .value[index].checkOut,
                                    );
                                  })),
                            );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

class ScheaduleTile extends StatefulWidget {
  String name;
  String designation;
  String dept;
  String? checkInTime;
  String? checkOutTime;

  ScheaduleTile({
    Key? key,
    required this.name,
    required this.designation,
    required this.dept,
    this.checkInTime,
    this.checkOutTime,
  }) : super(key: key);

  @override
  State<ScheaduleTile> createState() => _ScheaduleTileState();
}

class _ScheaduleTileState extends State<ScheaduleTile> {
  String? month;
  String? date;
  String? startedAt;
  String? endedAt;
  @override
  void initState() {
    if (widget.checkInTime != null) {
      DateTime checkIn = DateTime.parse(widget.checkInTime!);
      month = DateFormat('MMMM').format(checkIn);
      date = DateFormat('d').format(checkIn);
      startedAt = DateFormat('Hm').format(checkIn);
      print("Started at");
      print(startedAt);
    }
    if (widget.checkOutTime != null) {
      DateTime checkout = DateTime.parse(widget.checkOutTime!);
      endedAt = DateFormat('Hm').format(checkout);
      print("ended at");
      print(endedAt);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          color: ColorsStyles.canvasColor,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(2, 3))
          ],
          border: Border(
              left: BorderSide(width: 4.0, color: ColorsStyles.primaryColor))),
      height: 125.h,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    month ?? "-",
                    style: ColorsStyles.heading1.copyWith(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                        color: ColorsStyles.primaryColor),
                  ),
                  Text(
                    date ?? "0",
                    style: ColorsStyles.heading1.copyWith(
                        fontSize: 25.sp, color: ColorsStyles.primaryColor),
                  )
                ],
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          widget.name,
                          style:
                              ColorsStyles.heading1.copyWith(fontSize: 20.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.designation} at ",
                        style: ColorsStyles.subtitle1.copyWith(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.dept,
                        style: ColorsStyles.subtitle1.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Container(
            height: 2,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 5.0.sp),
            color: Colors.grey.withOpacity(0.3),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Started at",
                      style: ColorsStyles.subtitle1.copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      startedAt ?? "-/-/-",
                      style: ColorsStyles.subtitle1.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsStyles.primaryColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Ended at",
                      style: ColorsStyles.subtitle1.copyWith(
                          fontSize: 11.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      endedAt ?? "-/-/-",
                      style: ColorsStyles.subtitle1.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsStyles.primaryColor),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
