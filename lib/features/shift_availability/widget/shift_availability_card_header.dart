import 'package:beacon_flutter/features/my_schedule/data/available_shift_for_dc_model.dart';
import 'package:flutter/material.dart';

class ShiftAvailabilityCardHeader extends StatelessWidget {
  final ScheduleCardModel scheduleCardModel;

  const ShiftAvailabilityCardHeader({Key? key, required this.scheduleCardModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 7.55),
      decoration: const BoxDecoration(
          color: Color(0xffD7ECFF),
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 15.0, offset: Offset(0.0, 0.75))
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${scheduleCardModel.schedulePeriod}",
              style: const TextStyle(
                  color: Color(0xff373737),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${scheduleCardModel.accountName ?? ''} ${scheduleCardModel.houseName}",
              style: const TextStyle(
                  color: Color(0xff1B1B1B),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            // SizedBox(
            //   height: 3,
            // ),
            Text(
              scheduleCardModel.houseAddress ?? '',
              maxLines: 1,
              style: const TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
