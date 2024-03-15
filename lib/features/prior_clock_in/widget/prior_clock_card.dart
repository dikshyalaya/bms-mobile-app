import 'package:beacon_flutter/features/prior_clock_in/data/prior_cloc_in_response_model.dart';
import 'package:beacon_flutter/features/prior_clock_in/widget/prior_clock_in_header.dart';
import 'package:flutter/material.dart';
class PriorClockInCard extends StatelessWidget {
  final int index;
  final PriorClockInModel? priorClockInModel;
  const PriorClockInCard({Key? key, required this.index,required this.priorClockInModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      width: double.infinity,
      child: Card(
        color: const Color(0xffFBFBFB),
        elevation: 4,
        shadowColor: const Color(0xff7A7A7A),
        surfaceTintColor: const Color(0xff7A7A7A),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            PriorClockInHeader(
              index: index,
              priorClockInModel: priorClockInModel,
            ),
            const SizedBox(
              height: 6,
            ),
            richText('ScheduleDate: ', priorClockInModel?.scheduleDate??''),
            buildDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                richText("Start Time: ", priorClockInModel?.startTime??''),
                const SizedBox(
                  width: 8,
                ),
                richText("End Time: ", priorClockInModel?.endTime??'')
              ],
            ),
            buildDivider(),
            (priorClockInModel?.noBreakReason.isNotEmpty??false)?
             richText("No Meal Reason: ",priorClockInModel?.noBreakReason??'')
                : richText("Meal Time: ", "${priorClockInModel?.lunchTime??''} Min"),
            buildDivider(),
             Container(
               alignment: Alignment.center,
               decoration: const BoxDecoration(
                 color: Color(0xffF2F2F2),
                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
               ),

               child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                        text: "Total Time: ",
                        style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500)),
                    TextSpan(
                      text: (priorClockInModel?.totalTime.toString())??"",
                      style: const TextStyle(fontSize: 15, color: Color(0xff2B2B2B)),
                    ),
                  ],
                ),
                           ),
             ),
            const SizedBox(height: 6.55,)
          ],
        ),
      ),
    );
  }

  Divider buildDivider() {
    return const Divider(
      thickness: 0.25,
      color: Color(0xffB5B5B5),
    );
  }

  Widget richText(String key, String val) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: key,
              style: const TextStyle(color: Color(0xff8A8181), fontSize: 15)),
          TextSpan(
            text: val,
            style: const TextStyle(fontSize: 15, color: Color(0xff2B2B2B)),
          ),
        ],
      ),
    );
  }
}


