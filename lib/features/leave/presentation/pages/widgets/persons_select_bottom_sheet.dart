import 'package:ais_reporting/features/leave/presentation/provider/leave_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../../../../../core/utils/theme/color_style.dart';
import '../../../../../core/utils/globals/globals.dart';

class PersonsSelectBottomSheet extends StatelessWidget {
  PersonsSelectBottomSheet({super.key});
  LeaveProvider leaveProvider = sl();
  TextEditingController searchPersonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: leaveProvider,
      builder: (context, child) {
        return Container(
          decoration: ColorsStyles.roundedContainerDecoration
              .copyWith(color: ColorsStyles.canvasColor),
          height: MediaQuery.of(context).size.height * 0.85,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Container(
                height: 55,
                decoration: ColorsStyles.roundedContainerDecoration,
                child: TextFormField(
                  style: ColorsStyles.heading1.copyWith(fontSize: 12),
                  onChanged: (value) {
                    context.read<LeaveProvider>().queryPersonsNames(value);
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
                  controller: searchPersonController,
                  maxLines: 5,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ValueListenableBuilder(
                  valueListenable: leaveProvider.queryNameList,
                  builder: ((context, value, child) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          itemCount: leaveProvider.queryNameList.value.length,
                          itemBuilder: ((context, index) {
                            if (leaveProvider.queryNameList.value.isEmpty) {
                              return const Center(
                                child: Text("No Employee found"),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () =>
                                    Navigator.pop(context, value[index]),
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 5.h),
                                  decoration:
                                      ColorsStyles.roundedContainerDecoration,
                                  height: 65.h,
                                  width: double.infinity - 50,
                                  child: Row(
                                    children: [
                                      Icon(
                                        size: 25.sp,
                                        Icons.person,
                                        color: ColorsStyles.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            value[index].fullName,
                                            style: ColorsStyles.heading1
                                                .copyWith(fontSize: 15),
                                          ),
                                          Text(
                                            value[index].designationName,
                                            style: ColorsStyles.subtitle1
                                                .copyWith(fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          })),
                    );
                  }))
            ],
          ),
        );
      },
    );
  }
}
