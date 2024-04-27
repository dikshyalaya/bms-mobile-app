// To parse this JSON data, do
//
//     final accountHousesResponseModel = accountHousesResponseModelFromJson(jsonString);

import 'dart:convert';

AccountHousesResponseModel accountHousesResponseModelFromJson(String str) =>
    AccountHousesResponseModel.fromJson(json.decode(str));

String accountHousesResponseModelToJson(AccountHousesResponseModel data) =>
    json.encode(data.toJson());

class AccountHousesResponseModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? currentPage;
  dynamic nextPage;
  dynamic previouPage;
  int? pageSize;

  AccountHousesResponseModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.nextPage,
    this.previouPage,
    this.pageSize,
  });

  factory AccountHousesResponseModel.fromJson(Map<String, dynamic> json) =>
      AccountHousesResponseModel(
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
  dynamic parentId;
  dynamic type;
  String? accountNumber;
  dynamic createdDate;
  dynamic createdBy;
  dynamic updatedDate;
  dynamic updatedBy;
  dynamic hsName;
  dynamic hsPhone;
  dynamic invoiceemail;
  dynamic deptCode;
  dynamic code;
  dynamic hsAddress;
  dynamic city;
  dynamic state;
  dynamic zip;
  dynamic email;
  dynamic defaultRate;
  dynamic amaprate;
  dynamic password;
  dynamic aptNo;
  dynamic rateIncreaseDate;
  dynamic billingCode;
  dynamic noOfIndividuals;
  dynamic noOfGenderMale;
  dynamic noOfGenderFeMale;
  dynamic noOfGenderMix;
  dynamic staffGenderMale;
  dynamic staffGenderFeMale;
  dynamic staffGenderEither;
  dynamic houseAmbulatory;
  dynamic houseScip;
  dynamic houseFirstAidCpr;
  dynamic houseAmap;
  dynamic houseBehaviors;
  dynamic allowPunch;
  dynamic electronicTimesheet;
  dynamic invitationArea;
  dynamic excelName;
  dynamic isTraining;
  dynamic secInvitationArea;
  dynamic quickbookCustomer;
  dynamic quickbookSiteName;
  dynamic quickbookItem;
  dynamic programName;
  dynamic programCode;
  dynamic locationOfServices;
  dynamic qbaccountName;
  dynamic useQbaccount;
  dynamic rate;
  dynamic rateIncreaseDate1;
  dynamic rateIncreaseDate2;
  dynamic rate2;
  dynamic term;
  dynamic certification;
  dynamic covidDspterm;
  dynamic femaleOnly;
  dynamic billableName;
  dynamic houseType;
  dynamic relatedHouses;
  int? allowCopy;
  dynamic lunchDuration;
  dynamic overTimeSetting;
  int? dsprequiredTraining;
  dynamic latLng;
  dynamic parentAccount;
  List<Datum>? houses;

  Datum({
    this.id,
    this.parentId,
    this.type,
    this.accountNumber,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.hsName,
    this.hsPhone,
    this.invoiceemail,
    this.deptCode,
    this.code,
    this.hsAddress,
    this.city,
    this.state,
    this.zip,
    this.email,
    this.defaultRate,
    this.amaprate,
    this.password,
    this.aptNo,
    this.rateIncreaseDate,
    this.billingCode,
    this.noOfIndividuals,
    this.noOfGenderMale,
    this.noOfGenderFeMale,
    this.noOfGenderMix,
    this.staffGenderMale,
    this.staffGenderFeMale,
    this.staffGenderEither,
    this.houseAmbulatory,
    this.houseScip,
    this.houseFirstAidCpr,
    this.houseAmap,
    this.houseBehaviors,
    this.allowPunch,
    this.electronicTimesheet,
    this.invitationArea,
    this.excelName,
    this.isTraining,
    this.secInvitationArea,
    this.quickbookCustomer,
    this.quickbookSiteName,
    this.quickbookItem,
    this.programName,
    this.programCode,
    this.locationOfServices,
    this.qbaccountName,
    this.useQbaccount,
    this.rate,
    this.rateIncreaseDate1,
    this.rateIncreaseDate2,
    this.rate2,
    this.term,
    this.certification,
    this.covidDspterm,
    this.femaleOnly,
    this.billableName,
    this.houseType,
    this.relatedHouses,
    this.allowCopy,
    this.lunchDuration,
    this.overTimeSetting,
    this.dsprequiredTraining,
    this.latLng,
    this.parentAccount,
    this.houses,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        parentId: json["parentId"],
        type: json["type"],
        accountNumber: json["accountNumber"],
        createdDate: json["createdDate"],
        createdBy: json["createdBy"],
        updatedDate: json["updatedDate"],
        updatedBy: json["updatedBy"],
        hsName: json["hsName"],
        hsPhone: json["hsPhone"],
        invoiceemail: json["invoiceemail"],
        deptCode: json["deptCode"],
        code: json["code"],
        hsAddress: json["hsAddress"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        email: json["email"],
        defaultRate: json["defaultRate"],
        amaprate: json["amaprate"],
        password: json["password"],
        aptNo: json["aptNo"],
        rateIncreaseDate: json["rateIncreaseDate"],
        billingCode: json["billingCode"],
        noOfIndividuals: json["noOfIndividuals"],
        noOfGenderMale: json["noOfGenderMale"],
        noOfGenderFeMale: json["noOfGenderFeMale"],
        noOfGenderMix: json["noOfGenderMix"],
        staffGenderMale: json["staffGenderMale"],
        staffGenderFeMale: json["staffGenderFeMale"],
        staffGenderEither: json["staffGenderEither"],
        houseAmbulatory: json["houseAmbulatory"],
        houseScip: json["houseScip"],
        houseFirstAidCpr: json["houseFirstAidCpr"],
        houseAmap: json["houseAmap"],
        houseBehaviors: json["houseBehaviors"],
        allowPunch: json["allowPunch"],
        electronicTimesheet: json["electronicTimesheet"],
        invitationArea: json["invitationArea"],
        excelName: json["excelName"],
        isTraining: json["isTraining"],
        secInvitationArea: json["secInvitationArea"],
        quickbookCustomer: json["quickbookCustomer"],
        quickbookSiteName: json["quickbookSiteName"],
        quickbookItem: json["quickbookItem"],
        programName: json["programName"],
        programCode: json["programCode"],
        locationOfServices: json["locationOfServices"],
        qbaccountName: json["qbaccountName"],
        useQbaccount: json["useQbaccount"],
        rate: json["rate"],
        rateIncreaseDate1: json["rateIncreaseDate1"],
        rateIncreaseDate2: json["rateIncreaseDate2"],
        rate2: json["rate2"],
        term: json["term"],
        certification: json["certification"],
        covidDspterm: json["covidDspterm"],
        femaleOnly: json["femaleOnly"],
        billableName: json["billableName"],
        houseType: json["houseType"],
        relatedHouses: json["relatedHouses"],
        allowCopy: json["allowCopy"],
        lunchDuration: json["lunchDuration"],
        overTimeSetting: json["overTimeSetting"],
        dsprequiredTraining: json["dsprequiredTraining"],
        latLng: json["latLng"],
        parentAccount: json["parentAccount"],
        houses: json["houses"] == null
            ? []
            : List<Datum>.from(json["houses"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentId": parentId,
        "type": type,
        "accountNumber": accountNumber,
        "createdDate": createdDate,
        "createdBy": createdBy,
        "updatedDate": updatedDate,
        "updatedBy": updatedBy,
        "hsName": hsName,
        "hsPhone": hsPhone,
        "invoiceemail": invoiceemail,
        "deptCode": deptCode,
        "code": code,
        "hsAddress": hsAddress,
        "city": city,
        "state": state,
        "zip": zip,
        "email": email,
        "defaultRate": defaultRate,
        "amaprate": amaprate,
        "password": password,
        "aptNo": aptNo,
        "rateIncreaseDate": rateIncreaseDate,
        "billingCode": billingCode,
        "noOfIndividuals": noOfIndividuals,
        "noOfGenderMale": noOfGenderMale,
        "noOfGenderFeMale": noOfGenderFeMale,
        "noOfGenderMix": noOfGenderMix,
        "staffGenderMale": staffGenderMale,
        "staffGenderFeMale": staffGenderFeMale,
        "staffGenderEither": staffGenderEither,
        "houseAmbulatory": houseAmbulatory,
        "houseScip": houseScip,
        "houseFirstAidCpr": houseFirstAidCpr,
        "houseAmap": houseAmap,
        "houseBehaviors": houseBehaviors,
        "allowPunch": allowPunch,
        "electronicTimesheet": electronicTimesheet,
        "invitationArea": invitationArea,
        "excelName": excelName,
        "isTraining": isTraining,
        "secInvitationArea": secInvitationArea,
        "quickbookCustomer": quickbookCustomer,
        "quickbookSiteName": quickbookSiteName,
        "quickbookItem": quickbookItem,
        "programName": programName,
        "programCode": programCode,
        "locationOfServices": locationOfServices,
        "qbaccountName": qbaccountName,
        "useQbaccount": useQbaccount,
        "rate": rate,
        "rateIncreaseDate1": rateIncreaseDate1,
        "rateIncreaseDate2": rateIncreaseDate2,
        "rate2": rate2,
        "term": term,
        "certification": certification,
        "covidDspterm": covidDspterm,
        "femaleOnly": femaleOnly,
        "billableName": billableName,
        "houseType": houseType,
        "relatedHouses": relatedHouses,
        "allowCopy": allowCopy,
        "lunchDuration": lunchDuration,
        "overTimeSetting": overTimeSetting,
        "dsprequiredTraining": dsprequiredTraining,
        "latLng": latLng,
        "parentAccount": parentAccount,
        "houses": houses == null
            ? []
            : List<dynamic>.from(houses!.map((x) => x.toJson())),
      };
}
