// To parse this JSON data, do
//
//     final managerPermission = managerPermissionFromJson(jsonString);

import 'dart:convert';

ManagerPermissionModel managerPermissionModelFromJson(String str) => ManagerPermissionModel.fromJson(json.decode(str));

String managerPermissionToJson(ManagerPermissionModel data) => json.encode(data.toJson());

class ManagerPermissionModel {
  bool error;
  String message;
  Data data;
  int currentPage;
  dynamic nextPage;
  dynamic previouPage;
  int pageSize;

  ManagerPermissionModel({
    required this.error,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.nextPage,
    required this.previouPage,
    required this.pageSize,
  });

  factory ManagerPermissionModel.fromJson(Map<String, dynamic> json) => ManagerPermissionModel(
    error: json["error"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    currentPage: json["currentPage"],
    nextPage: json["nextPage"],
    previouPage: json["previouPage"],
    pageSize: json["pageSize"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data.toJson(),
    "currentPage": currentPage,
    "nextPage": nextPage,
    "previouPage": previouPage,
    "pageSize": pageSize,
  };
}

class Data {
  int allowManagerApproval;
  int viewApprovalHistory;
  int allowViewSchedule;
  int allowViewBill;
  int allowApproveBill;
  int allowManageShifts;
  int allowManageHouseEmployees;

  Data({
    required this.allowManagerApproval,
    required this.viewApprovalHistory,
    required this.allowViewSchedule,
    required this.allowViewBill,
    required this.allowApproveBill,
    required this.allowManageShifts,
    required this.allowManageHouseEmployees,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    allowManagerApproval: json["allowManagerApproval"],
    viewApprovalHistory: json["viewApprovalHistory"],
    allowViewSchedule: json["allowViewSchedule"],
    allowViewBill: json["allowViewBill"],
    allowApproveBill: json["allowApproveBill"],
    allowManageShifts: json["allowManageShifts"],
    allowManageHouseEmployees: json["allowManageHouseEmployees"],
  );

  Map<String, dynamic> toJson() => {
    "allowManagerApproval": allowManagerApproval,
    "viewApprovalHistory": viewApprovalHistory,
    "allowViewSchedule": allowViewSchedule,
    "allowViewBill": allowViewBill,
    "allowApproveBill": allowApproveBill,
    "allowManageShifts": allowManageShifts,
    "allowManageHouseEmployees": allowManageHouseEmployees,
  };
}
