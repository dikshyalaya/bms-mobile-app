// ignore_for_file: unnecessary_brace_in_string_interps

// Project imports:
import 'dart:developer';

mixin NotificationServices {
  // final _client = ApiHelper.instance;

  // create Contest //
  Future<dynamic> fetchAllNotificationFun({String query =''}) async {
    try {
      var response = await _client.post(Api.contest, data: body);
      log(response.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }

}
