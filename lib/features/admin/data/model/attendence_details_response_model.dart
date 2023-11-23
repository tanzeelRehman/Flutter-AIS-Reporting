// ignore_for_file: no_leading_underscores_for_local_identifiers

class AttendenceDetailsResponseModel {
  AttendenceDetailsResponseModel({
    required this.data,
    required this.status,
    required this.message,
    required this.records,
  });
  late final List<AttendenceData> data;
  late final int status;
  late final String message;
  late final int records;

  AttendenceDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    data =
        List.from(json['data']).map((e) => AttendenceData.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
    records = json['records'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['status'] = status;
    _data['message'] = message;
    _data['records'] = records;
    return _data;
  }
}

class AttendenceData {
  AttendenceData({
    required this.employeeId,
    required this.deviceUserId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.reportingToId,
    required this.reportingToName,
    required this.designationName,
    required this.departmentType,
    required this.checkIn,
    this.checkOut,
    required this.fullName,
  });
  late final String employeeId;
  late final int deviceUserId;
  late final String firstName;
  late final String middleName;
  late final String lastName;
  late final int reportingToId;
  late final String reportingToName;
  late final String designationName;
  late final String departmentType;
  late final String checkIn;
  late final String? checkOut;
  late final String fullName;

  AttendenceData.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    deviceUserId = json['device_user_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    reportingToId = json['reportingToId'];
    reportingToName = json['reporting_to_name'];
    designationName = json['designation_name'];
    departmentType = json['department_type'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employee_id'] = employeeId;
    _data['device_user_id'] = deviceUserId;
    _data['first_name'] = firstName;
    _data['middle_name'] = middleName;
    _data['last_name'] = lastName;
    _data['reportingToId'] = reportingToId;
    _data['reporting_to_name'] = reportingToName;
    _data['designation_name'] = designationName;
    _data['department_type'] = departmentType;
    _data['check_in'] = checkIn;
    _data['check_out'] = checkOut;
    _data['fullName'] = fullName;
    return _data;
  }
}
