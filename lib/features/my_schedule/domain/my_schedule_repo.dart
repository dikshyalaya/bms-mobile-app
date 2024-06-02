import 'package:beacon_flutter/common/urls.dart';
import 'package:beacon_flutter/core/network/base_api_repository.dart';
import 'package:dio/dio.dart';

class MyScheduleRepo extends BaseApiRepository<Map<String, dynamic>> {
  final String dcId;

  MyScheduleRepo(this.dcId);

  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return myScheduleList;
  }
}

class CancelShiftRepo extends BaseApiRepository<Map<String, dynamic>> {
  final int shiftId;

  CancelShiftRepo(this.shiftId);

  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return '$cancelShift/$shiftId';
  }
}

class HouseWorkedInLastThreeWeeksRepo
    extends BaseApiRepository<Map<String, dynamic>> {
  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return getHouseWorkedInLastThreeWeeks;
  }
}

class CreateShiftRepo extends BaseApiRepository<Map<String, dynamic>> {
  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return createShift;
  }
}
