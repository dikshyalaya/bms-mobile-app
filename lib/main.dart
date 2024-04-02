import 'package:beacon_flutter/common/local_db/hive_model.dart';
import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:beacon_flutter/empty_dash_board.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/auth/domain/navigation_handler.dart';
import 'package:beacon_flutter/features/auth/widget/login_screen.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/features/looking_for_shift/domain/looking_for_shift_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/domain/manager_permission_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/widget/manager_dashboard_home.dart';
import 'package:beacon_flutter/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

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

void main() async {
  bool isLoggedIn = false;
  // await handleLocationPermission();
  await Hive.initFlutter();
  await BMSHiveModel.init();
  final accessToken = await BMSHiveModel.hive.get(BMSHiveModel.ACCESS_TOKEN);
  isLoggedIn = accessToken?.isNotEmpty ?? false;
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider()..getUserDetail()),
        ChangeNotifierProvider<ManagePermissionProvider>(
            create: (_) => ManagePermissionProvider()..getManagerPermission()),
        ChangeNotifierProxyProvider<AuthProvider, LookingForShiftProvider>(
            update: (_, authProvider, clockInProvide) {
              return LookingForShiftProvider(
                  authProvider.bmsUserModel?.empId ?? 0);
            },
            lazy: false,
            create: (_) => LookingForShiftProvider(0)..getAllSchedulePeriods()),
        ChangeNotifierProvider<NavigationHandler>(
            create: (_) => NavigationHandler()),
      ],
      child: Consumer<NavigationHandler>(
          builder: (BuildContext context, provider, Widget? child) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
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
      }),
    );
  }
}
