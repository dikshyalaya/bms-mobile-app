import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/looking_for_shift/widget/looking_for_shift_card.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';

class LookingForShiftHomeScreen extends StatelessWidget {
  const LookingForShiftHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BeaconAppBar(
        leadingIcon: const AppBarLeadingIcon(),
        action: [
          GestureDetector(
            onTap: (){
              DialogueUtils.selectSchedulePeriodDialogue(context: context);
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
                child: const Icon(Icons.calendar_month,color: Color(0xff04437F),),
              ),
            ),
          )
        ],
        title: "Looking For Shift",

      ),
      backgroundColor: Colors.blueAccent,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "Schedule Period: ",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  TextSpan(
                    text: "3/2/2024 - 3/8/2024 ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) =>  LookingForShiftCard(index: index,),
              padding: const EdgeInsets.symmetric(vertical: 18),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 9,
                  ),
              itemCount: 8),
        ],
      ),
    );
  }
}
