import 'package:ais_reporting/core/router/models/page_keys.dart';
import 'package:ais_reporting/core/router/models/page_paths.dart';

import '../pages.dart';

class PageConfigs {
  static PageConfiguration splashPageConfig = const PageConfiguration(
      key: PageKeys.splashPageKey,
      path: PagePaths.splashPagePath,
      uiPage: Pages.splashPage);

  static PageConfiguration loginPageConfig = const PageConfiguration(
      key: PageKeys.loginPageKey,
      path: PagePaths.loginPagePath,
      uiPage: Pages.loginPage);
  static PageConfiguration dashboardPageConfig = const PageConfiguration(
      key: PageKeys.dashboardPageKey,
      path: PagePaths.dashbaoardPagePath,
      uiPage: Pages.dashboardPage);

  //! Profile
  static PageConfiguration profilePageConfig = const PageConfiguration(
      key: PageKeys.profilePageKey,
      path: PagePaths.profilePagePath,
      uiPage: Pages.profilePage);

  static PageConfiguration profileUpdatePageConfig = const PageConfiguration(
      key: PageKeys.profileUpdatePageKey,
      path: PagePaths.profileUpdatePagePath,
      uiPage: Pages.profileUpdatePage);

  static PageConfiguration requestLeavePageConfig = const PageConfiguration(
      key: PageKeys.requestLeavePageKey,
      path: PagePaths.requestLeavePagePath,
      uiPage: Pages.requestLeavePage);

  ///! Admin
  static PageConfiguration employeesListPageConfig = const PageConfiguration(
      key: PageKeys.employeeListPageKey,
      path: PagePaths.employeeListPagePath,
      uiPage: Pages.employeeListpage);

  static PageConfiguration employeeDetailsPageConfig = const PageConfiguration(
      key: PageKeys.employeeDetailsPageKey,
      path: PagePaths.employeeDetailsPagePath,
      uiPage: Pages.employeeDetailpage);

  static PageConfiguration employeeCheckInOutDetailsPageConfig =
      const PageConfiguration(
          key: PageKeys.employeeCheckInOutDetailsPageKey,
          path: PagePaths.employeeCheckInOutDetailsPagePath,
          uiPage: Pages.employeeCheckInOutDetailpage);

  static PageConfiguration teamTimeSheetPageConfig = const PageConfiguration(
      key: PageKeys.teamTimeSheetPageKey,
      path: PagePaths.teamTimeSheetPagePath,
      uiPage: Pages.teamtimesheetpage);

  static PageConfiguration teamLeaveRequestsPageConfig =
      const PageConfiguration(
          key: PageKeys.teamLeaverequestsPageKey,
          path: PagePaths.teamLeaveRequestsPagePath,
          uiPage: Pages.teamleaverequests);
}
