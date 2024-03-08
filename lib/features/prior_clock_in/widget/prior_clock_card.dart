import 'package:flutter/material.dart';
class PriorClockInCard extends StatelessWidget {
  final int index;
  const PriorClockInCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
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
            ),
            const SizedBox(
              height: 6,
            ),
            richText('ScheduleDate: ', '2/10/2024'),
            buildDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                richText("Start Time: ", "08:00 AM"),
                const SizedBox(
                  width: 8,
                ),
                richText("End Time: ", "04:00 PM")
              ],
            ),
            buildDivider(),
            index == 0
                ? richText("No Meal Reason: ", "No relief given")
                : richText("Meal Time: ", "30 Min"),
            buildDivider(),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "Total Time: ",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  TextSpan(
                    text: "08:00 hrs",
                    style: TextStyle(fontSize: 15, color: Color(0xff2B2B2B)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Divider buildDivider() {
    return const Divider(
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


