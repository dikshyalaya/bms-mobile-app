import 'package:beacon_flutter/common/urls.dart';
import 'package:beacon_flutter/core/network/base_api_repository.dart';
import 'package:dio/dio.dart';

class ShiftForApprovalRepo extends BaseApiRepository<Map<String, dynamic>> {
  ShiftForApprovalRepo();

  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return "$listShiftsForApproval/${params?['houseId']}";
  }
}

class ApproveShiftRepo extends BaseApiRepository<Map<String, dynamic>> {
  ApproveShiftRepo();

  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return approveShifts;
  }
}
class RaiseDisputeRepo extends BaseApiRepository<Map<String, dynamic>> {
  RaiseDisputeRepo();

  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return raiseDispute;
  }
}
