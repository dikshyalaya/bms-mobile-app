import 'package:beacon_flutter/features/clock_in_home/data/clock_in_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/domain/clock_in_provider.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/clock_in_form.dart';
import 'package:beacon_flutter/utils/bottom_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockInDisplayCard extends StatelessWidget {
  final ClockInResponse? clockInResponse;
  const ClockInDisplayCard({Key? key, this.clockInResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final clockInProvider =
            Provider.of<CLockInProvider>(context, listen: false);
        BottomModalSheetUtils.onOpenBottomModalSheet(
          context,
          ClockInForm(
            
            noMealResonList:
                clockInProvider.noMealReasonResponseModel?.data ?? [],
            clockInResponse: clockInResponse,
            cLockInProvider: clockInProvider,
          ),
        );
      },
      child: SizedBox(
        // height: 78,
        width: double.infinity,
        child: Card(
          color: const Color(0xffFBFBFB),
          elevation: 4,
          shadowColor: const Color(0xff7A7A7A),
          surfaceTintColor: const Color(0xff7A7A7A),
          margin: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 24, top: 17, bottom: 17, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${clockInResponse?.accountName}\n${clockInResponse?.houseName}",
                      style: const TextStyle(
                          color: Color(0xff5B5B5B),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          clockInResponse?.scheduleDate ?? '',
                          style: const TextStyle(
                              color: Color(0xff5B5B5B),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 19,
                        ),
                        Text(
                          "${clockInResponse?.startTime} - ${clockInResponse?.endTime}",
                          style: const TextStyle(
                              color: Color(0xff5B5B5B),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 34,
                  width: 34,
                  child: Card(
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.grey,
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(34)),
                      child: const Icon(
                        Icons.navigate_next_sharp,
                        color: Color(0xff325CA1),
                        size: 34,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
