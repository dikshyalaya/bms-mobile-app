import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/notifications/domain/notification_provider.dart';
import 'package:beacon_flutter/features/notifications/widget/notification_card.dart';
import 'package:beacon_flutter/utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final notifications =
        Provider.of<NotificationProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifications.getNotifications();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (notifications.page != null) {
          loadMoreData();
        }
      }
    });
    super.initState();
  }

  Future<void> loadMoreData() async {
    final notifications =
        Provider.of<NotificationProvider>(context, listen: false);

    await notifications.getNotifications(isLoadMore: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: true);
    return ScaffoldBackGroundWrapper(
      appBar: const BeaconAppBar(
        title: "Notifications",
        leadingIcon: AppBarLeadingIcon(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: notificationProvider.isNotificationFetching == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : (notificationProvider.notificationsModel?.data ?? []).isEmpty
                ? const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No Notifications Found!',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return notificationProvider.getNotifications();
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Card(
                            margin: bodyOnlyPadding(context),
                            color: Colors.white,
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: (notificationProvider
                                          .notificationsModel?.data ??
                                      [])
                                  .length,
                              itemBuilder: (context, index) {
                                final currentNotification = notificationProvider
                                    .notificationsModel?.data?[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: NotificationCard(
                                    notification: currentNotification!,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: notificationProvider.isLoadingMore,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
