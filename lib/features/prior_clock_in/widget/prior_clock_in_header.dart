import 'package:beacon_flutter/features/prior_clock_in/data/prior_cloc_in_response_model.dart';
import 'package:flutter/material.dart';

class PriorClockInHeader extends StatelessWidget {
  final int index;
  final PriorClockInModel? priorClockInModel;

  const PriorClockInHeader({Key? key, required this.index, this.priorClockInModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(vertical: 7.55),
      decoration: const BoxDecoration(
          color: Color(0xffD7ECFF),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      alignment: Alignment.center,
      child:  Column(
        children: [
          Text(
            priorClockInModel?.schedulePeriod??'',
            style: TextStyle(
                color: Color(0xff373737),
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "${priorClockInModel?.accountName??""} - ${priorClockInModel?.houseName??''}",
            style: TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          // SizedBox(
          //   height: 3,
          // ),
          Text(
              priorClockInModel?.houseAddress??'house address, null',
            style: TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 13,
            ),
          ),
        ],
      )
         ,
    );
  }
}
