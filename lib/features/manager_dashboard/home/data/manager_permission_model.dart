// To parse this JSON data, do
//
//     final managerPermissionModel = managerPermissionModelFromJson(jsonString);

import 'dart:convert';

ManagerPermissionModel managerPermissionModelFromJson(String str) =>
    ManagerPermissionModel.fromJson(json.decode(str));

String managerPermissionModelToJson(ManagerPermissionModel data) =>
    json.encode(data.toJson());

class ManagerPermissionModel {
  bool? success;
  String? message;
  Data? data;
  int? currentPage;
  dynamic nextPage;
  dynamic previousPage;
  int? pageSize;

  ManagerPermissionModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.nextPage,
    this.previousPage,
    this.pageSize,
  });

  factory ManagerPermissionModel.fromJson(Map<String, dynamic> json) =>
      ManagerPermissionModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        pageSize: json["pageSize"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "currentPage": currentPage,
        "nextPage": nextPage,
        "previousPage": previousPage,
        "pageSize": pageSize,
      };
}

class Data {
  int? allowManagerApproval;
  int? allowManageShifts;
  int? allowManageHouseEmployees;
  int? allowManageHouseShifts;
  int? viewApprovalHistory;
  int? allowViewBill;
  int? allowApproveBill;
  int? allowViewSchedule;

  Data({
    this.allowManagerApproval,
    this.allowManageShifts,
    this.allowManageHouseEmployees,
    this.allowManageHouseShifts,
    this.viewApprovalHistory,
    this.allowViewBill,
    this.allowApproveBill,
    this.allowViewSchedule,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        allowManagerApproval: json["allowManagerApproval"],
        allowManageShifts: json["allowManageShifts"],
        allowManageHouseEmployees: json["allowManageHouseEmployees"],
        allowManageHouseShifts: json["allowManageHouseShifts"],
        viewApprovalHistory: json["viewApprovalHistory"],
        allowViewBill: json["allowViewBill"],
        allowApproveBill: json["allowApproveBill"],
        allowViewSchedule: json["allowViewSchedule"],
      );

  Map<String, dynamic> toJson() => {
        "allowManagerApproval": allowManagerApproval,
        "allowManageShifts": allowManageShifts,
        "allowManageHouseEmployees": allowManageHouseEmployees,
        "allowManageHouseShifts": allowManageHouseShifts,
        "viewApprovalHistory": viewApprovalHistory,
        "allowViewBill": allowViewBill,
        "allowApproveBill": allowApproveBill,
        "allowViewSchedule": allowViewSchedule,
      };
}
