// To parse this JSON data, do
//
//     final incompleteActivities = incompleteActivitiesFromJson(jsonString);

import 'dart:convert';

IncompleteActivitiesModel incompleteActivitiesFromJson(String str) => IncompleteActivitiesModel.fromJson(json.decode(str));

String incompleteActivitiesToJson(IncompleteActivitiesModel data) => json.encode(data.toJson());

class IncompleteActivitiesModel {
  bool success;
  bool hasPendingTask;
  Data? data;

  IncompleteActivitiesModel({
    required this.success,
    required this.hasPendingTask,
    required this.data,
  });

  factory IncompleteActivitiesModel.fromJson(Map<String, dynamic> json) => IncompleteActivitiesModel(
    success: json["success"],
    hasPendingTask: json["hasPendingTask"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "hasPendingTask": hasPendingTask,
    "data": data?.toJson(),
  };
}

class Data {
  Pending pendingClockIns;
  Pending pendingInvites;

  Data({
    required this.pendingClockIns,
    required this.pendingInvites,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pendingClockIns: Pending.fromJson(json["pendingClockIns"]),
    pendingInvites: Pending.fromJson(json["pendingInvites"]),
  );

  Map<String, dynamic> toJson() => {
    "pendingClockIns": pendingClockIns.toJson(),
    "pendingInvites": pendingInvites.toJson(),
  };
}

class Pending {
  int count;
  String message;

  Pending({
    required this.count,
    required this.message,
  });

  factory Pending.fromJson(Map<String, dynamic> json) => Pending(
    count: json["count"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "message": message,
  };
}
