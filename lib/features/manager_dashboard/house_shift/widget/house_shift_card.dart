import 'package:beacon_flutter/features/manager_dashboard/house_shift/widget/house_shift_header_card.dart';
import 'package:flutter/material.dart';

class HouseShiftCard extends StatefulWidget {
  const HouseShiftCard({Key? key}) : super(key: key);

  @override
  State<HouseShiftCard> createState() => _HouseShiftCardState();
}

class _HouseShiftCardState extends State<HouseShiftCard> {
  bool isTrue = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HouseShiftHeaderCard(),
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
                      "Date:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Shift:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "3/16/2024",
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
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 24,
            padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 19),
            decoration: const BoxDecoration(
              color: Color(0xffF2F2F2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
