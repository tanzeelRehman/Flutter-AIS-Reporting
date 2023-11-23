class GetTeamTimeSheetResponseModel {
  int? status;
  String? message;
  List<Response>? response;

  GetTeamTimeSheetResponseModel({this.status, this.message, this.response});

  GetTeamTimeSheetResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  int? userId;
  String? firstName;
  String? lastName;
  int? userDepartmentId;
  String? userDepartment;
  int? userDesignationId;
  String? userDesignation;
  int? userRoleId;
  String? userRole;
  int? userVerticalId;
  int? timesheetId;
  String? weekStartDate;
  String? weekEndDate;
  int? timesheetStatusId;
  List<TeamWorkEntries>? workEntries;

  Response(
      {this.userId,
      this.firstName,
      this.lastName,
      this.userDepartmentId,
      this.userDepartment,
      this.userDesignationId,
      this.userDesignation,
      this.userRoleId,
      this.userRole,
      this.userVerticalId,
      this.timesheetId,
      this.weekStartDate,
      this.weekEndDate,
      this.timesheetStatusId,
      this.workEntries});

  Response.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userDepartmentId = json['user_department_id'];
    userDepartment = json['user_department'];
    userDesignationId = json['user_designation_id'];
    userDesignation = json['user_designation'];
    userRoleId = json['user_role_id'];
    userRole = json['user_role'];
    userVerticalId = json['user_vertical_id'];
    timesheetId = json['timesheet_id'];
    weekStartDate = json['week_start_date'];
    weekEndDate = json['week_end_date'];
    timesheetStatusId = json['timesheet_status_id'];
    if (json['work_entries'] != null) {
      workEntries = <TeamWorkEntries>[];
      json['work_entries'].forEach((v) {
        workEntries!.add(new TeamWorkEntries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_department_id'] = this.userDepartmentId;
    data['user_department'] = this.userDepartment;
    data['user_designation_id'] = this.userDesignationId;
    data['user_designation'] = this.userDesignation;
    data['user_role_id'] = this.userRoleId;
    data['user_role'] = this.userRole;
    data['user_vertical_id'] = this.userVerticalId;
    data['timesheet_id'] = this.timesheetId;
    data['week_start_date'] = this.weekStartDate;
    data['week_end_date'] = this.weekEndDate;
    data['timesheet_status_id'] = this.timesheetStatusId;
    if (this.workEntries != null) {
      data['work_entries'] = this.workEntries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamWorkEntries {
  String? workDate;
  List<TeamWorkDetails>? workDetails;

  TeamWorkEntries({this.workDate, this.workDetails});

  TeamWorkEntries.fromJson(Map<String, dynamic> json) {
    workDate = json['work_date'];
    if (json['work_details'] != null) {
      workDetails = <TeamWorkDetails>[];
      json['work_details'].forEach((v) {
        workDetails!.add(new TeamWorkDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['work_date'] = this.workDate;
    if (this.workDetails != null) {
      data['work_details'] = this.workDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamWorkDetails {
  int? projectId;
  String? hoursWorked;
  String? projectName;
  String? description;

  TeamWorkDetails(
      {this.projectId, this.hoursWorked, this.projectName, this.description});

  TeamWorkDetails.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    hoursWorked = json['hours_worked'];
    projectName = json['project_name'];
    description = json[' description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['hours_worked'] = this.hoursWorked;
    data['project_name'] = this.projectName;
    data[' description'] = this.description;
    return data;
  }
}
