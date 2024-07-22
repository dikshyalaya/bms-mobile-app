import 'dart:convert';
import 'dart:developer';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/notifications/data/notification_model.dart';
import 'package:beacon_flutter/features/notifications/domain/notifications_repo.dart';
import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider();

  bool isNotificationFetching = false;
  bool isLoadingMore = false;
  int? page = 1;

  NotificationsModel? _notificationsModel;

  NotificationsModel? get notificationsModel => _notificationsModel;

  void setLoading(bool val) {
    isNotificationFetching = val;
    futureNotifyListeners();
  }

  Future<BMSResponse<NotificationsModel>> getNotifications(
      {bool isLoadMore = false}) async {
    if (isLoadMore == false) {
      page = 1;
    }
    final NotificationsRepo notificationsRepo = NotificationsRepo(page ?? 1);
    isLoadMore ? isLoadingMore = true : setLoading(true);
    notifyListeners();
    await notificationsRepo.fetch(
        params: {},
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            // networkState: networkState,
            onLoadedState: (loadedState) {
              onFutureNotifyListeners(() {
                final Map<String, dynamic> map = loadedState.response?.body;
                log("Notifications: $map");
                final notificationsData =
                    notificationsModelFromJson(jsonEncode(map['response']));
                page = notificationsData.nextPage;
                isLoadMore
                    ? _notificationsModel?.data
                        ?.addAll(notificationsData.data ?? [])
                    : _notificationsModel = notificationsData;
                // _notificationsModel =  notificationsData;
              });
            },
            onErrorState: (errorState) {
              notificationsModel?.data = [];
              onFutureNotifyListeners(() {
                // loadedPostModel = errorState.response?.body;
              });
            },
            onLoadingState: (loadingState) {},
          );
        });
    isLoadMore ? isLoadingMore = false : setLoading(false);
    return BMSResponse(body: notificationsModel);
  }

  Future<void> markAsRead(int id) async {
    final NotificationMarkAsSeenRepo notificationMarkAsSeenRepo =
        NotificationMarkAsSeenRepo(id);
    await notificationMarkAsSeenRepo.fetch(
        params: {},
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            // networkState: networkState,
            onLoadedState: (loadedState) {
              onFutureNotifyListeners(() {
                _notificationsModel?.data
                    ?.where((element) => element.id == id)
                    .first
                    .status = 0;
                notifyListeners();
              });
            },
            onErrorState: (errorState) {},
            onLoadingState: (loadingState) {},
          );
        });
  }
}
