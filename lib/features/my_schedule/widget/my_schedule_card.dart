import 'package:beacon_flutter/common/extension/extension.dart';
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
          SizedBox(height: 0.012.h(context)),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Adapt - Brooklyn IRA (Apt 6N)",
                  style: TextStyle(
                      color: const Color(0xff1B1B1B),
                      fontSize: 0.0115.res(context),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 0.008.h(context)),
                Text(
                  "175 Willoughby St,Brooklyn,NY 11201",
                  style: TextStyle(
                      color: const Color(0xff1B1B1B),
                      fontSize: 0.0115.res(context),
                      fontWeight: FontWeight.w400),
                ),
                buildDivider(),
                SizedBox(height: 0.005.h(context))
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 0.043.h(context),
              width: 0.3.w(context),
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
                          fontSize: 0.013.res(context),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  )),
            ),
          ),
          SizedBox(height: 0.009.h(context)),
        ],
      ),
    );
  }
}
