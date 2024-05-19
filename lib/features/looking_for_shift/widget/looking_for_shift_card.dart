import 'package:beacon_flutter/features/looking_for_shift/data/look_for_shift_response_model.dart';
import 'package:beacon_flutter/features/looking_for_shift/widget/looking_for_shift_card_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LookingForShiftCard extends StatefulWidget {
  final int index;
  final LookForShiftModel? lookForShiftModel;
  final Function(bool, int) onSwitchEnabled;

  const LookingForShiftCard(
      {Key? key,
      required this.index,
      this.lookForShiftModel,
      required this.onSwitchEnabled})
      : super(key: key);

  @override
  State<LookingForShiftCard> createState() => _LookingForShiftCardState();
}

class _LookingForShiftCardState extends State<LookingForShiftCard> {
  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 150,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            LookingForShiftCardHeader(
              lookForShiftModel: widget.lookForShiftModel,
            ),
            const SizedBox(height: 11),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
              child: Text(
                "Scheduled Date: ${widget.lookForShiftModel?.scheduleDate ?? ""}",
                style: const TextStyle(
                    color: Color(0xff1B1B1B),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
              child: Text(
                "Shift Time: ${widget.lookForShiftModel?.startTime ?? ""} - ${widget.lookForShiftModel?.endTime}",
                style: const TextStyle(
                    color: Color(0xff1B1B1B),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            // Text(lookForShiftModel?.scheduleDate??"",style: const TextStyle(
            //   color: Color(0xff1B1B1B),
            //   fontSize: 15,fontWeight: FontWeight.w500
            // ),),
            // Text("${lookForShiftModel?.startTime??""} - ${lookForShiftModel?.endTime}",style: const TextStyle(
            //   color: Color(0xff1B1B1B),
            //   fontSize: 15,fontWeight: FontWeight.w500
            // ),),
            // Text(
            //   "${widget.lookForShiftModel?.startTime ?? ""} - ${widget.lookForShiftModel?.endTime}",
            //   style: const TextStyle(
            //       color: Color(0xff1B1B1B),
            //       fontSize: 15,
            //       fontWeight: FontWeight.w500),
            // ),
            // Padding(
            //   padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            //   child: Text(
            //     "${widget.lookForShiftModel?.accountName} - ${widget.lookForShiftModel?.houseName}",
            //     style: const TextStyle(
            //         color: Color(0xff1B1B1B),
            //         fontWeight: FontWeight.w500,
            //         fontSize: 13),
            //     maxLines: 1,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            //   child: Text(
            //     widget.lookForShiftModel?.houseAddress ?? "",
            //     style: const TextStyle(
            //         color: Color(0xff1B1B1B),
            //         fontWeight: FontWeight.w400,
            //         fontSize: 13),
            //     maxLines: 1,
            //   ),
            // ),
            const Divider(
              color: Color.fromARGB(255, 214, 214, 214),
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 19.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Available?",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 25,
                        child: FittedBox(
                          child: Switch(
                              activeColor: Colors.blue,
                              key: UniqueKey(),
                              value: isTrue,
                              onChanged: (bool val) {
                                setState(() {
                                  isTrue = val;
                                });
                                widget.onSwitchEnabled(
                                    val, widget.lookForShiftModel?.id ?? -1);
                              }),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        "Yes",
                        style:
                            TextStyle(color: Color(0xff324054), fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 6.h,
            )
          ],
        ),
      ),
    );
  }
}
