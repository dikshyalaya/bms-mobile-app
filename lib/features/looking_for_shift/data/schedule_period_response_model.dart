// To parse this JSON data, do
//
//     final schedulePeriodResponseModel = schedulePeriodResponseModelFromJson(jsonString);

import 'dart:convert';

SchedulePeriodResponseModel schedulePeriodResponseModelFromJson(String str) => SchedulePeriodResponseModel.fromJson(json.decode(str));

String schedulePeriodResponseModelToJson(SchedulePeriodResponseModel data) => json.encode(data.toJson());

class SchedulePeriodResponseModel {
  bool error;
  String message;
  List<SchedulePeriod>? data;
  int currentPage;
  dynamic nextPage;
  dynamic previouPage;
  int pageSize;

  SchedulePeriodResponseModel({
    required this.error,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.nextPage,
    required this.previouPage,
    required this.pageSize,
  });

  factory SchedulePeriodResponseModel.fromJson(Map<String, dynamic> json) => SchedulePeriodResponseModel(
    error: json["error"],
    message: json["message"],
    data: List<SchedulePeriod>.from(json["data"].map((x) => SchedulePeriod.fromJson(x))),
    currentPage: json["currentPage"],
    nextPage: json["nextPage"],
    previouPage: json["previouPage"],
    pageSize: json["pageSize"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data?.map((x) => x.toJson())??{}),
    "currentPage": currentPage,
    "nextPage": nextPage,
    "previouPage": previouPage,
    "pageSize": pageSize,
  };
}

class SchedulePeriod {
  int id;
  String schedulePeriod;
  DateTime startdate;
  DateTime endDate;

  SchedulePeriod({
    required this.id,
    required this.schedulePeriod,
    required this.startdate,
    required this.endDate,
  });

  factory SchedulePeriod.fromJson(Map<String, dynamic> json) => SchedulePeriod(
    id: json["id"],
    schedulePeriod: json["schedulePeriod"],
    startdate: DateTime.parse(json["startdate"]),
    endDate: DateTime.parse(json["endDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "schedulePeriod": schedulePeriod,
    "startdate": startdate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
  };
}
