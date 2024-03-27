import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/shift_availability/widget/shift_availabilty_card.dart';
import 'package:beacon_flutter/features/shift_availability/widget/toggle_bar.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';

class ShiftAvailabilityHome extends StatelessWidget {
  const ShiftAvailabilityHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScaffoldBackGroundWrapper(
        appBar: const BeaconAppBar(
          title: "Shift Availablity",
          leadingIcon: AppBarLeadingIcon(),

        ),
        child: Scaffold(
      backgroundColor: Colors.transparent,

      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Sort By",style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                  ),),SizedBox(width: 22,),
                  ToggleBar()
                ],
              ),
            ),

            Expanded(child: ListView.separated(itemBuilder: (context,index)=>const ShiftAvailabilityCard(), separatorBuilder: (context,index)=>const SizedBox(height: 9,), itemCount: 8)),
             SizedBox(height: 81,child: Center(

              child:  SizedBox(
                height: 40,
                width: 163.47,
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
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),)
          ],
        ),
      ),
    ));
  }
}
