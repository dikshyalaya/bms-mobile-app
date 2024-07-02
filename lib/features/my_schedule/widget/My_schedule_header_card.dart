import 'package:beacon_flutter/features/my_schedule/data/available_shift_for_dc_model.dart';
import 'package:flutter/material.dart';

class MyScheduleCardHeader extends StatelessWidget {
 final ScheduleCardModel scheduleCardModel;
  const MyScheduleCardHeader({Key? key, required this.scheduleCardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 7.55,horizontal: 19),
      decoration: const BoxDecoration(
          color: Color(0xffD7ECFF),
          boxShadow: [
            BoxShadow(
                color:  Color(0xff7A7A7A),
                blurRadius: 10.0,
                spreadRadius: 0 ,
                offset: Offset(0.0, 3)
            ),

          ],          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      alignment: Alignment.center,
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(scheduleCardModel.scheduleDate??"",style: const TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15,fontWeight: FontWeight.w500
          ),),
          Text("${scheduleCardModel.startTime} - ${scheduleCardModel.endTime}",style: const TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15,fontWeight: FontWeight.w500
          ),),

        ],
      ),

    );
  }
}
