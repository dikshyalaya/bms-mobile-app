// To parse this JSON data, do
//
//     final clockInResponseModel = clockInResponseModelFromJson(jsonString);

import 'dart:convert';

ClockInResponseModel clockInResponseModelFromJson(String str) => ClockInResponseModel.fromJson(json.decode(str));

String clockInResponseModelToJson(ClockInResponseModel data) => json.encode(data.toJson());

class ClockInResponseModel {
  bool? error;
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
  int? id;
  String? schedulePeriod;
  int? accountId;
  String? accountName;
  int? houseId;
  String? houseName;
  String? houseAddress;
  int? dcId;
  String? directCare;
  String? scheduleDate;
  String? startTime;
  Null? startDateTime;
  String? endTime;
  Null? endDateTime;
  Null? actualStartDateTime;
  Null? actualEndDateTime;
  String? actualStartTime;
  String? actualEndTime;
  String? lunchTime;
  Null? totalTime;
  int? noBreakReason;
  Null? invoiceNumber;
  int? timeDiff;
  Null? hasDisputed;
  Null? overTimeComment;
  String? endUserLocation;
  bool? billClosed;
  bool? punchCardClosed;
  bool? isClosed;
  bool? approvedByBeacon;
  bool? approvedByManager;
  Null? overTimeEntry;
  Null? disputedHour;

  ClockInResponse(
      {this.id,
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
      this.actualStartTime,
      this.actualEndTime,
      this.lunchTime,
      this.totalTime,
      this.noBreakReason,
      this.invoiceNumber,
      this.timeDiff,
      this.hasDisputed,
      this.overTimeComment,
      this.endUserLocation,
      this.billClosed,
      this.punchCardClosed,
      this.isClosed,
      this.approvedByBeacon,
      this.approvedByManager,
      this.overTimeEntry,
      this.disputedHour});

  ClockInResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schedulePeriod = json['schedulePeriod'];
    accountId = json['accountId'];
    accountName = json['accountName'];
    houseId = json['houseId'];
    houseName = json['houseName'];
    houseAddress = json['houseAddress'];
    dcId = json['dcId'];
    directCare = json['directCare'];
    scheduleDate = json['scheduleDate'];
    startTime = json['startTime'];
    startDateTime = json['startDateTime'];
    endTime = json['endTime'];
    endDateTime = json['endDateTime'];
    actualStartDateTime = json['actualStartDateTime'];
    actualEndDateTime = json['actualEndDateTime'];
    actualStartTime = json['actualStartTime'];
    actualEndTime = json['actualEndTime'];
    lunchTime = json['lunchTime'];
    totalTime = json['totalTime'];
    noBreakReason = json['noBreakReason'];
    invoiceNumber = json['invoiceNumber'];
    timeDiff = json['timeDiff'];
    hasDisputed = json['hasDisputed'];
    overTimeComment = json['overTimeComment'];
    endUserLocation = json['endUserLocation'];
    billClosed = json['billClosed'];
    punchCardClosed = json['punchCardClosed'];
    isClosed = json['isClosed'];
    approvedByBeacon = json['approvedByBeacon'];
    approvedByManager = json['approvedByManager'];
    overTimeEntry = json['overTimeEntry'];
    disputedHour = json['disputedHour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['schedulePeriod'] = this.schedulePeriod;
    data['accountId'] = this.accountId;
    data['accountName'] = this.accountName;
    data['houseId'] = this.houseId;
    data['houseName'] = this.houseName;
    data['houseAddress'] = this.houseAddress;
    data['dcId'] = this.dcId;
    data['directCare'] = this.directCare;
    data['scheduleDate'] = this.scheduleDate;
    data['startTime'] = this.startTime;
    data['startDateTime'] = this.startDateTime;
    data['endTime'] = this.endTime;
    data['endDateTime'] = this.endDateTime;
    data['actualStartDateTime'] = this.actualStartDateTime;
    data['actualEndDateTime'] = this.actualEndDateTime;
    data['actualStartTime'] = this.actualStartTime;
    data['actualEndTime'] = this.actualEndTime;
    data['lunchTime'] = this.lunchTime;
    data['totalTime'] = this.totalTime;
    data['noBreakReason'] = this.noBreakReason;
    data['invoiceNumber'] = this.invoiceNumber;
    data['timeDiff'] = this.timeDiff;
    data['hasDisputed'] = this.hasDisputed;
    data['overTimeComment'] = this.overTimeComment;
    data['endUserLocation'] = this.endUserLocation;
    data['billClosed'] = this.billClosed;
    data['punchCardClosed'] = this.punchCardClosed;
    data['isClosed'] = this.isClosed;
    data['approvedByBeacon'] = this.approvedByBeacon;
    data['approvedByManager'] = this.approvedByManager;
    data['overTimeEntry'] = this.overTimeEntry;
    data['disputedHour'] = this.disputedHour;
    return data;
  }
}

