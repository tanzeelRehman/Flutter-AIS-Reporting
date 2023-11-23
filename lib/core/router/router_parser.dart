import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'models/page_config.dart';
import 'models/page_paths.dart';
import 'pages.dart';

class RouterParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return SynchronousFuture(PageConfigs.splashPageConfig);
    }

    final path = '/${uri.pathSegments[0]}';

    switch (path) {
      case PagePaths.splashPagePath:
        return SynchronousFuture(PageConfigs.splashPageConfig);
      default:
        return SynchronousFuture(PageConfigs.splashPageConfig);
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.splashPage:
        return const RouteInformation(location: PagePaths.splashPagePath);
      // Auth
      case Pages.loginPage:
        return const RouteInformation(location: PagePaths.loginPagePath);
      case Pages.dashboardPage:
        return const RouteInformation(location: PagePaths.dashbaoardPagePath);
      // Profile
      case Pages.profilePage:
        return const RouteInformation(location: PagePaths.profilePagePath);
      case Pages.profileUpdatePage:
        return const RouteInformation(
            location: PagePaths.profileUpdatePagePath);
      // Leave
      case Pages.requestLeavePage:
        return const RouteInformation(location: PagePaths.requestLeavePagePath);
      // Admin
      case Pages.employeeListpage:
        return const RouteInformation(location: PagePaths.employeeListPagePath);
      case Pages.employeeDetailpage:
        return const RouteInformation(
            location: PagePaths.employeeDetailsPagePath);
      case Pages.employeeCheckInOutDetailpage:
        return const RouteInformation(
            location: PagePaths.employeeCheckInOutDetailsPagePath);
      case Pages.teamtimesheetpage:
        return const RouteInformation(
            location: PagePaths.teamTimeSheetPagePath);
      case Pages.teamleaverequests:
        return const RouteInformation(
            location: PagePaths.teamLeaveRequestsPagePath);
    }
  }
}
