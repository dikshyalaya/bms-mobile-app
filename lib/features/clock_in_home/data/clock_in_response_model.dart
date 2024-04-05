// To parse this JSON data, do
//
//     final clockInResponseModel = clockInResponseModelFromJson(jsonString);

import 'dart:convert';

ClockInResponseModel clockInResponseModelFromJson(String str) => ClockInResponseModel.fromJson(json.decode(str));

String clockInResponseModelToJson(ClockInResponseModel data) => json.encode(data.toJson());

class ClockInResponseModel {
  bool error;
  String message;
  List<ClockInResponse>? data;
  int currentPage;
  dynamic nextPage;
  dynamic previouPage;
  int pageSize;

  ClockInResponseModel({
    required this.error,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.nextPage,
    required this.previouPage,
    required this.pageSize,
  });

  factory ClockInResponseModel.fromJson(Map<String, dynamic> json) => ClockInResponseModel(
    error: json["error"],
    message: json["message"],
    data: List<ClockInResponse>.from(json["data"].map((x) => ClockInResponse.fromJson(x))),
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

class ClockInResponse {
  int id;
  String schedulePeriod;
  int accountId;
  String accountName;
  int houseId;
  String houseName;
  String houseAddress;
  int dcId;
  String directCare;
  String scheduleDate;
  String startTime;
  dynamic startDateTime;
  String endTime;
  String? endDateTime;
  dynamic actualStartDateTime;
  dynamic actualEndDateTime;
  String? lunchTime;
  dynamic totalTime;
  dynamic noBreakReason;
  dynamic invoiceNumber;
  int timeDiff;

  ClockInResponse({
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

  factory ClockInResponse.fromJson(Map<String, dynamic> json) => ClockInResponse(
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
    lunchTime: json["lunchTime"]??"",
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
