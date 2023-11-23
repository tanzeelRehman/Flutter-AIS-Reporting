// ignore_for_file: public_member_api_docs, sort_constructors_first
class AttendenceDetailsRequestModel {
  String startDate;
  String endDate;
  int userId;
  int deptId;
  int designationId;
  int roleId;
  AttendenceDetailsRequestModel({
    required this.startDate,
    required this.endDate,
    required this.userId,
    required this.deptId,
    required this.designationId,
    required this.roleId,
  });
}
