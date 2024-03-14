import 'package:beacon_flutter/features/looking_for_shift/data/look_for_shift_response_model.dart';
import 'package:flutter/material.dart';

class LookingForShiftCardHeader extends StatelessWidget {
  final LookForShiftModel? lookForShiftModel;

  const LookingForShiftCardHeader({Key? key,this.lookForShiftModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 7.55,horizontal: 19),
        decoration: const BoxDecoration(
            color: Color(0xffD7ECFF),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        alignment: Alignment.center,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(lookForShiftModel?.scheduleDate??"",style: const TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15,fontWeight: FontWeight.w500
            ),),
            Text("${lookForShiftModel?.startTime??""} - ${lookForShiftModel?.endTime}",style: const TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15,fontWeight: FontWeight.w500
            ),),

          ],
        ),

    );
  }
}
