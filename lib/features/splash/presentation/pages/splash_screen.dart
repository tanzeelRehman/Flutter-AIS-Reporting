import 'package:ais_reporting/core/router/app_state.dart';
import 'package:ais_reporting/core/router/models/page_config.dart';
import 'package:ais_reporting/core/services/user_provider.dart';
import 'package:ais_reporting/core/utils/enums/page_state_enum.dart';
import 'package:ais_reporting/core/utils/globals/globals.dart';
import 'package:ais_reporting/features/authentication/login/data/modals/login_response_modal.dart';
import 'package:ais_reporting/features/time_sheet/presentation/screens/add_project_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToScreen();
  }

  final AuthServices _authServices = sl();
  // final UserService _userServices = sl();
  goToScreen() async {
    UserProvider userProvider = sl();

    LoginResponseModel? user = await _authServices.checkIfUserLoggedIn();

    // Navigator.of(context).push(PageRouteBuilder(
    //     pageBuilder: (context, animation, _) {
    //       return AddProjectPage();
    //     },
    //     opaque: false));

    if (user != null) {
      userProvider.setLoggedInUser(user);

      AppState appState = sl();
      appState.goToNext(PageConfigs.dashboardPageConfig,
          pageState: PageState.replaceAll);
    } else {
      AppState appState = sl();
      appState.goToNext(PageConfigs.loginPageConfig,
          pageState: PageState.replaceAll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: 200.h,
            child: Image.asset(
              'assets/images/ic_ais_logo.png',
              fit: BoxFit.contain,
            )),
      ),
    );
  }
}
