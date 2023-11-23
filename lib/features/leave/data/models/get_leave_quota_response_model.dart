class GetLeaveQuotaResponseModel {
  GetLeaveQuotaResponseModel({
    required this.message,
    required this.status,
    required this.response,
  });
  late final String message;
  late final int status;
  late final List<Response> response;

  GetLeaveQuotaResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    response =
        List.from(json['response']).map((e) => Response.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['response'] = response.map((e) => e.toJson()).toList();
    return data;
  }
}

class Response {
  Response({
    required this.leaveTypeId,
    required this.LeaveTypeName,
    required this.noOfDays,
    required this.availed,
  });
  late final int leaveTypeId;
  late final String LeaveTypeName;
  late final int noOfDays;
  late final int availed;

  Response.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    LeaveTypeName = json['Leave_Type_Name'];
    noOfDays = json['no_of_days'];
    availed = json['availed'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['leave_type_id'] = leaveTypeId;
    data['Leave_Type_Name'] = LeaveTypeName;
    data['no_of_days'] = noOfDays;
    data['availed'] = availed;
    return data;
  }
}
