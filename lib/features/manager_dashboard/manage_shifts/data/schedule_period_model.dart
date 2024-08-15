// To parse this JSON data, do
//
//     final schedulePeriodModel = schedulePeriodModelFromJson(jsonString);

import 'dart:convert';

SchedulePeriodModel schedulePeriodModelFromJson(String str) =>
    SchedulePeriodModel.fromJson(json.decode(str));

String schedulePeriodModelToJson(SchedulePeriodModel data) =>
    json.encode(data.toJson());

class SchedulePeriodModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? currentPage;
  int? nextPage;
  int? previousPage;
  int? pageSize;

  SchedulePeriodModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.nextPage,
    this.previousPage,
    this.pageSize,
  });

  factory SchedulePeriodModel.fromJson(Map<String, dynamic> json) =>
      SchedulePeriodModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "currentPage": currentPage,
        "nextPage": nextPage,
        "previousPage": previousPage,
        "pageSize": pageSize,
      };
}

class Datum {
  String? schedulePeriod;

  Datum({
    this.schedulePeriod,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        schedulePeriod: json["schedulePeriod"],
      );

  Map<String, dynamic> toJson() => {
        "schedulePeriod": schedulePeriod,
      };
}
