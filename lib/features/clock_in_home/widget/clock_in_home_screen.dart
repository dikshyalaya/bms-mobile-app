
import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_display_card.dart';
import 'package:flutter/material.dart';

class ClockInHomeScreen extends StatelessWidget {
  const ClockInHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackGroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: BeaconAppBar(
          leadingIcon: const AppBarLeadingIcon(),
          title: "Clock-In".toUpperCase(),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => const ClockInDisplayCard(),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 29),
            separatorBuilder: (context, index) => const SizedBox(
              height: 3,
            ),
            itemCount: 5),
      ),
    );
  }
}

class AppBarLeadingIcon extends StatelessWidget {
  const AppBarLeadingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Navigator.pop(context);

      },
      child: SizedBox(
        height: 34,
        width: 34,
        child: Card(color: Colors.white,
            margin: const EdgeInsets.only(left: 20,bottom: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(34)
            ),
            child: const Icon(Icons.navigate_before,color: Color(0xff325CA1),)),
      ),
    );
  }
}