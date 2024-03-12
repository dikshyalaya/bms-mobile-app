// To parse this JSON data, do
//
//     final bmsUserModel = bmsUserModelFromJson(jsonString);

import 'dart:convert';

BmsUserModel bmsUserModelFromJson(String str) => BmsUserModel.fromJson(json.decode(str));

String bmsUserModelToJson(BmsUserModel data) => json.encode(data.toJson());

class BmsUserModel {
  String email;
  String empLastName;
  String empFirstName;
  int empId;
  int userTypeId;
  bool isActive;

  BmsUserModel({
    required this.email,
    required this.empLastName,
    required this.empFirstName,
    required this.empId,
    required this.userTypeId,
    required this.isActive,
  });

  factory BmsUserModel.fromJson(Map<String, dynamic> json) => BmsUserModel(
    email: json["email"],
    empLastName: json["empLastName"],
    empFirstName: json["empFirstName"],
    empId: json["empId"],
    userTypeId: json["userTypeId"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "empLastName": empLastName,
    "empFirstName": empFirstName,
    "empId": empId,
    "userTypeId": userTypeId,
    "isActive": isActive,
  };
}
