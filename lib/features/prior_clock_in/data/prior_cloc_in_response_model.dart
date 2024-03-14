// To parse this JSON data, do
//
//     final priorClockInResponseModel = priorClockInResponseModelFromJson(jsonString);

import 'dart:convert';

PriorClockInResponseModel priorClockInResponseModelFromJson(String str) => PriorClockInResponseModel.fromJson(json.decode(str));

String priorClockInResponseModelToJson(PriorClockInResponseModel data) => json.encode(data.toJson());

class PriorClockInResponseModel {
  bool error;
  String message;
  List<PriorClockInModel>? data;
  int currentPage;
  dynamic nextPage;
  dynamic previouPage;
  int pageSize;

  PriorClockInResponseModel({
    required this.error,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.nextPage,
    required this.previouPage,
    required this.pageSize,
  });

  factory PriorClockInResponseModel.fromJson(Map<String, dynamic> json) => PriorClockInResponseModel(
    error: json["error"],
    message: json["message"],
    data: List<PriorClockInModel>.from(json["data"].map((x) => PriorClockInModel.fromJson(x))),
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

class PriorClockInModel {
  int id;
  String schedulePeriod;
  int accountId;
  String accountName;
  int houseId;
  String houseName;
  dynamic houseAddress;
  int dcId;
  dynamic directCare;
  String scheduleDate;
  String startTime;
  DateTime startDateTime;
  String endTime;
  DateTime endDateTime;
  DateTime actualStartDateTime;
  DateTime actualEndDateTime;
  String lunchTime;
  dynamic totalTime;
  String noBreakReason;
  String invoiceNumber;
  int timeDiff;

  PriorClockInModel({
    required this.id,
    required this.schedulePeriod,
    required this.accountId,
    required this.accountName,
    required this.houseId,
    required this.houseName,
    required this.houseAddress,
    required this.dcId,
    required this.directCare,
    required this.scheduleDate,
    required this.startTime,
    required this.startDateTime,
    required this.endTime,
    required this.endDateTime,
    required this.actualStartDateTime,
    required this.actualEndDateTime,
    required this.lunchTime,
    required this.totalTime,
    required this.noBreakReason,
    required this.invoiceNumber,
    required this.timeDiff,
  });

  factory PriorClockInModel.fromJson(Map<String, dynamic> json) => PriorClockInModel(
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
    startDateTime: DateTime.parse(json["startDateTime"]),
    endTime: json["endTime"],
    endDateTime: DateTime.parse(json["endDateTime"]),
    actualStartDateTime: DateTime.parse(json["actualStartDateTime"]),
    actualEndDateTime: DateTime.parse(json["actualEndDateTime"]),
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
    "startDateTime": startDateTime.toIso8601String(),
    "endTime": endTime,
    "endDateTime": endDateTime.toIso8601String(),
    "actualStartDateTime": actualStartDateTime.toIso8601String(),
    "actualEndDateTime": actualEndDateTime.toIso8601String(),
    "lunchTime": lunchTime,
    "totalTime": totalTime,
    "noBreakReason": noBreakReason,
    "invoiceNumber": invoiceNumber,
    "timeDiff": timeDiff,
  };
}
