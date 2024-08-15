// To parse this JSON data, do
//
//     final managerActiveShiftModel = managerActiveShiftModelFromJson(jsonString);

import 'dart:convert';

ManagerActiveShiftModel managerActiveShiftModelFromJson(String str) =>
    ManagerActiveShiftModel.fromJson(json.decode(str));

String managerActiveShiftModelToJson(ManagerActiveShiftModel data) =>
    json.encode(data.toJson());

class ManagerActiveShiftModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? currentPage;
  dynamic nextPage;
  dynamic previousPage;
  int? pageSize;

  ManagerActiveShiftModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.nextPage,
    this.previousPage,
    this.pageSize,
  });

  factory ManagerActiveShiftModel.fromJson(Map<String, dynamic> json) =>
      ManagerActiveShiftModel(
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
  int? id;
  String? scheduleDate;
  String? startTime;
  String? endTime;
  String? houseName;
  String? type;
  int? inActive;
  String? invitedName;
  int? closed;
  String? shiftStatus;
  String? shiftAction;
  int? allowCancelled;
  int? dcid;
  int? markAsReplaced;

  Datum({
    this.id,
    this.scheduleDate,
    this.startTime,
    this.endTime,
    this.houseName,
    this.type,
    this.inActive,
    this.invitedName,
    this.closed,
    this.shiftStatus,
    this.shiftAction,
    this.allowCancelled,
    this.dcid,
    this.markAsReplaced,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        scheduleDate: json["scheduleDate"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        houseName: json["houseName"],
        type: json["type"],
        inActive: json["inActive"],
        invitedName: json["invitedName"],
        closed: json["closed"],
        shiftStatus: json["shiftStatus"],
        shiftAction: json["shiftAction"],
        allowCancelled: json["allowCancelled"],
        dcid: json["dcid"],
        markAsReplaced: json["markAsReplaced"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "scheduleDate": scheduleDate,
        "startTime": startTime,
        "endTime": endTime,
        "houseName": houseName,
        "type": type,
        "inActive": inActive,
        "invitedName": invitedName,
        "closed": closed,
        "shiftStatus": shiftStatus,
        "shiftAction": shiftAction,
        "allowCancelled": allowCancelled,
        "dcid": dcid,
        "markAsReplaced": markAsReplaced,
      };
}
