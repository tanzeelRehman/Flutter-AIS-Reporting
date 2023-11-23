class UploadStatusResponseModel {
  UploadStatusResponseModel({
    required this.message,
    required this.userId,
    required this.type,
    required this.time,
  });
  late final String message;
  late final String userId;
  late final String type;
  late final String time;

  UploadStatusResponseModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    userId = json['userId'];
    type = json['type'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['userId'] = userId;
    _data['type'] = type;
    _data['time'] = time;
    return _data;
  }
}