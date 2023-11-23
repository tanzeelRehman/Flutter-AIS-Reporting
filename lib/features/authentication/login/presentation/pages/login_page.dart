import 'package:ais_reporting/core/utils/globals/snack_bar.dart';
import 'package:ais_reporting/core/widgets/custom/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/theme/color_style.dart';
import '../../../../../core/widgets/custom/continue_button.dart';
import '../manager/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthProvider loginProvider = sl();

  String emailText = '';

  String passwordText = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: loginProvider,
      child: Consumer<AuthProvider>(builder: (_, provider, __) {
        return Scaffold(
          backgroundColor: ColorsStyles.scaffoldBackgroundColor,
          body: SafeArea(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 22.h,
                        ),
                        SizedBox(
                          height: 150.h,
                          // child: Image.asset(
                          //   'assets/images/ic_ais_logo.png',
                          //   color: Colors.white,
                          //   fit: BoxFit.contain,
                          // )
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          'Reporting',
                          style: ColorsStyles.heading1.copyWith(
                              color: ColorsStyles.primaryColor, fontSize: 25),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        CustomTextFormField(
                          height: 55.h,
                          width: double.infinity,
                          hintText: "Email",
                          onChanged: (value) {
                            emailText = value;
                          },
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: ColorsStyles.primaryColor,
                          ),
                          controller: provider.loginEmailController,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          height: 55.h,
                          width: double.infinity,
                          hintText: "Password",
                          onChanged: (value) {
                            passwordText = value;
                          },
                          isPassword: true,
                          obsecure: true,
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            color: ColorsStyles.primaryColor,
                          ),
                          controller: provider.loginPasswordController,
                        ),
                        SizedBox(height: 10.h),
                        GestureDetector(
                          onTap: () async {
                            print("hello");

                            // await showDialog(
                            //     context: context,
                            //     builder: ((context) {
                            //       return CustomDialog(
                            //           isSucess: true,
                            //           decription: "Email has been sent",
                            //           onPressed: () {
                            //             Navigator.pop(context);
                            //           },
                            //           isError: false);
                            //     }));
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) => ForgotPassword(),
                            //   ),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 180),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.sp,
                                  color: ColorsStyles.primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h),
                        SizedBox(
                          height: 50.h,
                          width: double.infinity,
                          child: ContinueButton(
                            backgroundColor: ColorsStyles.primaryColor,
                            text: 'Login',
                            loadingNotifier: provider.loginLoading,
                            onPressed: () {
                              if (provider
                                      .loginEmailController.text.isNotEmpty &&
                                  provider.loginPasswordController.text
                                      .isNotEmpty) {
                                provider.login();
                              } else {
                                ShowSnackBar.show(
                                    'please Provide valid email and password');
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        );
      }),
    );
  }
}
