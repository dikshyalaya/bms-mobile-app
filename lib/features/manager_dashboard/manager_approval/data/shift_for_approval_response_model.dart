// To parse this JSON data, do
//
//     final shiftForApprovalResponseModel = shiftForApprovalResponseModelFromJson(jsonString);

import 'dart:convert';

ShiftForApprovalResponseModel shiftForApprovalResponseModelFromJson(
        String str) =>
    ShiftForApprovalResponseModel.fromJson(json.decode(str));

String shiftForApprovalResponseModelToJson(
        ShiftForApprovalResponseModel data) =>
    json.encode(data.toJson());

class ShiftForApprovalResponseModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? currentPage;
  dynamic nextPage;
  dynamic previouPage;
  int? pageSize;

  ShiftForApprovalResponseModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.nextPage,
    this.previouPage,
    this.pageSize,
  });

  factory ShiftForApprovalResponseModel.fromJson(Map<String, dynamic> json) =>
      ShiftForApprovalResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        previouPage: json["previouPage"],
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
        "previouPage": previouPage,
        "pageSize": pageSize,
      };
}

class Datum {
  int? id;
  String? schedulePeriod;
  int? accountId;
  String? accountName;
  int? houseId;
  String? houseName;
  dynamic houseAddress;
  int? dcId;
  String? directCare;
  String? scheduleDate;
  String? startTime;
  dynamic startDateTime;
  String? endTime;
  dynamic endDateTime;
  dynamic actualStartDateTime;
  dynamic actualEndDateTime;
  String? actualStartTime;
  String? actualEndTime;
  String? lunchTime;
  double? totalTime;
  String? noBreakReason;
  dynamic invoiceNumber;
  int? timeDiff;
  String? hasDisputed;
  String? overTimeComment;
  dynamic endUserLocation;
  bool? billClosed;
  bool? punchCardClosed;
  bool? isClosed;
  bool? approvedByBeacon;
  bool? approvedByManager;
  dynamic overTimeEntry;
  dynamic disputedHour;

  Datum({
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
    this.disputedHour,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        actualStartTime: json["actualStartTime"],
        actualEndTime: json["actualEndTime"],
        lunchTime: json["lunchTime"],
        totalTime: json["totalTime"]?.toDouble(),
        noBreakReason: json["noBreakReason"],
        invoiceNumber: json["invoiceNumber"],
        timeDiff: json["timeDiff"],
        hasDisputed: json["hasDisputed"],
        overTimeComment: json["overTimeComment"],
        endUserLocation: json["endUserLocation"],
        billClosed: json["billClosed"],
        punchCardClosed: json["punchCardClosed"],
        isClosed: json["isClosed"],
        approvedByBeacon: json["approvedByBeacon"],
        approvedByManager: json["approvedByManager"],
        overTimeEntry: json["overTimeEntry"],
        disputedHour: json["disputedHour"],
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
        "actualStartTime": actualStartTime,
        "actualEndTime": actualEndTime,
        "lunchTime": lunchTime,
        "totalTime": totalTime,
        "noBreakReason": noBreakReason,
        "invoiceNumber": invoiceNumber,
        "timeDiff": timeDiff,
        "hasDisputed": hasDisputed,
        "overTimeComment": overTimeComment,
        "endUserLocation": endUserLocation,
        "billClosed": billClosed,
        "punchCardClosed": punchCardClosed,
        "isClosed": isClosed,
        "approvedByBeacon": approvedByBeacon,
        "approvedByManager": approvedByManager,
        "overTimeEntry": overTimeEntry,
        "disputedHour": disputedHour,
      };
}
