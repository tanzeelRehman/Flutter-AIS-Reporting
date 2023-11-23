import 'package:ais_reporting/core/router/app_state.dart';
import 'package:ais_reporting/core/utils/constants/app_assets.dart';
import 'package:ais_reporting/core/utils/globals/globals.dart';
import 'package:ais_reporting/core/utils/theme/color_style.dart';
import 'package:ais_reporting/features/admin/presentation/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EmployeeLeaveRequestsPage extends StatelessWidget {
  const EmployeeLeaveRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //! Providers
    Adminprovider provider = sl();
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: provider)],
      child: EmployeeLeaveRequetsPageContent(),
    );
  }
}

class EmployeeLeaveRequetsPageContent extends StatefulWidget {
  EmployeeLeaveRequetsPageContent({super.key});

  @override
  State<EmployeeLeaveRequetsPageContent> createState() =>
      _EmployeeLeaveRequetsPageContentState();
}

class _EmployeeLeaveRequetsPageContentState
    extends State<EmployeeLeaveRequetsPageContent> {
  AppState appState = sl();
  Adminprovider provider = sl();

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    await provider.getTeamLeaveRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyles.scaffoldBackgroundColor,
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: ValueListenableBuilder(
                valueListenable: provider.gettingTeamLeaveRequests,
                builder: (context, value, child) {
                  if (value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
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
                              "Team Leave Requests",
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
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.7,
                        //   child: ListView.builder(
                        //     itemCount: provider.teamLeaveRequestsResponseModel
                        //             ?.response.length ??
                        //         0,
                        //     itemBuilder: (context, index) {
                        //       return Container(
                        //         margin:
                        //             const EdgeInsets.symmetric(vertical: 15),
                        //         decoration:
                        //             ColorsStyles.roundedContainerDecoration,
                        //         child: ListTile(
                        //           onTap: () {},
                        //           title: Row(
                        //             children: [
                        //               Text(
                        //                 provider.teamLeaveRequestsResponseModel!
                        //                     .response[index].firstName,
                        //                 style: ColorsStyles.heading1
                        //                     .copyWith(fontSize: 15),
                        //               ),
                        //               Text(
                        //                 provider.teamLeaveRequestsResponseModel!
                        //                     .response[index].lastName,
                        //                 style: ColorsStyles.heading1
                        //                     .copyWith(fontSize: 15),
                        //               ),
                        //             ],
                        //           ),
                        //           subtitle: Column(
                        //             children: [
                        //               SizedBox(
                        //                 height: 5.h,
                        //               ),
                        //               Row(
                        //                 children: [
                        //                   Text("Requested",
                        //                       style: ColorsStyles.subtitle1),
                        //                   Text(
                        //                     provider
                        //                         .teamLeaveRequestsResponseModel!
                        //                         .response[index]
                        //                         .noOfDays
                        //                         .toString(),
                        //                     style: TextStyle(
                        //                         color:
                        //                             ColorsStyles.primaryColor,
                        //                         fontWeight: FontWeight.bold,
                        //                         fontSize: 16),
                        //                   ),
                        //                   Text("days",
                        //                       style: ColorsStyles.subtitle1),
                        //                   Text(
                        //                     provider
                        //                         .teamLeaveRequestsResponseModel!
                        //                         .response[index]
                        //                         .leaveName,
                        //                     style: TextStyle(
                        //                         color:
                        //                             ColorsStyles.primaryColor,
                        //                         fontWeight: FontWeight.bold,
                        //                         fontSize: 16),
                        //                   ),
                        //                   Text("Leave",
                        //                       style: ColorsStyles.subtitle1),
                        //                 ],
                        //               ),
                        //               SizedBox(
                        //                 height: 5.h,
                        //               ),
                        //               Row(
                        //                 children: [
                        //                   Text(
                        //                     DateFormat.MEd()
                        //                         .format(DateTime.now()),
                        //                     style: ColorsStyles.subtitle1
                        //                         .copyWith(fontSize: 12),
                        //                   ),
                        //                   Text(" to ",
                        //                       style: ColorsStyles.subtitle1
                        //                           .copyWith(
                        //                               fontSize: 12,
                        //                               color: ColorsStyles
                        //                                   .primaryColor)),
                        //                   Text(
                        //                       DateFormat.MEd()
                        //                           .format(DateTime.now()),
                        //                       style: ColorsStyles.subtitle1
                        //                           .copyWith(fontSize: 12)),
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //           trailing: Column(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Container(
                        //                 width: 25,
                        //                 height: 25,
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.green,
                        //                     borderRadius:
                        //                         BorderRadius.circular(50.r)),
                        //                 child: Icon(
                        //                   Icons.check,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //               Container(
                        //                 width: 25,
                        //                 height: 25,
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.red,
                        //                     borderRadius:
                        //                         BorderRadius.circular(50.r)),
                        //                 child: Icon(
                        //                   Icons.remove,
                        //                   color: Colors.white,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // )
                      ],
                    );
                  }
                },
              ))),
    );
  }
}
