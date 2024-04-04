import 'package:flutter/material.dart';

import 'shift_availability_card_header.dart';

class ShiftAvailabilityCard extends StatefulWidget {
  const ShiftAvailabilityCard({Key? key}) : super(key: key);

  @override
  State<ShiftAvailabilityCard> createState() => _ShiftAvailabilityCardState();
}

class _ShiftAvailabilityCardState extends State<ShiftAvailabilityCard> {
  bool isTrue = false;

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
          const ShiftAvailabilityCardHeader(),
          const SizedBox(
            height: 6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsetsDirectional.only(start: 57),
                  child: richText('Shift Date: : ', '2/10/2024')),
              buildDivider(),
              Padding(
                  padding: const EdgeInsetsDirectional.only(start: 57),
                  child: richText("Shift Time: ", '08:00 AM - 04:00 PM ')),
              buildDivider(),
              Padding(
                  padding: const EdgeInsetsDirectional.only(start: 57),
                  child: richText("Shift Date:  ", "2/10/2024")),
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
                            }),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Yes",
                      style: TextStyle(color: Color(0xff324054), fontSize: 12),
                    )
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
