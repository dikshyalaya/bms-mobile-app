import 'dart:developer';

import 'package:beacon_flutter/common/local_db/hive_model.dart';
import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:beacon_flutter/empty_dash_board.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/auth/domain/navigation_handler.dart';
import 'package:beacon_flutter/features/dashboard/domain/system_setting_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/looking_for_shift/domain/looking_for_shift_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/home/domain/manager_permission_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/domain/manager_approval_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/home/widget/manager_dashboard_home.dart';
import 'package:beacon_flutter/service/local_notification_service.dart';
import 'package:beacon_flutter/utils/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:splash_view/source/source.dart';

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return false;
  }
  return true;
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  LocalNotificationService.createAndDisplayNotificationForFirebaseNotification(
      message,
      isAppInBackground: true);

  log("Handling a background message: ${message.messageId}");
}

void listenFCMForeground() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              //      one that already exists in example app.
              icon: '@drawable/app_icon',
              color: Colors.transparent,
              importance: Importance.max),
        ),
      );
    }
  });
}

void main() async {
  bool isLoggedIn = false;
  // await handleLocationPermission();
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await BMSHiveModel.init();
  final accessToken = await BMSHiveModel.hive.get(BMSHiveModel.ACCESS_TOKEN);
  isLoggedIn = accessToken?.isNotEmpty ?? false;
  await Firebase.initializeApp();
  PermissionStatus status = await Permission.notification.request();

  if (status.isGranted) {
  } else {
    Permission.notification.request();
  }
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      enableVibration: true,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
    });

    // Register the foreground handler
    listenFCMForeground();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  LocalNotificationService.initialize();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider()..getUserDetail()),
        ChangeNotifierProvider<ManagePermissionProvider>(
            create: (_) => ManagePermissionProvider()..getManagerPermission()),
        ChangeNotifierProvider<SystemSettingProvider>(
            create: (_) => SystemSettingProvider()..getSystemSettings()),
        ChangeNotifierProxyProvider<AuthProvider, LookingForShiftProvider>(
            update: (_, authProvider, clockInProvide) {
              return LookingForShiftProvider(
                  authProvider.bmsUserModel?.empId ?? 0);
            },
            lazy: false,
            create: (_) => LookingForShiftProvider(0)..getAllSchedulePeriods()),
        ChangeNotifierProvider<NavigationHandler>(
            create: (_) => NavigationHandler()),
        ChangeNotifierProvider<ManagerApprovalProvider>(
            create: (_) => ManagerApprovalProvider()),
      ],
      child: Consumer<NavigationHandler>(
          builder: (BuildContext context, provider, Widget? child) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        return ScreenUtilInit(
            splitScreenMode: true,
              designSize: const Size(390, 844),
              minTextAdapt: true,
          builder: (context,child) {
            return MaterialApp(
              title: 'Beacon',
              debugShowCheckedModeBanner: false,
              theme: defaultLightTheme,
              home: isLoggedIn
                  ? IfElseBuilder(
                      condition: authProvider.bmsUserModel?.userTypeId == 1,
                      ifBuilder: (context) => const DashBoardScreen(),
                      elseBulider: (context) {
                        return IfElseBuilder(
                            condition: authProvider.bmsUserModel?.userTypeId == 4,
                            ifBuilder: (context) => const ManagerDashBoardScreen(),
                            elseBulider: (context) {
                              return EmptyDashBoard(
                                key: key,
                              );
                            });
                      })
                  : LoginScreen(
                      key: key,
                    ),
            );
          }
        );
      }),
    );
  }
}
