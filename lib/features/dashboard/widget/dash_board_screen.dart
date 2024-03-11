import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/dashboard/widget/dash_board_grid.dart';
import 'package:beacon_flutter/features/dashboard/widget/dashboard_navigator-card.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/beacon_app_bar.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldBackGroundWrapper(

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 68),
            child: BeaconAppBar(
              title: "Hey, Beacon App",
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Expanded(child: DashBoardGrid()),
            DashBoardNavigatorCard(),
          ],
        ),
      ),
    );
  }
}
