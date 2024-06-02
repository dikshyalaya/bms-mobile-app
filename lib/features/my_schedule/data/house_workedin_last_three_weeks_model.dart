// To parse this JSON data, do
//
//     final houseWorkedInLastThreeWeeksModel = houseWorkedInLastThreeWeeksModelFromJson(jsonString);

import 'dart:convert';

HouseWorkedInLastThreeWeeksModel houseWorkedInLastThreeWeeksModelFromJson(String str) =>
    HouseWorkedInLastThreeWeeksModel.fromJson(json.decode(str));

String houseWorkedInLastThreeWeeksModelToJson(HouseWorkedInLastThreeWeeksModel data) =>
    json.encode(data.toJson());

class HouseWorkedInLastThreeWeeksModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? currentPage;
  dynamic nextPage;
  dynamic previouPage;
  int? pageSize;

  HouseWorkedInLastThreeWeeksModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.nextPage,
    this.previouPage,
    this.pageSize,
  });

  factory HouseWorkedInLastThreeWeeksModel.fromJson(Map<String, dynamic> json) =>
      HouseWorkedInLastThreeWeeksModel(
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
  String? id;
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
