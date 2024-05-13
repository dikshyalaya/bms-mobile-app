// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:beacon_flutter/common/urls.dart';
import 'package:beacon_flutter/core/network/dio_manager.dart';
import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseApiRepository<T> {
  String path(Map<String, String>? params, String? pathVariable);

  parseJson(Response response);

  Future<void> fetch(
      {Map<String, String>? params,
      String? pathVariable,
      required ApiCallback<T> apiCallback,
      BaseUrlType baseUrlType = BaseUrlType.DEFAULT}) async {
    apiCallback(NetworkState.loading());
    try {
      String urlPath = path(params, pathVariable);

      if (pathVariable?.isNotEmpty ?? false) {
        urlPath += '/${pathVariable!}';
      }
      final response = await DioManager.instance
          .get(path: urlPath, baseUrlType: baseUrlType);
      if (response.statusCode == 200 || response.statusCode == 201) {
        apiCallback(NetworkState.loaded(
            BMSResponse.response(body: parseJson(response))));
      } else {
        apiCallback(NetworkState.error(
            BMSResponse.error(exception: BMSException(response.data))));
      }
    } on DioException catch (error) {
      apiCallback(NetworkState.error(
          BMSResponse.error(exception: BMSException(error.toString()))));
    }
  }

  Future<dynamic> post({
    Map<String, String>? params,
    String? pathVariable,
    required Object body,
    required ApiCallback<T> apiCallback,
    BaseUrlType baseUrlType = BaseUrlType.DEFAULT,
    ValueChanged<Map<String, dynamic>>? onAccessToken,
  }) async {
    try {
      apiCallback(NetworkState.loading());
      String urlPath = path(params, pathVariable);

      if (pathVariable?.isNotEmpty ?? false) {
        urlPath += '/${pathVariable!}';
      }

      final response = await DioManager.instance.post(
        path: urlPath,
        jsonBody: body,
        baseUrlType: baseUrlType,
      );
      log("Shift Approval Posting Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Check if the request was successful and data field exists
        if ((response.data["data"] != false) &&
            response.data["success"] == true) {
          // Call onAccessToken if logging in
          log("--response data------${response.data["data"]}-------");
          log("--response sucess------${response.data["success"]}-------");

          if (path(params, pathVariable).contains(logInUrl)) {
            onAccessToken?.call(response.data);
          }

          // Request was successful and contains valid data
          apiCallback(NetworkState.loaded(
              BMSResponse.response(body: parseJson(response))));
        } else {
          // Request was successful but response indicates an error
          final errorMessage =
              response.data["message"] ?? 'Unknown error occurred';
          apiCallback(NetworkState.error(
              BMSResponse.error(exception: BMSException(errorMessage))));
        }
      } else {
        // Request failed
        apiCallback(NetworkState.error(BMSResponse.error(
            exception: BMSException(response.data.toString()))));
      }
      return response.data;
    } on DioException catch (error) {
      // DioException occurred
      apiCallback(NetworkState.error(
          BMSResponse.error(exception: BMSException(error.toString()))));
      return error.response?.data;
    }
  }

  
  Dio dio = Dio();

  Future<dynamic> logIn({
    Map<String, String>? params,
    String? pathVariable,
    required Map<String, dynamic> body,
    required ApiCallback<T> apiCallback,
    BaseUrlType baseUrlType = BaseUrlType.DEFAULT,
    ValueChanged<Map<String, dynamic>>? onAccessToken,
  }) async {
    try {
      apiCallback(NetworkState.loading());
      // final urlPath = path(params, pathVariable);

      String urlPath = "https://api.loadnepal.com/api/shipper-auth/login";

      final response = await dio.post(
        urlPath,
        data: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        onAccessToken!(response.data);

        apiCallback(NetworkState.loaded(
            BMSResponse.response(body: parseJson(response))));
      } else {
        apiCallback(NetworkState.error(BMSResponse.error(
            exception: BMSException(response.data.toString()))));
      }
      return response.data;
    } on DioException catch (error) {
      apiCallback(NetworkState.error(BMSResponse.error(
          exception: BMSException(error.response?.data[0]["message"]))));

      return NetworkState.error(BMSResponse.error(
          exception: BMSException(error.response?.data[0]["message"])));
    }
  }

  Future<void> put(
      {Map<String, String>? params,
      String? pathVariable,
      required Map<String, dynamic> body,
      required ApiCallback<T> apiCallback,
      BaseUrlType baseUrlType = BaseUrlType.DEFAULT}) async {
    try {
      apiCallback(NetworkState.loading());
      String urlPath = path(params, pathVariable);

      if (pathVariable?.isNotEmpty ?? false) {
        urlPath += '/${pathVariable!}';
      }

      final response = await DioManager.instance
          .put(path: urlPath, jsonBody: body, baseUrlType: baseUrlType);
      if (response.statusCode == 200 || response.statusCode == 201) {
        apiCallback(NetworkState.loaded(
            BMSResponse.response(body: parseJson(response))));
      } else {
        apiCallback(NetworkState.error(BMSResponse.error(
            exception: BMSException(response.data.toString()))));
      }
    } on DioException catch (error) {
      apiCallback(NetworkState.error(
          BMSResponse.error(exception: BMSException(error.toString()))));
    }
  }

  Future<dynamic> delete({
    Map<String, String>? params,
    String? pathVariable,
    Map<String, dynamic>? body,
    required ApiCallback<T> apiCallback,
    BaseUrlType baseUrlType = BaseUrlType.DEFAULT,
    ValueChanged<Map<String, dynamic>>? onAccessToken,
  }) async {
    try {
      apiCallback(NetworkState.loading());
      String urlPath = path(params, pathVariable);

      if (pathVariable?.isNotEmpty ?? false) {
        urlPath += '/${pathVariable!}';
      }
      final response = await DioManager.instance.delete(
        path: urlPath,
        jsonBody: body ?? {},
        baseUrlType: baseUrlType,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        apiCallback(NetworkState.loaded(
            BMSResponse.response(body: parseJson(response))));
      } else {
        apiCallback(NetworkState.error(BMSResponse.error(
            exception: BMSException(response.data.toString()))));
      }
      return response.data;
    } on DioException catch (error) {
      apiCallback(NetworkState.error(
          BMSResponse.error(exception: BMSException(error.toString()))));

      return error.response?.data;
    }
  }
}
