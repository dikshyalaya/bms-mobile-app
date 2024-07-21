import 'dart:developer';
import 'package:beacon_flutter/features/notifications/data/notification_model.dart';
import 'package:beacon_flutter/features/notifications/domain/api_response.dart';
import 'package:beacon_flutter/features/notifications/domain/notification_service_pagination.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';



final notificationNotifier = ChangeNotifierProvider<ContestController>((ref) {
  return ContestController(ref);
});

class ContestController extends ChangeNotifier with NotificationServices {
  ContestController(this.ref);

  final Ref ref;

  ApiResponse allNotificationListApiResponse =
      ApiResponse.initial('Empty data');
      List<NotificationData> allNotification =[];



  Future<dynamic> fetchAllContestList(
      {currentPage = 0,
      bool isRefresh = false,
      query}) async {
    try {
      String query = '?take=20&skip=${currentPage * 20}';
      List<NotificationData> allNotificationTemp = [];
      if (!isRefresh) {
        allNotificationListApiResponse = ApiResponse.loading('');
      }
      notifyListeners();
      var response = await fetchAllNotificationFun(
          query: query,
         );
      log(response["data"]["result"].toString());
      response["data"]["result"].forEach((result) {
        allNotificationTemp.add(NotificationData.fromJson(result));
      });
      //if we scroll to fetch more data and the response date is empty
      if (isRefresh && allNotificationTemp.isEmpty && response != null) {
        allNotificationListApiResponse = ApiResponse.completed('');
        allNotification = allNotification;
        notifyListeners();
        return [];
      }
      allNotification = [...allNotification, ...allNotificationTemp];
      if (currentPage == 0) {
        allNotification = allNotificationTemp;
      }
      allNotificationListApiResponse = ApiResponse.completed('');
      notifyListeners();
      return [];
    } catch (e, stack) {
      allNotificationListApiResponse = ApiResponse.error('');
      notifyListeners();
      log(e.toString());
      log('The Shoutout list stack is --> $stack');
    }
  }

}
