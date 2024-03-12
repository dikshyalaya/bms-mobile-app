import 'package:beacon_flutter/common/local_db/hive_model.dart';
import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/auth/domain/navigation_handler.dart';
import 'package:beacon_flutter/features/auth/widget/login_screen.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await BMSHiveModel.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()..getUserDetail()),
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
              home: provider.navigationRouteName ==
                  navigationDashBoardRoute
                  ? const DashBoardScreen()
                  : LoginScreen(
                key: key,
              ),

            );
          }),


    );
  }
}
