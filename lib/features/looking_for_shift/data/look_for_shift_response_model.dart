// To parse this JSON data, do
//
//     final lookForShiftResponseModel = lookForShiftResponseModelFromJson(jsonString);

import 'dart:convert';

LookForShiftResponseModel lookForShiftResponseModelFromJson(String str) => LookForShiftResponseModel.fromJson(json.decode(str));

String lookForShiftResponseModelToJson(LookForShiftResponseModel data) => json.encode(data.toJson());

class LookForShiftResponseModel {
  bool? error;
  String message;
  List<LookForShiftModel>? data;
  int currentPage;
  dynamic nextPage;
  dynamic previouPage;
  int pageSize;

  LookForShiftResponseModel({
    required this.error,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.nextPage,
    required this.previouPage,
    required this.pageSize,
  });

  factory LookForShiftResponseModel.fromJson(Map<String, dynamic> json) => LookForShiftResponseModel(
    error: json["error"],
    message: json["message"],
    data: List<LookForShiftModel>.from(json["data"].map((x) => LookForShiftModel.fromJson(x))),
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

class LookForShiftModel {
  dynamic distance;
  dynamic transitDistance;
  String duration;
  String transitDuration;
  int id;
  String schedulePeriod;
  int accountId;
  dynamic accountName;
  int houseId;
  dynamic houseName;
  String houseAddress;
  int dcId;
  dynamic directCare;
  String scheduleDate;
  String startTime;
  DateTime startDateTime;
  String endTime;
  dynamic endDateTime;
  dynamic actualStartDateTime;
  dynamic actualEndDateTime;
  dynamic lunchTime;
  dynamic totalTime;
  dynamic noBreakReason;
  dynamic invoiceNumber;
  int timeDiff;

  LookForShiftModel({
    required this.distance,
    required this.transitDistance,
    required this.duration,
    required this.transitDuration,
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

  factory LookForShiftModel.fromJson(Map<String, dynamic> json) => LookForShiftModel(
    distance: json["distance"],
    transitDistance: json["transitDistance"],
    duration: json["duration"],
    transitDuration: json["transitDuration"],
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
    "distance": distance,
    "transitDistance": transitDistance,
    "duration": duration,
    "transitDuration": transitDuration,
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
