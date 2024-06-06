import 'package:beacon_flutter/common/urls.dart';
import 'package:beacon_flutter/core/network/base_api_repository.dart';
import 'package:dio/dio.dart';

// class LoginRepo extends BaseApiRepository<Map<String, dynamic>> {
//   @override
//   dynamic parseJson(Response<dynamic> response) => {"response": response.data};

//   @override
//   String path(Map<String, String>? params, String? pathVariable) {
//     return logInUrl;
//   }
// }

class ChangePasswordRepo extends BaseApiRepository<Map<String, dynamic>> {
  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return changePasswordUrl;
  }
}

class SendOtpByEmailRepo extends BaseApiRepository<Map<String, dynamic>> {
  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return sendOtpByEmail;
  }
}

class ResetPasswordRepo extends BaseApiRepository<Map<String, dynamic>> {
  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return resetPassword;
  }
}

class SignupRepo extends BaseApiRepository<Map<String, dynamic>> {
  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return signUpUrl;
  }
}
