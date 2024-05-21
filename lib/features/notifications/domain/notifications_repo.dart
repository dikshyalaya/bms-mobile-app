import 'package:beacon_flutter/common/urls.dart';
import 'package:beacon_flutter/core/network/base_api_repository.dart';
import 'package:dio/dio.dart';

class NotificationsRepo extends BaseApiRepository<Map<String, dynamic>> {
  final int page;
  NotificationsRepo(this.page);

  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return "$notificationHistory/$page";
  }
}

class NotificationMarkAsSeenRepo
    extends BaseApiRepository<Map<String, dynamic>> {
  final int notificationId;
  NotificationMarkAsSeenRepo(this.notificationId);

  @override
  dynamic parseJson(Response<dynamic> response) => {"response": response.data};

  @override
  String path(Map<String, String>? params, String? pathVariable) {
    return "$notificationMarkAsSeen/$notificationId";
  }
}
