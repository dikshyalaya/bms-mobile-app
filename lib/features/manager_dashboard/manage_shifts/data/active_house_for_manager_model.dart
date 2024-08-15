// To parse this JSON data, do
//
//     final activeHouseForManagerModel = activeHouseForManagerModelFromJson(jsonString);

import 'dart:convert';

ActiveHouseForManagerModel activeHouseForManagerModelFromJson(String str) =>
    ActiveHouseForManagerModel.fromJson(json.decode(str));

String activeHouseForManagerModelToJson(ActiveHouseForManagerModel data) =>
    json.encode(data.toJson());

class ActiveHouseForManagerModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? currentPage;
  dynamic nextPage;
  dynamic previousPage;
  int? pageSize;

  ActiveHouseForManagerModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.nextPage,
    this.previousPage,
    this.pageSize,
  });

  factory ActiveHouseForManagerModel.fromJson(Map<String, dynamic> json) =>
      ActiveHouseForManagerModel(
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
  String? accountNumber;

  Datum({
    this.id,
    this.accountNumber,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        accountNumber: json["accountNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountNumber": accountNumber,
      };
}
