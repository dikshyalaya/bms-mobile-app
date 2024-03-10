import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form.dart';
import 'package:beacon_flutter/utils/bottom_modal_sheet.dart';
import 'package:flutter/material.dart';
class ClockInDisplayCard extends StatelessWidget {
  const ClockInDisplayCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 78,
      width: double.infinity,
      child: Card(
        color: const Color(0xffFBFBFB),
        elevation: 4,
        shadowColor: const Color(0xff7A7A7A),
        surfaceTintColor: const Color(0xff7A7A7A),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, top: 17, bottom: 17, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Little Flower - Laurelton IRA ",
                    style: TextStyle(
                        color: Color(0xff5B5B5B),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Text(
                        "04/24/2024",
                        style: TextStyle(
                            color: Color(0xff5B5B5B),
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 19,
                      ),
                      Text(
                        "08:00 AM - 04:00 PM",
                        style: TextStyle(
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
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34)),
                  child: IconButton(
                    onPressed: () async{
                      BottomModalSheetUtils.onOpenBottomModalSheet(context, const ClockInForm());
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.navigate_next_sharp,
                      color: Color(0xff325CA1),
                      size: 34,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
