import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/widget/manage_shift_header_card.dart';
import 'package:flutter/material.dart';

class ManageShiftCard extends StatefulWidget {
  const ManageShiftCard({Key? key}) : super(key: key);

  @override
  State<ManageShiftCard> createState() => _ManageShiftCardState();
}

class _ManageShiftCardState extends State<ManageShiftCard> {
  bool isTrue = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ManageShiftHeaderCard(),
          const SizedBox(
            height: 11,
          ),
          const Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DSP:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Date:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Shift Time:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Status:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nakeem Berry",
                      style: TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "2/10/2024",
                      style: TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "08:00 AM - 04:00 PM",
                      style: TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Open",
                      style: TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 19),
            decoration: const BoxDecoration(
              color: Color(0xffF2F2F2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                      "Cancel",
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
}
