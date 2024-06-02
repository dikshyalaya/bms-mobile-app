import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/notifications/domain/notification_provider.dart';
import 'package:beacon_flutter/features/notifications/widget/notification_card.dart';
import 'package:beacon_flutter/utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AuthProvider, NotificationProvider>(
      update: (_, authProvider, notificationProvider) {
        return NotificationProvider()..getNotifications();
      },
      create: (_) => NotificationProvider(),
      lazy: false,
      builder: (context, child) => ScaffoldBackGroundWrapper(
        appBar: const BeaconAppBar(
          title: "Notifications",
          leadingIcon: AppBarLeadingIcon(),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Selector<NotificationProvider, bool>(
            builder: (context, isNotificationFetching, child) {
              final notificationsModel =
                  Provider.of<NotificationProvider>(context, listen: false)
                      .notificationsModel;

              return ServerResponseBuilder(
                builder: (context) => notificationsModel!.data!.isEmpty
                    ? const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'No Notifications Found',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ))
                    : Card(
                        margin: bodyOnlyPadding(context),
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: (notificationsModel.data ?? []).length,
                          itemBuilder: (context, index) {
                            final currentNotification =
                                notificationsModel.data?[index];
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
                isDataFetching: isNotificationFetching,
                isNullData: notificationsModel?.data == null,
              );
            },
            selector: (context, provider) => provider.isNotificationFetching,
          ),
        ),
      ),
    );
  }
}
