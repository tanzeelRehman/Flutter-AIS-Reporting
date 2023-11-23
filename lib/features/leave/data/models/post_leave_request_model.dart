import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostLeaveRequestModel {
  String userId;
  int leaveTypeId;
  String leaveStartDate;
  String leaveEndDate;
  String justificationForLeave;
  String jobInHand;
  int taskReassignedTo;
  int no_of_days;
  PostLeaveRequestModel({
    required this.userId,
    required this.leaveTypeId,
    required this.leaveStartDate,
    required this.leaveEndDate,
    required this.justificationForLeave,
    required this.jobInHand,
    required this.taskReassignedTo,
    required this.no_of_days,
  });

  PostLeaveRequestModel copyWith({
    String? userId,
    int? leaveTypeId,
    String? leaveStartDate,
    String? leaveEndDate,
    String? justificationForLeave,
    String? jobInHand,
    int? taskReassignedTo,
    int? no_of_days,
  }) {
    return PostLeaveRequestModel(
      userId: userId ?? this.userId,
      leaveTypeId: leaveTypeId ?? this.leaveTypeId,
      leaveStartDate: leaveStartDate ?? this.leaveStartDate,
      leaveEndDate: leaveEndDate ?? this.leaveEndDate,
      justificationForLeave:
          justificationForLeave ?? this.justificationForLeave,
      jobInHand: jobInHand ?? this.jobInHand,
      taskReassignedTo: taskReassignedTo ?? this.taskReassignedTo,
      no_of_days: no_of_days ?? this.no_of_days,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'leaveTypeId': leaveTypeId,
      'leaveStartDate': leaveStartDate,
      'leaveEndDate': leaveEndDate,
      'justificationForLeave': justificationForLeave,
      'jobInHand': jobInHand,
      'taskReassignedTo': taskReassignedTo,
      'no_of_days': no_of_days,
    };
  }

  factory PostLeaveRequestModel.fromMap(Map<String, dynamic> map) {
    return PostLeaveRequestModel(
      userId: map['userId'] as String,
      leaveTypeId: map['leaveTypeId'] as int,
      leaveStartDate: map['leaveStartDate'] as String,
      leaveEndDate: map['leaveEndDate'] as String,
      justificationForLeave: map['justificationForLeave'] as String,
      jobInHand: map['jobInHand'] as String,
      taskReassignedTo: map['taskReassignedTo'] as int,
      no_of_days: map['no_of_days'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostLeaveRequestModel.fromJson(String source) =>
      PostLeaveRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostLeaveRequestModel(userId: $userId, leaveTypeId: $leaveTypeId, leaveStartDate: $leaveStartDate, leaveEndDate: $leaveEndDate, justificationForLeave: $justificationForLeave, jobInHand: $jobInHand, taskReassignedTo: $taskReassignedTo, no_of_days: $no_of_days)';
  }

  @override
  bool operator ==(covariant PostLeaveRequestModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.leaveTypeId == leaveTypeId &&
        other.leaveStartDate == leaveStartDate &&
        other.leaveEndDate == leaveEndDate &&
        other.justificationForLeave == justificationForLeave &&
        other.jobInHand == jobInHand &&
        other.taskReassignedTo == taskReassignedTo &&
        other.no_of_days == no_of_days;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        leaveTypeId.hashCode ^
        leaveStartDate.hashCode ^
        leaveEndDate.hashCode ^
        justificationForLeave.hashCode ^
        jobInHand.hashCode ^
        taskReassignedTo.hashCode ^
        no_of_days.hashCode;
  }
}
