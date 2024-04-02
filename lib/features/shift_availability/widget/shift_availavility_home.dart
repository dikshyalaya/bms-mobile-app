import 'package:beacon_flutter/common/extension/extension.dart';
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
    return ScaffoldBackGroundWrapper(
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
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Sort By",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 0.011.res(context),
                        ),
                      ),
                      SizedBox(width: 0.13.w(context)),
                      const ToggleBar()
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        const ShiftAvailabilityCard(),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 0.01.h(context),
                    ),
                    itemCount: 8,
                  ),
                ),
                SizedBox(
                  height: 0.095.h(context),
                  child: Center(
                    child: SizedBox(
                      height: 0.05.h(context),
                      width: 0.45.w(context),
                      child: ElevatedButton(
                          onPressed: () {
                            DialogueUtils.successMessageDialogue(
                                context: context,
                                successMessage:
                                    "Availability Saved Successfully.");
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
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 0.013.res(context),
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
