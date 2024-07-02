// To parse this JSON data, do
//
//     final bmsUserModel = bmsUserModelFromJson(jsonString);

import 'dart:convert';

BmsUserModel bmsUserModelFromJson(String str) =>
    BmsUserModel.fromJson(json.decode(str));

String bmsUserModelToJson(BmsUserModel data) => json.encode(data.toJson());

class BmsUserModel {
  int userId;
  String email;
  String empLastName;
  String empFirstName;
  int empId;
  int userTypeId;
  bool isActive;
  bool isPasswordUpdateRequired;

  BmsUserModel({
    required this.userId,
    required this.email,
    required this.empLastName,
    required this.empFirstName,
    required this.empId,
    required this.userTypeId,
    required this.isActive,
    required this.isPasswordUpdateRequired,
  });

  factory BmsUserModel.fromJson(Map<String, dynamic> json) => BmsUserModel(
        userId: json["userId"],
        email: json["email"],
        empLastName: json["empLastName"],
        empFirstName: json["empFirstName"],
        empId: json["empId"],
        userTypeId: json["userTypeId"],
        isActive: json["isActive"],
        isPasswordUpdateRequired: json["isPasswordUpdateRequired"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "empLastName": empLastName,
        "empFirstName": empFirstName,
        "empId": empId,
        "userTypeId": userTypeId,
        "isActive": isActive,
        "isPasswordUpdateRequired": isPasswordUpdateRequired,
      };
}
