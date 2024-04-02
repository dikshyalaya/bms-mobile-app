import 'package:beacon_flutter/common/extension/extension.dart';
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
          SizedBox(height: 0.01.h(context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsetsDirectional.only(start: 57),
                  child: richText('Shift Date:  ', '2/10/2024')),
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
          SizedBox(
            height: 0.01.h(context),
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
                Text(
                  "Available?",
                  style: TextStyle(
                    fontSize: 0.013.res(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 0.038.h(context),
                      height: 0.038.h(context),
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
                    SizedBox(
                      width: 0.02.w(context),
                    ),
                    Text(
                      "Yes",
                      style: TextStyle(
                        color: const Color(0xff324054),
                        fontSize: 0.01.res(context),
                      ),
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
            style: TextStyle(
              color: const Color(0xff8A8181),
              fontSize: 0.013.res(context),
            ),
          ),
          TextSpan(
            text: val,
            style: TextStyle(
              fontSize: 0.013.res(context),
              color: const Color(0xff2B2B2B),
            ),
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
