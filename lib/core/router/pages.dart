import 'package:equatable/equatable.dart';

class PageConfiguration extends Equatable {
  final String key;
  final String path;
  final Pages uiPage;
  final Map<String, dynamic> arguments;

  const PageConfiguration({
    required this.key,
    required this.path,
    required this.uiPage,
    this.arguments = const {},
  });
  factory PageConfiguration.withArguments(
      PageConfiguration pageConfiguration, Map<String, dynamic> arguments) {
    return PageConfiguration(
        uiPage: pageConfiguration.uiPage,
        key: pageConfiguration.key,
        path: pageConfiguration.path,
        arguments: arguments);
  }
  @override
  List<Object?> get props => [key, path, uiPage, arguments];
}

enum Pages {
  splashPage,

  /// Auth
  loginPage,
  dashboardPage,

  /// Profile
  profilePage,
  profileUpdatePage,

  /// Leave
  requestLeavePage,

  /// Admin
  employeeListpage,
  employeeDetailpage,
  employeeCheckInOutDetailpage,
  teamtimesheetpage,
  teamleaverequests,
}
