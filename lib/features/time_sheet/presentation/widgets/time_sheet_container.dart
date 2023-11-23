// import 'package:flutter/material.dart';
// import '../../../core/utils/theme/color_style.dart';
// import '../provider/time_sheet_provider.dart';

// class TimeSheetContainer extends StatefulWidget {
//   String projectName;
//   String projectStatus;
//   String projectStartTime;
//   String projectStartDate;
//   String projectEndTime;
//   String projectEndDate;
//   TimeSheetContainer(
//       {Key? key,
//       required this.projectName,
//       this.projectStatus = "Paused",
//       this.projectStartDate = "Not started yet",
//       this.projectStartTime = "- - -",
//       this.projectEndTime = "- - -",
//       this.projectEndDate = "Not ended yet"})
//       : super(key: key);

//   @override
//   State<TimeSheetContainer> createState() => _TimeSheetContainerState();
// }

// class _TimeSheetContainerState extends State<TimeSheetContainer>
//     with SingleTickerProviderStateMixin {
//   TimeSheetProvider timeSheetProvider = TimeSheetProvider();
//   @override
//   void initState() {
//     timeSheetProvider.animationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 450))
//       ..addListener(() {
//         setState(() {});
//       });

//     timeSheetProvider.animationController.forward();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height * 0.2;
//     return Container(
//       decoration: ColorsStyles.roundedContainerDecoration,
//       height: 140 +
//           (timeSheetProvider.animationController
//                   .drive(CurveTween(curve: Curves.easeInBack))
//                   .value *
//               height),
//       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
//       width: double.infinity,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   widget.projectName,
//                   style: ColorsStyles.heading1.copyWith(fontSize: 20),
//                 ),
//                 if (timeSheetProvider.animationController.isDismissed)
//                   Text(
//                     widget.projectStatus,
//                     style: ColorsStyles.subtitle1.copyWith(fontSize: 13),
//                   ),
//                 IconButton(
//                   iconSize: 25,
//                   color: ColorsStyles.primaryColor,
//                   icon: AnimatedIcon(
//                     icon: AnimatedIcons.menu_close,
//                     progress: timeSheetProvider.animationController,
//                   ),
//                   onPressed: () {
//                     timeSheetProvider.toggleContainer();
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Status",
//                   style: ColorsStyles.subtitle1.copyWith(fontSize: 15),
//                 ),
//                 const Spacer(),
//                 Text(
//                   widget.projectStatus,
//                   style: ColorsStyles.subtitle1
//                       .copyWith(color: Colors.orange.shade600, fontSize: 15),
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Start time",
//                   style: ColorsStyles.subtitle1.copyWith(fontSize: 15),
//                 ),
//                 const Spacer(),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       widget.projectStartDate,
//                       style: ColorsStyles.heading1.copyWith(fontSize: 15),
//                     ),
//                     Text(
//                       widget.projectStartTime,
//                       style: ColorsStyles.subtitle1.copyWith(fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   width: 15,
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "End time",
//                   style: ColorsStyles.subtitle1.copyWith(fontSize: 15),
//                 ),
//                 // DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime([2022,] ), lastDate: lastDate)
//                 const Spacer(),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       widget.projectEndDate,
//                       style: ColorsStyles.heading1.copyWith(fontSize: 15),
//                     ),
//                     Text(
//                       widget.projectEndTime,
//                       style: ColorsStyles.subtitle1.copyWith(fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   width: 15,
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     // DashboardProvider provider = DashboardProvider();

//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: ((context) => DashboardPage(
//                     //               goTothird: true,
//                     //             ))));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: ColorsStyles.primaryColor,
//                         borderRadius: BorderRadius.circular(30)),
//                     height: 55,
//                     alignment: Alignment.center,
//                     width: MediaQuery.of(context).size.width * 0.55,
//                     child: Text(
//                       "Finish",
//                       style: ColorsStyles.heading1.copyWith(fontSize: 20),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
