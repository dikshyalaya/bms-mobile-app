// To parse this JSON data, do
//
//     final systemSettings = systemSettingsFromJson(jsonString);

import 'dart:convert';

SystemSettingsModel systemSettingsFromJson(String str) => SystemSettingsModel.fromJson(json.decode(str));

String systemSettingsToJson(SystemSettingsModel data) => json.encode(data.toJson());

class SystemSettingsModel {
  int id;
  String settingName;
  String pageName;
  String description;
  SiteSetting siteSetting;

  SystemSettingsModel({
    required this.id,
    required this.settingName,
    required this.pageName,
    required this.description,
    required this.siteSetting,
  });

  factory SystemSettingsModel.fromJson(Map<String, dynamic> json) => SystemSettingsModel(
    id: json["id"],
    settingName: json["settingName"],
    pageName: json["pageName"],
    description: json["description"],
    siteSetting: SiteSetting.fromJson(json["siteSetting"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "settingName": settingName,
    "pageName": pageName,
    "description": description,
    "siteSetting": siteSetting.toJson(),
  };
}

class SiteSetting {
  AddShift clockIn;
  AddShift mySchedule;
  AddShift shiftAvailability;
  AddShift priorClockIn;
  AddShift addShift;
  AddShift lookingForShift;

  SiteSetting({
    required this.clockIn,
    required this.mySchedule,
    required this.shiftAvailability,
    required this.priorClockIn,
    required this.addShift,
    required this.lookingForShift,
  });

  factory SiteSetting.fromJson(Map<String, dynamic> json) => SiteSetting(
    clockIn: AddShift.fromJson(json["clock-in"]),
    mySchedule: AddShift.fromJson(json["my-schedule"]),
    shiftAvailability: AddShift.fromJson(json["shift-availability"]),
    priorClockIn: AddShift.fromJson(json["prior-clock-in"]),
    addShift: AddShift.fromJson(json["add-shift"]),
    lookingForShift: AddShift.fromJson(json["looking-for-shift"]),
  );

  Map<String, dynamic> toJson() => {
    "clock-in": clockIn.toJson(),
    "my-schedule": mySchedule.toJson(),
    "shift-availability": shiftAvailability.toJson(),
    "prior-clock-in": priorClockIn.toJson(),
    "add-shift": addShift.toJson(),
    "looking-for-shift": lookingForShift.toJson(),
  };
}

class AddShift {
  String popup;
  bool enable;

  AddShift({
    required this.popup,
    required this.enable,
  });

  factory AddShift.fromJson(Map<String, dynamic> json) => AddShift(
    popup: json["popup"],
    enable: json["enable"],
  );

  Map<String, dynamic> toJson() => {
    "popup": popup,
    "enable": enable,
  };
}
