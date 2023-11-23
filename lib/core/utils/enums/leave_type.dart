// ignore_for_file: constant_identifier_names

enum LeaveType {
  Annual,
  Casual,
  Bereavement,
  Marriage,
  Maternity,
  Paternity,
  Medical
}

int leaveTypeToLeaveId(Enum leaveType) {
  if (leaveType == LeaveType.Annual) {
    return 1;
  } else if (leaveType == LeaveType.Casual) {
    return 2;
  } else if (leaveType == LeaveType.Bereavement) {
    return 3;
  } else if (leaveType == LeaveType.Marriage) {
    return 4;
  } else if (leaveType == LeaveType.Maternity) {
    return 5;
  } else if (leaveType == LeaveType.Paternity) {
    return 6;
  } else if (leaveType == LeaveType.Medical) {
    return 7;
  } else {
    return 0;
  }
}

String leaveIdToLeaveType(int leaveId) {
  if (leaveId == 1) {
    return LeaveType.Annual.toString();
  } else if (leaveId == 2) {
    return LeaveType.Casual.toString();
  } else if (leaveId == 3) {
    return LeaveType.Bereavement.toString();
  } else if (leaveId == 4) {
    return LeaveType.Marriage.toString();
  } else if (leaveId == 5) {
    return LeaveType.Maternity.toString();
  } else if (leaveId == 6) {
    return LeaveType.Paternity.toString();
  } else if (leaveId == 7) {
    return LeaveType.Medical.toString();
  } else {
    return '';
  }
}
