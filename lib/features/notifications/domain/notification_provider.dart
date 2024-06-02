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

  NotificationsModel? _notificationsModel;

  NotificationsModel? get notificationsModel => _notificationsModel;

  set setNotificationModels(NotificationsModel? value) {
    _notificationsModel = value;
  }

  void setLoading(bool val) {
    isNotificationFetching = val;
    futureNotifyListeners();
  }

  Future<BMSResponse<NotificationsModel>> getNotifications() async {
    final NotificationsRepo notificationsRepo = NotificationsRepo(1);
    setLoading(true);
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
                setNotificationModels =
                    notificationsModelFromJson(jsonEncode(map['response']));
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
    setLoading(false);
    return BMSResponse(body: notificationsModel);
  }
}
