class AppUrl {
  static const String baseUrl =
      'https://officeautomation-node.appinsnap.com/api/';
  // static const String baseUrl = 'http://192.168.12.187:5003/api/';

  /// Auth
  static const String loginUrl = 'login';

  /// Attendence
  static const String uploadStatus = 'selfAttendance/selfAttendanceReport';
  static const String getStatus =
      'selfAttendanceStatus/getSelfAttendanceStatus/';
  static const String getattendenceDetails = 'attendanceDetails?';

  /// Leaves
  static const String getJobsReAssignToEmployess = 'job_reassigned_to/';
  static const String getLeaveQuota = 'get_leave_quota/';
  static const String addLeaveInformation = 'add_leave_information';

  /// User Time Sheet
  static const String getAllProjectsDetails = 'project/getProjectDetails';
  static const String addUserTimeSheet = 'userTimesheet/addTimesheet';
  static const String getAllTimeSheets = 'userTimesheet?user_id=';
  static const String getTeamTimeSheets = 'userTimesheet/requestedTimesheet/';
  static const String updateTimeSheets = 'userTimesheet/updateTimesheet/';
  static const String getLeaveRequests = 'getleavesResult/';
}
