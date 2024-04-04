import 'package:beacon_flutter/features/prior_clock_in/widget/prior_clock_card.dart';
import 'package:flutter/material.dart';

import 'my_schedule_header_card.dart';

class MySchedulecard extends StatelessWidget {
  const MySchedulecard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyScheduleCardHeader(),
          const SizedBox(
            height: 11,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Adapt - Brooklyn IRA (Apt 6N)",
                  style: TextStyle(
                      color: Color(0xff1B1B1B),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "175 Willoughby St,Brooklyn,NY 11201",
                  style: TextStyle(
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
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                    "Cancel Shilft",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
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
