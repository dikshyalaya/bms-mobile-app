import 'package:beacon_flutter/common/widgets/builder/ifbuilder.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_grid.dart';
import 'package:beacon_flutter/features/dashboard/widget/dashboard_navigator-card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/beacon_app_bar.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: DashBoardGrid()),
              DashBoardNavigatorCard(),
            ],
          ),
        ),
      ),
    );
  }
}
