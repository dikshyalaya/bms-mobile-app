// To parse this JSON data, do
//
//     final availableShiftsForDcModel = availableShiftsForDcModelFromJson(jsonString);

import 'dart:convert';

AvailableShiftsForDcModel availableShiftsForDcModelFromJson(String str) => AvailableShiftsForDcModel.fromJson(json.decode(str));

String availableShiftsForDcModelToJson(AvailableShiftsForDcModel data) => json.encode(data.toJson());

class AvailableShiftsForDcModel {
  bool? error;
  String? message;
  List<ScheduleCardModel>? data;
  int? currentPage;
  dynamic nextPage;
  dynamic previouPage;
  int? pageSize;

  AvailableShiftsForDcModel({
    this.error,
    this.message,
    this.data,
    this.currentPage,
    this.nextPage,
    this.previouPage,
    this.pageSize,
  });

  factory AvailableShiftsForDcModel.fromJson(Map<String, dynamic> json) => AvailableShiftsForDcModel(
    error: json["error"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ScheduleCardModel>.from(json["data"]!.map((x) => ScheduleCardModel.fromJson(x))),
    currentPage: json["currentPage"],
    nextPage: json["nextPage"],
    previouPage: json["previouPage"],
    pageSize: json["pageSize"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "currentPage": currentPage,
    "nextPage": nextPage,
    "previouPage": previouPage,
    "pageSize": pageSize,
  };
}

class ScheduleCardModel {
  int? id;
  String? schedulePeriod;
  int? accountId;
  String? accountName;
  int? houseId;
  String? houseName;
  String? houseAddress;
  int? dcId;
  dynamic directCare;
  String? scheduleDate;
  String? startTime;
  dynamic startDateTime;
  String? endTime;
  dynamic endDateTime;
  dynamic actualStartDateTime;
  dynamic actualEndDateTime;
  dynamic lunchTime;
  dynamic totalTime;
  dynamic noBreakReason;
  dynamic invoiceNumber;
  int? timeDiff;

  ScheduleCardModel({
    this.id,
    this.schedulePeriod,
    this.accountId,
    this.accountName,
    this.houseId,
    this.houseName,
    this.houseAddress,
    this.dcId,
    this.directCare,
    this.scheduleDate,
    this.startTime,
    this.startDateTime,
    this.endTime,
    this.endDateTime,
    this.actualStartDateTime,
    this.actualEndDateTime,
    this.lunchTime,
    this.totalTime,
    this.noBreakReason,
    this.invoiceNumber,
    this.timeDiff,
  });

  factory ScheduleCardModel.fromJson(Map<String, dynamic> json) => ScheduleCardModel(
    id: json["id"],
    schedulePeriod: json["schedulePeriod"],
    accountId: json["accountId"],
    accountName: json["accountName"],
    houseId: json["houseId"],
    houseName: json["houseName"],
    houseAddress: json["houseAddress"],
    dcId: json["dcId"],
    directCare: json["directCare"],
    scheduleDate: json["scheduleDate"],
    startTime: json["startTime"],
    startDateTime: json["startDateTime"],
    endTime: json["endTime"],
    endDateTime: json["endDateTime"],
    actualStartDateTime: json["actualStartDateTime"],
    actualEndDateTime: json["actualEndDateTime"],
    lunchTime: json["lunchTime"],
    totalTime: json["totalTime"],
    noBreakReason: json["noBreakReason"],
    invoiceNumber: json["invoiceNumber"],
    timeDiff: json["timeDiff"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "schedulePeriod": schedulePeriod,
    "accountId": accountId,
    "accountName": accountName,
    "houseId": houseId,
    "houseName": houseName,
    "houseAddress": houseAddress,
    "dcId": dcId,
    "directCare": directCare,
    "scheduleDate": scheduleDate,
    "startTime": startTime,
    "startDateTime": startDateTime,
    "endTime": endTime,
    "endDateTime": endDateTime,
    "actualStartDateTime": actualStartDateTime,
    "actualEndDateTime": actualEndDateTime,
    "lunchTime": lunchTime,
    "totalTime": totalTime,
    "noBreakReason": noBreakReason,
    "invoiceNumber": invoiceNumber,
    "timeDiff": timeDiff,
  };
}
