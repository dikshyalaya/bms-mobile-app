import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/looking_for_shift/widget/looking_for_shift_card.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/scaffold_background_wrapper.dart';

class LookingForShiftHomeScreen extends StatelessWidget {
  const LookingForShiftHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackGroundWrapper(
      child: Scaffold(
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
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
          child: Column(
          
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
              const SizedBox(height: 18,),
              Expanded(
                child: ListView.separated(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>  LookingForShiftCard(index: index,),
                    padding: const EdgeInsets.only(bottom: 18),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 9,
                        ),
                    itemCount: 8),
              ),
               SizedBox(
                height: 74,
                child: Center(
                  child: Padding(padding: const EdgeInsetsDirectional.only(top: 10),child: SizedBox(
                    height: 40,
                    width: 163,
                    child: ElevatedButton(
                        onPressed: () {
                         DialogueUtils.successMessageDialogue(context: context, successMessage: "Availability Saved Successfully.");
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsetsDirectional.zero),
                            elevation: MaterialStateProperty.all(4),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff1870FF)),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))))),
                        child: Text(
                          "Save",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        )),
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
