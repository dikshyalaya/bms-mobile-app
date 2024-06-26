import 'dart:async';

import 'package:beacon_flutter/common/local_db/hive_model.dart';
import 'package:beacon_flutter/empty_dash_board.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_screen.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/home/widget/manager_dashboard_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _time = 2;
  late Timer _timer;
  bool? isLoggedIn;

  @override
  void initState() {
    getAccessToken();
    _timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      setState(() {
        _time -= 1;
      });
      if (_time == 0) {
        navigation();
      }
    });
    super.initState();
  }

  getAccessToken() async {
    final accessToken = await BMSHiveModel.hive.get(BMSHiveModel.ACCESS_TOKEN);
    isLoggedIn = accessToken?.isNotEmpty ?? false;
  }

  navigation() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    isLoggedIn == true
        ? authProvider.bmsUserModel?.userTypeId == 1
            ? routeNavigation(const DashBoardScreen())
            : authProvider.bmsUserModel?.userTypeId == 4
                ? routeNavigation(const ManagerDashBoardScreen())
                : routeNavigation(const EmptyDashBoard())
        : routeNavigation(const LoginScreen());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff003792),
              Color(0xff3E65A5),
            ],
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/app-logo.png',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 20),
                Text(
                  'Beacon Management System',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Version: 1.0.0',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Powered by Software for Moving, Inc',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  routeNavigation(Widget page) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }
}
