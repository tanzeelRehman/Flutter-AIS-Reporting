// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/theme/color_style.dart';

class CustomTextFormField extends StatefulWidget {
  TextEditingController controller;
  FocusNode? focusNode;
  String hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obsecure;
  bool isPassword;
  double height;
  double width;
  Function(String value)? onChanged;
  CustomTextFormField({
    Key? key,
    required this.controller,
    this.hintText = "Input here",
    this.height = 55,
    this.width = double.infinity,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.onChanged,
    this.obsecure = false,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: widget.width,
      alignment: Alignment.center,
      //  padding: EdgeInsets.symmetric(horizontal: 8.sp),
      decoration: ColorsStyles.roundedContainerDecoration,
      child: TextFormField(
        obscureText: widget.obsecure,
        obscuringCharacter: "*",
        style: ColorsStyles.heading1
            .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
        cursorColor: Colors.grey,
        onChanged: widget.onChanged ?? (value) {},
        controller: widget.controller,
        focusNode: widget.focusNode ?? FocusNode(),
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: ColorsStyles.subtitle1
                .copyWith(fontSize: 12, fontWeight: FontWeight.normal),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: (() {
                      setState(() {
                        widget.obsecure = !widget.obsecure;
                      });
                    }),
                    icon: Icon(
                      color: ColorsStyles.primaryColor,
                      widget.obsecure ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : widget.suffixIcon ?? const SizedBox.shrink(),
            border: InputBorder.none),
      ),
    );
  }
}
