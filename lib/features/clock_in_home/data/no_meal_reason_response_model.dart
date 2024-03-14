// To parse this JSON data, do
//
//     final noMealReasonResponseModel = noMealReasonResponseModelFromJson(jsonString);

import 'dart:convert';

NoMealReasonResponseModel noMealReasonResponseModelFromJson(String str) => NoMealReasonResponseModel.fromJson(json.decode(str));

String noMealReasonResponseModelToJson(NoMealReasonResponseModel data) => json.encode(data.toJson());

class NoMealReasonResponseModel {
  bool error;
  String message;
  List<NoMealResponseModel> ?data;
  int currentPage;
  dynamic nextPage;
  dynamic previouPage;
  int pageSize;

  NoMealReasonResponseModel({
    required this.error,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.nextPage,
    required this.previouPage,
    required this.pageSize,
  });

  factory NoMealReasonResponseModel.fromJson(Map<String, dynamic> json) => NoMealReasonResponseModel(
    error: json["error"],
    message: json["message"],
    data: List<NoMealResponseModel>.from(json["data"].map((x) => NoMealResponseModel.fromJson(x))),
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

class NoMealResponseModel {
  int id;
  String masterFor;
  String name;
  String description;

  NoMealResponseModel({
    required this.id,
    required this.masterFor,
    required this.name,
    required this.description,
  });

  factory NoMealResponseModel.fromJson(Map<String, dynamic> json) => NoMealResponseModel(
    id: json["id"],
    masterFor: json["masterFor"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "masterFor": masterFor,
    "name": name,
    "description": description,
  };
}
