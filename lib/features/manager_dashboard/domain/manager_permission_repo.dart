import 'package:beacon_flutter/common/urls.dart';
import 'package:beacon_flutter/core/network/base_api_repository.dart';
import 'package:dio/dio.dart';

class ManagerPermissionRepo extends BaseApiRepository<Map<String, dynamic>> {
  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return managerPermission;
  }
}
