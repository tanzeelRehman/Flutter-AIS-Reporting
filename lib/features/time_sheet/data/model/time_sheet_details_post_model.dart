class TimeSheetDetailsPostModel {
  TimeSheetDetailsPostModel({
    required this.userId,
    required this.weekStartDate,
    required this.weekEndDate,
    required this.timesheetEntries,
  });
  late final String userId;
  late String weekStartDate;
  late String weekEndDate;
  late final List<TimesheetEntries> timesheetEntries;

  TimeSheetDetailsPostModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    weekStartDate = json['week_start_date'];
    weekEndDate = json['week_end_date'];
    timesheetEntries = List.from(json['timesheet_entries'])
        .map((e) => TimesheetEntries.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['week_start_date'] = weekStartDate;
    _data['week_end_date'] = weekEndDate;
    _data['timesheet_entries'] =
        timesheetEntries.map((e) => e.toJson()).toList();
    return _data;
  }
}

class TimesheetEntries {
  TimesheetEntries({
    required this.workDate,
    required this.workDetails,
  });
  late String workDate;
  late List<WorkDetails> workDetails;

  TimesheetEntries.fromJson(Map<String, dynamic> json) {
    workDate = json['work_date'];
    workDetails = List.from(json['work_details'])
        .map((e) => WorkDetails.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['work_date'] = workDate;
    _data['work_details'] = workDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class WorkDetails {
  WorkDetails({
    required this.projectId,
    required this.hours,
    required this.description,
  });
  late int projectId;
  late int hours;
  late String? description;

  WorkDetails.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    hours = json['hours'];
    description = json['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['project_id'] = projectId;
    _data['hours'] = hours;
    _data['description'] = description;
    return _data;
  }
}
