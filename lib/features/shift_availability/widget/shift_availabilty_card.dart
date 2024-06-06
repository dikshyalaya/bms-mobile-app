import 'package:beacon_flutter/features/my_schedule/data/available_shifts_for_dc_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'shift_availability_card_header.dart';

class ShiftAvailabilityCard extends StatefulWidget {
  final ScheduleCardModel scheduleCardModel;
  final Function(bool, int) onCardAvailable;
  const ShiftAvailabilityCard(
      {Key? key,
      required this.scheduleCardModel,
      required this.onCardAvailable})
      : super(key: key);

  @override
  State<ShiftAvailabilityCard> createState() => _ShiftAvailabilityCardState();
}

class _ShiftAvailabilityCardState extends State<ShiftAvailabilityCard> {
  bool isTrue = false;
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color(0xff7A7A7A),
                blurRadius: 2.0,
                spreadRadius: 0,
                offset: Offset(0.0, 3)),
          ],
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ShiftAvailabilityCardHeader(
            scheduleCardModel: widget.scheduleCardModel,
          ),
          const SizedBox(
            height: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsetsDirectional.only(start: 57),
                  child: richText('Shift Date: : ',
                      widget.scheduleCardModel.scheduleDate ?? '')),
              buildDivider(),
              Padding(
                  padding: const EdgeInsetsDirectional.only(start: 57),
                  child: richText("Shift Time: ",
                      '${widget.scheduleCardModel.startTime ?? ''} - ${widget.scheduleCardModel.endTime ?? ''} ')),
              buildDivider(),
              Padding(
                  padding: const EdgeInsetsDirectional.only(start: 57),
                  child: richText("Shift Day:  ",
                      "${getDaysName(widget.scheduleCardModel.startDateTime ?? '', widget.scheduleCardModel.endDateTime ?? '')}")),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          buildDivider(height: 0, indent: 0),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsetsDirectional.only(
                bottom: 6.55, top: 8, start: 19, end: 19),
            decoration: const BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
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
                    Radio(
                        value: 1,
                        groupValue: value,
                        activeColor: Colors.blue,
                        // fillColor: MaterialStateProperty.all(Colors.blue),
                        onChanged: (int? val) {
                          setState(() {
                            value = val ?? 0;
                            widget.onCardAvailable.call(
                                val == 1, widget.scheduleCardModel.id ?? -0);
                          });
                        }),
                    const Text(
                      "Yes",
                      style: TextStyle(color: Color(0xff324054), fontSize: 12),
                    ),
                    const SizedBox(width: 3),
                    Radio(
                        value: 2,
                        groupValue: value,
                        activeColor: Colors.blue,
                        // fillColor: MaterialStateProperty.all(Colors.blue),
                        onChanged: (int? val) {
                          setState(() {
                            value = val ?? 0;
                            widget.onCardAvailable.call(
                                val == 2, widget.scheduleCardModel.id ?? -0);
                          });
                        }),
                    const Text(
                      "No",
                      style: TextStyle(color: Color(0xff324054), fontSize: 12),
                    )
                    // SizedBox(
                    //   width: 30,
                    //   height: 25,
                    //   child: FittedBox(
                    //     child: Switch(
                    //         activeColor: Colors.blue,
                    //         key: UniqueKey(),
                    //         value: isTrue,
                    //         onChanged: (bool val) {
                    //           setState(() {
                    //             isTrue = val;
                    //             widget.onCardAvailable.call(
                    //                 val, widget.scheduleCardModel.id ?? -0);
                    //           });
                    //         }),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 8,
                    // ),
                    // const Text(
                    //   "Yes",
                    //   style: TextStyle(color: Color(0xff324054), fontSize: 12),
                    // )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
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

Divider buildDivider({double? height, double? indent}) {
  return Divider(
    thickness: 0.25,
    height: height,
    indent: indent,
    color: const Color(0xffB5B5B5),
  );
}

getDaysName(String startDate, String endDate) {
  DateTime start = DateTime.parse(startDate);
  DateTime end = DateTime.parse(endDate);
  String startDay = DateFormat('EEEE').format(start);
  String endDay = DateFormat('EEEE').format(end);
  return startDay == endDay
      ? startDay
      : '${startDay.substring(0, 3)} - ${endDay.substring(0, 3)}';
}
