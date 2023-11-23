// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_void_to_null

class JobReAssignToResponseModel {
  JobReAssignToResponseModel({
    required this.status,
    required this.response,
    required this.message,
  });
  late final int status;
  late final List<JobReAssignResponse> response;
  late final String message;

  JobReAssignToResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = List.from(json['response'])
        .map((e) => JobReAssignResponse.fromJson(e))
        .toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response'] = response.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

//! Please Change Name of Response Obj to JobReAssignResponse, Otherwise it will give conflict
class JobReAssignResponse {
  JobReAssignResponse({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.designationId,
    required this.designationName,
    required this.userId,
    required this.fullName,
  });
  late final String firstName;
  late final String middleName;
  late final String lastName;
  late final int designationId;
  late final String designationName;
  late final int userId;
  late final String fullName;

  JobReAssignResponse.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    designationId = json['designation_id'];
    designationName = json['designation_name'];
    userId = json['user_id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['middle_name'] = middleName;
    _data['last_name'] = lastName;
    _data['designation_id'] = designationId;
    _data['designation_name'] = designationName;
    _data['user_id'] = userId;
    _data['full_name'] = fullName;
    return _data;
  }
}
