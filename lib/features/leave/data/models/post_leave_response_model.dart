class PostLeaveResponseModel {
  PostLeaveResponseModel({
    required this.msg,
    required this.status,
  });
  late final String msg;
  late final int status;

  PostLeaveResponseModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}
