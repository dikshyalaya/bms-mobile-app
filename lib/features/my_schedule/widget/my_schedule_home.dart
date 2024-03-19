import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/my_schedule/widget/my_schedule_card.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';

class MyScheduleHomeScreen extends StatelessWidget {
  const MyScheduleHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScaffoldBackGroundWrapper(child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: BeaconAppBar(
        title: "My Schedule",
        action: [
          GestureDetector(
          onTap: () async {

     DialogueUtils.onPressedMyScheduleDialogue(context: context);
          },
          child: SizedBox(
            height: 34,
            width: 34,
            child: Card(
              margin:  EdgeInsets.zero,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34)
              ),
              child: const Icon(Icons.add,color: Color(0xff325CA1),),
            ),
          ),
        )],
        leadingIcon: const AppBarLeadingIcon(),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12,vertical: 22),
        child: ListView.builder(itemBuilder: (context,index)=>const MySchedulecard(),itemCount: 14,),
      ),
    ));
  }
}
