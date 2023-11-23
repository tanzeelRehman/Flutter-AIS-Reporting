// import 'package:ais_reporting/core/utils/theme/color_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomTextFormField extends StatelessWidget {
//   CustomTextFormField({
//     required this.hintText,
//     required this.labelText,
//     this.obscureText = false,
//     this.readOnly = false,
//     this.controller,
//     this.keyboardType,
//     this.inputFormatters,
//     this.focusNode,
//     this.onFieldSubmitted,
//     this.onChanged,
//     this.validator,
//     this.maxLines,
//     this.enabled,
//     this.contentPadding,
//     this.prefixIconPath,
//     this.suffixIconPath,
//     this.suffixIconOnTap,
//     this.onTap,
//     this.suffix,
//     this.prefix,
//     this.networkPrefix = false,
//     this.interactiveSelection = true,
//     this.maxLength,
//     this.minLength,
//     this.maxLengthEnforced,
//     this.minLines,
//     this.textInputAction,
//     Key? key,
//     this.isPassword = false,
//     this.autovalidateMode,
//   }) : super(key: key);

//   final String hintText;
//   final String labelText;
//   final bool obscureText;
//   final bool readOnly;
//   final FocusNode? focusNode;
//   final TextInputType? keyboardType;
//   final Function(String)? onChanged;
//   final TextEditingController? controller;
//   final Function(String)? onFieldSubmitted;
//   final List<TextInputFormatter>? inputFormatters;
//   final String? Function(String?)? validator;
//   final int? maxLines;
//   final int? minLines;
//   final int? maxLength;
//   final int? minLength;
//   final bool? maxLengthEnforced;
//   final bool? enabled;
//   final EdgeInsets? contentPadding;
//   final Widget? prefixIconPath;
//   final Widget? suffixIconPath;
//   final Function()? suffixIconOnTap;
//   final Function()? onTap;
//   final Widget? prefix;
//   final Widget? suffix;
//   final bool networkPrefix;
//   final bool interactiveSelection;
//   final TextInputAction? textInputAction;
//   final AutovalidateMode? autovalidateMode;
//   bool isPassword;
//   ValueNotifier<bool> obscurePasswod = ValueNotifier(true);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (labelText.isNotEmpty)
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Text(
//               labelText,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText2
//                   ?.copyWith(fontWeight: FontWeight.w800),
//             ),
//           ),
//         ValueListenableBuilder<bool>(
//             valueListenable: obscurePasswod,
//             builder: (_, obscure, __) {
//               return TextFormField(
//                 cursorColor: Colors.grey,
//                 autovalidateMode: autovalidateMode,
//                 enableInteractiveSelection: interactiveSelection,
//                 readOnly: readOnly,
//                 enabled: enabled,
//                 obscureText: isPassword ? obscure : false,
//                 obscuringCharacter: '●',
//                 controller: controller,
//                 keyboardType: keyboardType,
//                 inputFormatters: inputFormatters,
//                 focusNode: focusNode,
//                 onFieldSubmitted: onFieldSubmitted,
//                 onChanged: onChanged,
//                 cursorHeight: 20,
//                 maxLines: maxLines,
//                 minLines: minLines,
//                 textInputAction: textInputAction,
//                 maxLength: maxLength,
//                 maxLengthEnforcement: maxLengthEnforced == true
//                     ? MaxLengthEnforcement.enforced
//                     : MaxLengthEnforcement.none,
//                 onTap: onTap,
//                 style: ColorsStyles.heading1.copyWith(fontSize: 15),
//                 decoration: InputDecoration(
//                   counterText: "",
//                   filled: false,
//                   fillColor: Theme.of(context).scaffoldBackgroundColor,
//                   hintText: hintText,
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                   border: InputBorder.none,
//                   errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(
//                           width: 1, color: Colors.grey.withOpacity(.8))),
//                   focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(
//                           width: 1, color: Colors.grey.withOpacity(.8))),
//                   suffixIcon: suffixIconPath,
//                   prefixIcon: prefixIconPath,
//                   prefixIconConstraints:
//                       BoxConstraints(minWidth: 24.w, minHeight: 24.w),
//                   suffixIconConstraints:
//                       BoxConstraints(minWidth: 24.w, minHeight: 24.w),
//                   suffix: isPassword
//                       ? GestureDetector(
//                           onTap: () {
//                             obscurePasswod.value = !obscurePasswod.value;
//                           },
//                           child: Icon(
//                             obscure ? Icons.visibility : Icons.visibility_off,
//                           ),
//                         )
//                       : null,
//                   prefix: prefix,
//                 ),
//                 validator: validator,
//               );
//             }),
//       ],
//     );
//   }
// }
