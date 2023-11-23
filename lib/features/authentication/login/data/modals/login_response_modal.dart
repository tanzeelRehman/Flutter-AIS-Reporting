class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    required this.login,
    required this.message,
    required this.token,
    required this.roleId,
    required this.role,
    required this.designationId,
    required this.designationName,
    required this.departmentId,
    required this.departmentName,
    required this.user,
  });
  late final int status;
  late final bool login;
  late final String message;
  late final String token;
  late final int roleId;
  late final String role;
  late final int designationId;
  late final String designationName;
  late final int departmentId;
  late final String departmentName;
  late final User user;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    login = json['login'];
    message = json['message'];
    token = json['token'];
    roleId = json['roleId'];
    role = json['role'];
    designationId = json['designationId'];
    designationName = json['designationName'];
    departmentId = json['departmentId'];
    departmentName = json['departmentName'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['login'] = login;
    _data['message'] = message;
    _data['token'] = token;
    _data['roleId'] = roleId;
    _data['role'] = role;
    _data['designationId'] = designationId;
    _data['designationName'] = designationName;
    _data['departmentId'] = departmentId;
    _data['departmentName'] = departmentName;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.userId,
    required this.uuid,
    required this.firstName,
    required this.middleName,
    required this.age,
    required this.dob,
    required this.contactNo,
    required this.emergencyContact,
    required this.reportingTo,
    required this.lastName,
    required this.employeeId,
    required this.email,
    required this.verticalId,
    required this.verticalName,
    required this.genderId,
    required this.gender,
  });
  late final int userId;
  late final String uuid;
  late final String firstName;
  late final String middleName;
  late final int age;
  late final String dob;
  late final String contactNo;
  late final String emergencyContact;
  late final String reportingTo;
  late final String lastName;
  late final String employeeId;
  late final String email;
  late final int verticalId;
  late final String verticalName;
  late final int genderId;
  late final String gender;

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    uuid = json['uuid'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    age = json['age'];
    dob = json['dob'];
    contactNo = json['contactNo'];
    emergencyContact = json['emergencyContact'];
    reportingTo = json['reportingTo'];
    lastName = json['last_name'];
    employeeId = json['employee_id'];
    email = json['email'];
    verticalId = json['verticalId'];
    verticalName = json['verticalName'];
    genderId = json['genderId'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['uuid'] = uuid;
    _data['first_name'] = firstName;
    _data['middle_name'] = middleName;
    _data['age'] = age;
    _data['dob'] = dob;
    _data['contactNo'] = contactNo;
    _data['emergencyContact'] = emergencyContact;
    _data['reportingTo'] = reportingTo;
    _data['last_name'] = lastName;
    _data['employee_id'] = employeeId;
    _data['email'] = email;
    _data['verticalId'] = verticalId;
    _data['verticalName'] = verticalName;
    _data['genderId'] = genderId;
    _data['gender'] = gender;
    return _data;
  }
}
