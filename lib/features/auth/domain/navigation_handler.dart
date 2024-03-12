import 'package:beacon_flutter/common/local_db/hive_model.dart';
import 'package:flutter/cupertino.dart';

class NavigationHandler with ChangeNotifier {
  NavigationHandler(){
    Future.delayed(const Duration(milliseconds: 0),(){
      getInitialRoute();
    });

  }
  bool isLoggedIn = false;
  bool isAdmin = false;

  String navigationRouteName = "";

  getInitialRoute() async {
    await BMSHiveModel.init();
    final accessToken = await  BMSHiveModel.hive.get(BMSHiveModel.ACCESS_TOKEN);
    isLoggedIn = accessToken?.isNotEmpty ?? false;
    if (isLoggedIn) {
      navigationRouteName = navigationDashBoardRoute;
    }
    notifyListeners();
  }

}

 const String navigationDashBoardRoute = "/home_screen";
