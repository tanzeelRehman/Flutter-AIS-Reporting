import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router/back_button_dispatcher.dart';
import 'core/router/router_delegate.dart';
import 'core/router/router_parser.dart';
import 'core/utils/globals/globals.dart';
import 'core/utils/theme/app_theme.dart';

bool isSessionExpired = false;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppRouterDelegate delegate;
  late BackButtonDispatcher backButtonDispatcher;
  late RouterParser parser = RouterParser();

  @override
  void initState() {
    delegate = AppRouterDelegate(sl());
    backButtonDispatcher = AppBackButtonDispatcher(sl());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ScreenUtilInit(
      designSize: const Size(360, 804),
      builder: (c, ch) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: snackbarKey,
          title: 'Starting Project',
          theme: AppTheme.appTheme,
          routerDelegate: delegate,
          backButtonDispatcher: backButtonDispatcher,
          routeInformationParser: parser,
        ),
      ),
    );
  }
}
