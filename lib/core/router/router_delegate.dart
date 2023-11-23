import 'package:ais_reporting/core/utils/extension/extensions.dart';
import 'package:ais_reporting/features/admin/presentation/screens/employee_check_In_out_details_page.dart';
import 'package:ais_reporting/features/admin/presentation/screens/employee_details_page.dart';
import 'package:ais_reporting/features/admin/presentation/screens/employee_leave_requests.dart';
import 'package:ais_reporting/features/admin/presentation/screens/employees_list_page.dart';
import 'package:ais_reporting/features/authentication/login/presentation/pages/login_page.dart';
import 'package:ais_reporting/features/leave/presentation/pages/request_leave_page.dart';
import 'package:ais_reporting/features/profile/presentation/screens/profile_update_page.dart';
import 'package:ais_reporting/features/time_sheet/presentation/screens/team_timesheet_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/profile/presentation/screens/profile_page.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../utils/enums/page_state_enum.dart';
import '../utils/globals/globals.dart';
import 'app_state.dart';
import 'pages.dart';

BuildContext?
    globalHomeContext; // doing this to pop the bottom sheet on home screen

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  late final AppState appState;
  final List<Page> _pages = [];
  late BackButtonDispatcher backButtonDispatcher;

  List<MaterialPage> get pages => List.unmodifiable(_pages);

  AppRouterDelegate(this.appState) {
    appState.addListener(() {
      notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Faulty Code will need to find a way to solve it
    appState.globalErrorShow = (value) {
      context.show(message: value);
    };

    return Container(
      key: ValueKey(pages.last.name),
      child: Navigator(
        key: navigatorKeyGlobal,
        onPopPage: _onPopPage,
        pages: buildPages(),
      ),
    );
  }

  List<Page> buildPages() {
    switch (appState.currentAction.state) {
      case PageState.none:
        break;
      case PageState.addPage:
        addPage(appState.currentAction.page!);
        break;
      case PageState.remove:
        removePage(appState.currentAction.page!);
        break;

      case PageState.pop:
        pop();
        break;
      case PageState.addAll:
        // TODO: Handle this case.
        break;
      case PageState.addWidget:
        pushWidget(
            appState.currentAction.widget!, appState.currentAction.page!);
        break;
      case PageState.replace:
        replace(appState.currentAction.page!);
        break;
      case PageState.replaceAll:
        replaceAll(appState.currentAction.page!);
        break;
      case PageState.removeMany:
      // TODO: Handle this case.
    }
    return List.of(_pages);
  }

  void replaceAll(PageConfiguration newRoute) {
    _pages.clear();
    setNewRoutePath(newRoute);
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  /// This method adds pages based on the PageConfig received
  /// [Input]: [PageConfiguration]
  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage =
        _pages.isEmpty || (_pages.last.name != pageConfig.path);

    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.splashPage:
          _addPageData(const SplashScreen(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;

        case Pages.loginPage:
          _addPageData(LoginScreen(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;

        case Pages.dashboardPage:
          _addPageData(const HomeScreen(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;
        //! Profile
        case Pages.profilePage:
          _addPageData(const ProfilePage(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;
        case Pages.profileUpdatePage:
          _addPageData(ProfileUpdatePage(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;

        case Pages.requestLeavePage:
          _addPageData(RequestLeaveScreen(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;
        case Pages.employeeListpage:
          _addPageData(const EmployeeListPage(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;
        case Pages.employeeDetailpage:
          _addPageData(const EmployeeDetailsPage(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;
        case Pages.employeeCheckInOutDetailpage:
          _addPageData(const EmployeeCheckInOutDetailsPage(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;
        case Pages.teamtimesheetpage:
          _addPageData(TeamTimeSheetPage(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;
        case Pages.teamleaverequests:
          _addPageData(EmployeeLeaveRequestsPage(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;
      }
    }
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child, pageConfig),
    );
  }

  void pushWidget(Widget child, PageConfiguration newRoute) {
    _addPageData(child, newRoute);
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);

    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void pop() {
    if (globalHomeContext != null) {
      Navigator.of(globalHomeContext!).pop();
      globalHomeContext = null;
      return;
    }
    if (canPop()) {
      _removePage(_pages.last as MaterialPage);
    } else {
      // if (_pages.last.name != PagePaths.authWrapperPagePath) {
      //   _homeViewModel.onBottomNavTap(0);
      // }
    }
  }

  void removePage(PageConfiguration page) {
    if (_pages.isNotEmpty) {
      int index = _pages.indexWhere((element) => element.name == page.path);
      if (index != -1) {
        _pages.removeAt(index);
      }
    }
  }

  void _removePage(MaterialPage page) {
    _pages.remove(page);
    // notifyListeners();
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last as MaterialPage);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage =
        _pages.isEmpty || (_pages.last.name != configuration.path);

    if (!shouldAddPage) {
      return SynchronousFuture(null);
    }
    _pages.clear();
    addPage(configuration);

    return SynchronousFuture(null);
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => navigatorKeyGlobal;
}
