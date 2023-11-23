class GetAllTimeSheets {
  GetAllTimeSheets({
    required this.status,
    required this.message,
    required this.response,
  });
  late final int status;
  late final String message;
  late final List<Response> response;

  GetAllTimeSheets.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response =
        List.from(json['response']).map((e) => Response.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['response'] = response.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Response {
  Response({
    required this.id,
    required this.timesheetStatusId,
    required this.userId,
    required this.weekStartDate,
    required this.weekEndDate,
    this.approvedBy,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    required this.user,
    required this.timesheetEntries,
    required this.timesheetStatus,
  });
  late final int id;
  late final int timesheetStatusId;
  late final int userId;
  late final String weekStartDate;
  late final String weekEndDate;
  late final String? approvedBy;
  late final bool isActive;
  late final String createdAt;
  late final String? updatedAt;
  late final User user;
  late final List<TimesheetEntriesResponse> timesheetEntries;
  late final TimesheetStatus timesheetStatus;

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timesheetStatusId = json['timesheet_status_id'];
    userId = json['user_id'];
    weekStartDate = json['week_start_date'];
    weekEndDate = json['week_end_date'];
    approvedBy = null;
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = null;
    user = User.fromJson(json['user']);
    timesheetEntries = List.from(json['timesheet_entries'])
        .map((e) => TimesheetEntriesResponse.fromJson(e))
        .toList();
    timesheetStatus = TimesheetStatus.fromJson(json['timesheet_status']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['timesheet_status_id'] = timesheetStatusId;
    _data['user_id'] = userId;
    _data['week_start_date'] = weekStartDate;
    _data['week_end_date'] = weekEndDate;
    _data['approved_by'] = approvedBy;
    _data['is_active'] = isActive;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['user'] = user.toJson();
    _data['timesheet_entries'] =
        timesheetEntries.map((e) => e.toJson()).toList();
    _data['timesheet_status'] = timesheetStatus.toJson();
    return _data;
  }
}

class User {
  User({
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
  });
  late final int userId;
  late final String firstName;
  late final String middleName;
  late final String lastName;

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['first_name'] = firstName;
    _data['middle_name'] = middleName;
    _data['last_name'] = lastName;
    return _data;
  }
}

class TimesheetEntriesResponse {
  TimesheetEntriesResponse({
    required this.id,
    required this.timesheetId,
    required this.projectId,
    this.taskDescription,
    required this.workDate,
    required this.hoursWorked,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    required this.project,
  });
  late final int id;
  late final int timesheetId;
  late final int projectId;
  late final String? taskDescription;
  late final String workDate;
  late final String hoursWorked;
  late final bool isActive;
  late final String createdAt;
  late final String? updatedAt;
  late final Project project;

  TimesheetEntriesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timesheetId = json['timesheet_id'];
    projectId = json['project_id'];
    taskDescription = null;
    workDate = json['work_date'];
    hoursWorked = json['hours_worked'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = null;
    project = Project.fromJson(json['project']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['timesheet_id'] = timesheetId;
    _data['project_id'] = projectId;
    _data['task_description'] = taskDescription;
    _data['work_date'] = workDate;
    _data['hours_worked'] = hoursWorked;
    _data['is_active'] = isActive;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['project'] = project.toJson();
    return _data;
  }
}

class Project {
  Project({
    required this.projectId,
    required this.title,
  });
  late final int projectId;
  late final String title;

  Project.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['project_id'] = projectId;
    _data['title'] = title;
    return _data;
  }
}

class TimesheetStatus {
  TimesheetStatus({
    required this.timesheetStatusId,
    required this.timesheetStatus,
  });
  late final int timesheetStatusId;
  late final String timesheetStatus;

  TimesheetStatus.fromJson(Map<String, dynamic> json) {
    timesheetStatusId = json['timesheet_status_id'];
    timesheetStatus = json['timesheet_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timesheet_status_id'] = timesheetStatusId;
    _data['timesheet_status'] = timesheetStatus;
    return _data;
  }
}
