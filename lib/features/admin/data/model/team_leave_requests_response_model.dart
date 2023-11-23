class TeamLeaveRequestsResponseModel {
  TeamLeaveRequestsResponseModel({
    required this.status,
    this.error,
    required this.response,
  });
  late final int status;
  late final Null error;
  late final List<Response> response;

  TeamLeaveRequestsResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = null;
    response =
        List.from(json['response']).map((e) => Response.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['error'] = error;
    _data['response'] = response.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Response {
  Response({
    required this.leaveId,
    required this.userId,
    required this.employeeId,
    required this.userLeaveTypesId,
    required this.leaveStartDate,
    required this.leaveEndDate,
    required this.noOfDays,
    required this.submissionDate,
    required this.leaveStatusTypesId,
    required this.departmentType,
    required this.leaveName,
    required this.status,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.departmentTypesId,
    required this.verticalId,
    required this.verticalName,
    required this.userDesignationTypesId,
    required this.userDesignationName,
  });
  late final int leaveId;
  late final int userId;
  late final String employeeId;
  late final int userLeaveTypesId;
  late final String leaveStartDate;
  late final String leaveEndDate;
  late final int noOfDays;
  late final String submissionDate;
  late final int leaveStatusTypesId;
  late final String departmentType;
  late final String leaveName;
  late final String status;
  late final String firstName;
  late final String middleName;
  late final String lastName;
  late final int departmentTypesId;
  late final int verticalId;
  late final String verticalName;
  late final int userDesignationTypesId;
  late final String userDesignationName;

  Response.fromJson(Map<String, dynamic> json) {
    leaveId = json['leave_id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    userLeaveTypesId = json['user_leave_types_id'];
    leaveStartDate = json['leave_start_date'];
    leaveEndDate = json['leave_end_date'];
    noOfDays = json['no_of_days'];
    submissionDate = json['submission_date'];
    leaveStatusTypesId = json['leave_status_types_id'];
    departmentType = json['department_type'];
    leaveName = json['leave_name'];
    status = json['status'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    departmentTypesId = json['department_types_id'];
    verticalId = json['vertical_id'];
    verticalName = json['vertical_name'];
    userDesignationTypesId = json['user_designation_types_id'];
    userDesignationName = json['user_designation_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['leave_id'] = leaveId;
    _data['user_id'] = userId;
    _data['employee_id'] = employeeId;
    _data['user_leave_types_id'] = userLeaveTypesId;
    _data['leave_start_date'] = leaveStartDate;
    _data['leave_end_date'] = leaveEndDate;
    _data['no_of_days'] = noOfDays;
    _data['submission_date'] = submissionDate;
    _data['leave_status_types_id'] = leaveStatusTypesId;
    _data['department_type'] = departmentType;
    _data['leave_name'] = leaveName;
    _data['status'] = status;
    _data['first_name'] = firstName;
    _data['middle_name'] = middleName;
    _data['last_name'] = lastName;
    _data['department_types_id'] = departmentTypesId;
    _data['vertical_id'] = verticalId;
    _data['vertical_name'] = verticalName;
    _data['user_designation_types_id'] = userDesignationTypesId;
    _data['user_designation_name'] = userDesignationName;
    return _data;
  }
}
