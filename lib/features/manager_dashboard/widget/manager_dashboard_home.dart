import 'package:beacon_flutter/common/widgets/builder/ifbuilder.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/domain/manager_permission_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/widget/manager_dashboard_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/beacon_app_bar.dart';

class ManagerDashBoardScreen extends StatelessWidget {
  const ManagerDashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false)
      ..getUserDetail();
    return ScaffoldBackGroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 68),
            child: Selector<AuthProvider, BmsUserModel?>(
              selector: (context, provider) => provider.bmsUserModel,
              builder: (context, bmsUserModel, child) => BeaconAppBar(
                title:
                "${bmsUserModel?.empFirstName} ${bmsUserModel?.empLastName}",
              ),
            )),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF174CD6), // Top part color
                Color(0xFF98BBFF), // Bottom part color
              ],
            ),
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Selector<ManagePermissionProvider, bool?>(
              selector: (context, provider) => provider.isManagerPermitted,
          builder: (context, isManagerPermitted, child) => IfBuilder(
            condition: isManagerPermitted??false,
            builder: (context) {
              return const Expanded(child: ManagerDashBoardGrid());
            }
          ),
        )

              // DashBoardNavigatorCard(),
            ],
          ),
        ),
      ),
    );
  }
}
