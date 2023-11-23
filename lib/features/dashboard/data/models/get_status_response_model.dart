class GetStatusResponseModel {
  GetStatusResponseModel({
    required this.message,
    required this.selfCheckInDbResponse,
    required this.selfCheckOutDbResponse,
  });

  late final String message;
  late final List<SelfCheckInDbResponse> selfCheckInDbResponse;
  late final List<SelfCheckOutDbResponse> selfCheckOutDbResponse;

  GetStatusResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    selfCheckInDbResponse = List.from(json['selfCheckInDbResponse'])
        .map((e) => SelfCheckInDbResponse.fromJson(e))
        .toList();
    selfCheckOutDbResponse = List.from(json['selfCheckOutDbResponse'])
        .map((e) => SelfCheckOutDbResponse.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['selfCheckInDbResponse'] =
        selfCheckInDbResponse.map((e) => e.toJson()).toList();
    data['selfCheckOutDbResponse'] =
        selfCheckOutDbResponse.map((e) => e.toJson()).toList();
    return data;
  }
}

class SelfCheckInDbResponse {
  SelfCheckInDbResponse({
    required this.id,
    required this.userId,
    required this.channel,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int userId;
  late final String channel;
  late final String time;
  late final String createdAt;
  late final String updatedAt;

  SelfCheckInDbResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    channel = json['channel'];
    time = json['time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['channel'] = channel;
    data['time'] = time;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SelfCheckOutDbResponse {
  SelfCheckOutDbResponse({
    required this.id,
    required this.userId,
    required this.channel,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int userId;
  late final String channel;
  late final String time;
  late final String createdAt;
  late final String updatedAt;

  SelfCheckOutDbResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    channel = json['channel'];
    time = json['time'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['channel'] = channel;
    data['time'] = time;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
