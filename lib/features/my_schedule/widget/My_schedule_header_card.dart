import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:flutter/material.dart';

class MyScheduleCardHeader extends StatelessWidget {
  const MyScheduleCardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.055.h(context),
      padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 19),
      decoration: const BoxDecoration(
          color: Color(0xffD7ECFF),
          boxShadow: [
            BoxShadow(
                color: Color(0xff7A7A7A),
                blurRadius: 10.0,
                spreadRadius: 0,
                offset: Offset(0.0, 3)),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "3/6/2024 - Wednesday",
            style: TextStyle(
                color: const Color(0xff1B1B1B),
                fontSize: 0.013.res(context),
                fontWeight: FontWeight.w500),
          ),
          Text(
            "11:30 PM - 09:30 AM",
            style: TextStyle(
                color: const Color(0xff1B1B1B),
                fontSize: 0.013.res(context),
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
