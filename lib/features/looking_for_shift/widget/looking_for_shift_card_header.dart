import 'package:beacon_flutter/features/looking_for_shift/data/look_for_shift_response_model.dart';
import 'package:flutter/material.dart';

class LookingForShiftCardHeader extends StatelessWidget {
  final LookForShiftModel? lookForShiftModel;

  const LookingForShiftCardHeader({Key? key, this.lookForShiftModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53,
      padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 19),
      decoration: const BoxDecoration(
          color: Color(0xffD7ECFF),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Text(
              "${lookForShiftModel?.accountName} - ${lookForShiftModel?.houseName}",
              style: const TextStyle(
                  color: Color(0xff1B1B1B),
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Text(
              lookForShiftModel?.houseAddress ?? "",
              style: const TextStyle(
                  color: Color(0xff1B1B1B),
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
