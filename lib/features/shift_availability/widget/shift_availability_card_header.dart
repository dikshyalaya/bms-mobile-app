import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/features/prior_clock_in/data/prior_cloc_in_response_model.dart';
import 'package:flutter/material.dart';

class ShiftAvailabilityCardHeader extends StatelessWidget {
  const ShiftAvailabilityCardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.09.h(context),
      padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 7.55),
      decoration: const BoxDecoration(
          color: Color(0xffD7ECFF),
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 15.0, offset: Offset(0.0, 0.75))
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "2/10/2024 - 2/16/2024",
            style: TextStyle(
                color: const Color(0xff373737),
                fontSize: 0.011.res(context),
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Adapt - Brooklyn IRA (Apt 6N)",
            style: TextStyle(
                color: const Color(0xff1B1B1B),
                fontSize: 0.013.res(context),
                fontWeight: FontWeight.bold),
          ),
          Text(
            "175 Willoughby St,Brooklyn,NY 11201",
            maxLines: 1,
            style: TextStyle(
              color: const Color(0xff1B1B1B),
              fontSize: 0.011.res(context),
            ),
          ),
        ],
      ),
    );
  }
}
