import 'package:beacon_flutter/common/urls.dart';
import 'package:beacon_flutter/core/network/base_api_repository.dart';
import 'package:dio/dio.dart';

class ClockInRepo extends BaseApiRepository<Map<String, dynamic>> {
  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    // if (params != null && (params['dcId']!.isNotEmpty)) {
    //   Map<String, String> paramsFinal =
    //   params.map((key, value) => MapEntry(key, value.toString()));
    //   return Uri.http("", clockInUrl, paramsFinal)
    //       .toString()
    //       .replaceAll("http:", "");
    // } else {
      return clockInUrl;
    // }
  }
}
