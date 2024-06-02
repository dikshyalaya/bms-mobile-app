// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? currentPage;
  int? nextPage;
  dynamic previouPage;
  int? pageSize;

  NotificationsModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.nextPage,
    this.previouPage,
    this.pageSize,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
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
  int? senderId;
  int? receipentId;
  String? title;
  String? body;
  int? status;
  dynamic notifiedDevices;
  DateTime? createdDate;
  dynamic seenDate;

  Datum({
    this.id,
    this.senderId,
    this.receipentId,
    this.title,
    this.body,
    this.status,
    this.notifiedDevices,
    this.createdDate,
    this.seenDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        senderId: json["senderId"],
        receipentId: json["receipentId"],
        title: json["title"],
        body: json["body"],
        status: json["status"],
        notifiedDevices: json["notifiedDevices"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        seenDate: json["seenDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "senderId": senderId,
        "receipentId": receipentId,
        "title": title,
        "body": body,
        "status": status,
        "notifiedDevices": notifiedDevices,
        "createdDate": createdDate?.toIso8601String(),
        "seenDate": seenDate,
      };
}
