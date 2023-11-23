import 'package:ais_reporting/features/profile/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';

class EditEmployeeDetailsWidget extends StatefulWidget {
  String title;
  TextEditingController subtitleController;

  ValueNotifier isActive;
  Function() onTap;

  EditEmployeeDetailsWidget(
      {Key? key,
      required this.title,
      required this.subtitleController,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  State<EditEmployeeDetailsWidget> createState() =>
      _EditEmployeeDetailsWidgetState();
}

class _EditEmployeeDetailsWidgetState extends State<EditEmployeeDetailsWidget> {
  bool onTap = false;

  ProfileProvider profileProvider = sl();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.isActive,
        builder: ((context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.title,
                    style: ColorsStyles.heading1.copyWith(fontSize: 15),
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  Container(
                      height: 43.h,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        //color: Colors.blue,
                        border: Border(
                            bottom: BorderSide(
                                color: value
                                    ? ColorsStyles.primaryColor
                                    : Colors.grey)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextField(
                              onTap: widget.onTap,
                              textAlignVertical: TextAlignVertical.center,
                              controller: widget.subtitleController,
                              cursorColor: Colors.grey,
                              cursorHeight: 25,
                              style:
                                  ColorsStyles.subtitle1.copyWith(fontSize: 15),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            ),
                          ),
                          Icon(
                            color:
                                value ? ColorsStyles.primaryColor : Colors.grey,
                            Icons.edit_note,
                            size: 25,
                          )
                        ],
                      )),
                ],
              ),
            ],
          );
        }));
  }
}
