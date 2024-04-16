import 'package:beacon_flutter/common/urls.dart';
import 'package:beacon_flutter/core/network/base_api_repository.dart';
import 'package:dio/dio.dart';

class AvailableShiftRepo extends BaseApiRepository<Map<String, dynamic>> {
  final String dcId;

  AvailableShiftRepo(this.dcId);

  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return '$availableShiftForDCList/$dcId';
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

class ListHouseForDCAddShiftRepo
    extends BaseApiRepository<Map<String, dynamic>> {
  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return listHouseForDCAddShift;
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
