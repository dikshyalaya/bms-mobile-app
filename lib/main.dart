import 'package:beacon_flutter/common/local_db/hive_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/auth/domain/navigation_handler.dart';
import 'package:beacon_flutter/features/auth/widget/login_screen.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/features/looking_for_shift/domain/looking_for_shift_provider.dart';
import 'package:beacon_flutter/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async{
  bool isLoggedIn=false;
  await Hive.initFlutter();
  await BMSHiveModel.init();
  final accessToken = await  BMSHiveModel.hive.get(BMSHiveModel.ACCESS_TOKEN);
  isLoggedIn = accessToken?.isNotEmpty ?? false;
  runApp( MyApp(isLoggedIn: isLoggedIn,));
 WidgetsFlutterBinding.ensureInitialized();

}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({key,required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {

    // FlutterNativeSplash.remove();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()..getUserDetail()),
    ChangeNotifierProxyProvider<AuthProvider,
        LookingForShiftProvider>(
    update: (_, authProvider, clockInProvide) {
    return LookingForShiftProvider(authProvider.bmsUserModel?.empId??0);
    },
    lazy: false,
    create: (_) => LookingForShiftProvider(
    0
    )..getAllSchedulePeriods()),
        ChangeNotifierProvider<NavigationHandler>(
            create: (_) => NavigationHandler()),


      ],
      child:
      Consumer<NavigationHandler>(
          builder: (BuildContext context, provider, Widget? child) {
            return MaterialApp(
              title: 'Beacon',
              debugShowCheckedModeBanner: false,
              theme: defaultLightTheme,
              home:isLoggedIn
                  ? const DashBoardScreen()
                  : LoginScreen(
                key: key,
              ),

            );
          }),


    );
  }
}
