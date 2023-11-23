class UploadStatusRequestModel {
  UploadStatusRequestModel({
    required this.userId,
    required this.channel,
    required this.time,
    required this.type,
    required this.image,
    required this.latitute,
    required this.longitude,
  });
  late final String userId;
  late final String channel;
  late final String time;
  late final String type;
  late final String image;
  late final String latitute;
  late final String longitude;

  UploadStatusRequestModel.fromJson(Map<String, dynamic> json){
    userId = json['userId'];
    channel = json['channel'];
    time = json['time'];
    image = json['image'];
    type = json['type'];
    latitute = json['latitute'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = userId;
    _data['channel'] = channel;
    _data['time'] = time;
    _data['image'] = image;
    _data['type'] = type;
    _data['latitute'] = latitute;
    _data['longitude'] = longitude;
    return _data;
  }
}