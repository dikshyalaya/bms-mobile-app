import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:flutter/material.dart';

import '../../clock_in_home/widget/clock_in_home_screen.dart';
import 'prior_clock_card.dart';

class PriorClockInHomeScreen extends StatelessWidget {
  const PriorClockInHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackGroundWrapper(
      child: Scaffold(

        appBar:const BeaconAppBar(
          leadingIcon: AppBarLeadingIcon(),
          title: "Prior Clock-In",
        ),
        backgroundColor: Colors.transparent,
        body: ListView.separated(
            itemBuilder: (context, index) => PriorClockInCard(
              index: index,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 29),
            separatorBuilder: (context, index) => const SizedBox(
              height: 9,
            ),
            itemCount: 8),
      ),
    );
  }
}
