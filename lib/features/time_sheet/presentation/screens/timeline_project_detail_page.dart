import 'package:ais_reporting/features/time_sheet/presentation/widgets/time_sheet_container.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/theme/color_style.dart';

class TimeLineProjectDetailPage extends StatelessWidget {
  const TimeLineProjectDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyles.scaffoldBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Timeline details",
              style: ColorsStyles.subtitle1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Z-Store", style: ColorsStyles.heading1),
            const SizedBox(
              height: 30,
            ),
            // Container(
            //   decoration: ColorsStyles.roundedContainerDecoration,
            //   height: MediaQuery.of(context).size.height * 0.2,
            //   width: double.infinity,
            //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "DAY TOTAL",
            //         style: ColorsStyles.subtitle1.copyWith(fontSize: 12),
            //       ),
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       Row(
            //         children: [
            //           SizedBox(
            //             width: 100,
            //             height: 100,
            //             child: SleekCircularSlider(
            //               appearance: CircularSliderAppearance(
            //                   animationEnabled: true,
            //                   customColors: CustomSliderColors(
            //                       progressBarColor: ColorsStyles.primaryColor,
            //                       dynamicGradient: false,
            //                       trackColor:
            //                           ColorsStyles.scaffoldBackgroundColor),
            //                   infoProperties: InfoProperties(
            //                       modifier: (hours) {
            //                         final roundedValue =
            //                             hours.toInt().toString();
            //                         return '$roundedValue hrs';
            //                       },
            //                       mainLabelStyle: ColorsStyles.heading1
            //                           .copyWith(
            //                               color: Colors.white, fontSize: 20),
            //                       bottomLabelText: "Out of 8",
            //                       bottomLabelStyle: ColorsStyles.subtitle1
            //                           .copyWith(fontSize: 10)),
            //                   customWidths: CustomSliderWidths(
            //                     shadowWidth: 0,
            //                     progressBarWidth: 10,
            //                   )),
            //               min: 0,
            //               max: 8,
            //               initialValue: 5,
            //             ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // )
            // TimeSheetContainer(
            //   projectName: "Z-Store",
            //   projectStartTime: "9:30 AM",
            //   projectStatus: "working",
            //   projectStartDate: "1-18-2023",
            // )
          ],
        ),
      )),
    );
  }
}
