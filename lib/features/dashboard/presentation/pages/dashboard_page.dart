import 'package:ais_reporting/features/dashboard/presentation/pages/drawer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/app_exit_popup_dialog.dart';
import '../../../../core/utils/globals/globals.dart';
import '../../../../core/utils/theme/color_style.dart';
import '../manager/dashboard_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardProvider dashboardProvider = sl();
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: dashboardProvider)],
        child: DashboardPageContent());
  }
}

class DashboardPageContent extends StatelessWidget {
  const DashboardPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardProvider dashboardProvider = sl();
    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);
      },
      child: Scaffold(
          backgroundColor: Colors.blueGrey,
          key: drawerKey,
          drawer: Drawer(child: DrawerPage()),
          body: PageView(
            controller: dashboardProvider.pageController,
            physics: const ScrollPhysics(),
            children: dashboardProvider.pages,
          ),
          extendBody: true,
          bottomNavigationBar: ValueListenableBuilder(
              valueListenable: dashboardProvider.currentPageIndexNotifier,
              builder: ((context, value, child) {
                return Container(
                    height: 73,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0,
                            blurRadius: 10),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      child: BottomNavigationBar(
                        backgroundColor: ColorsStyles.canvasColor,
                        currentIndex:
                            dashboardProvider.currentPageIndexNotifier.value,
                        onTap: (index) {
                          dashboardProvider.changePageIndex(index);
                        },
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                              activeIcon: Icon(
                                size: 30,
                                Icons.dashboard,
                                color: ColorsStyles.primaryColor,
                              ),
                              icon: const Icon(
                                  size: 30,
                                  color: Colors.white,
                                  Icons.dashboard_outlined),
                              label: ''),
                          // BottomNavigationBarItem(
                          //     activeIcon: Icon(
                          //       size: 30,
                          //       Icons.checklist,
                          //       color: ColorsStyles.primaryColor,
                          //     ),
                          //     icon: const Icon(
                          //       size: 30,
                          //       Icons.checklist,
                          //       color: Colors.white,
                          //     ),
                          //     label: ''),
                          BottomNavigationBarItem(
                              activeIcon: Icon(
                                size: 30,
                                Icons.history,
                                color: ColorsStyles.primaryColor,
                              ),
                              icon: const Icon(
                                size: 30,
                                Icons.history,
                                color: Colors.white,
                              ),
                              label: ''),
                        ],
                      ),
                    ));
              }))),
    );
  }
}
