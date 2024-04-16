import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:beacon_flutter/features/my_schedule/data/AvailableShiftsForDCModel.dart';
import 'package:beacon_flutter/features/my_schedule/domain/AvailableShiftProvider.dart';
import 'package:beacon_flutter/features/prior_clock_in/widget/prior_clock_card.dart';
import 'package:flutter/material.dart';


import 'package:beacon_flutter/features/my_schedule/widget/My_schedule_header_card.dart';
import 'package:provider/provider.dart';

class MySchedulecard extends StatelessWidget {
  final ScheduleCardModel scheduleCardModel;
  final int index;
  const MySchedulecard({Key? key,required this.scheduleCardModel,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableShiftProvider = Provider.of<AvailableShiftProvider>(context,listen: true);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyScheduleCardHeader(scheduleCardModel:scheduleCardModel),
          const SizedBox(
            height: 11,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  scheduleCardModel.accountName??'',
                  style: const TextStyle(
                      color: Color(0xff1B1B1B),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 6,
                ),
                 Text(
                  "${scheduleCardModel.houseName},${scheduleCardModel.houseAddress}",
                  style: const TextStyle(
                      color: Color(0xff1B1B1B),
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
                buildDivider(),
                const SizedBox(
                  height: 2,
                )
              ],
            ),
          ),
          Align(

            alignment: Alignment.center,
            child: SizedBox(
              height: 30.7,
              width: 125.47,
              child: IfElseBuilder(
                condition: availableShiftProvider.isDataPosting&&index==availableShiftProvider.selectedIndex,
                ifBuilder:(context)=>const Center(child:  CircularProgressIndicator()) ,
                elseBulider: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        availableShiftProvider.selectedIndex = availableShiftProvider.availableShiftsForDcModel.data!.indexOf(scheduleCardModel);
                       availableShiftProvider.cancelShift(scheduleCardModel.id??-1);
                      },
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(EdgeInsetsDirectional.zero),
                          elevation: MaterialStateProperty.all(4),
                          backgroundColor:
                              MaterialStateProperty.all(const Color(0xff3B85FF)),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))))),
                      child: Text(
                        "Cancel Shift",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ));
                }
              ),
            ),
          ),
          const SizedBox(
            height: 7.3,
          ),
        ],
      ),
    );
  }
}
