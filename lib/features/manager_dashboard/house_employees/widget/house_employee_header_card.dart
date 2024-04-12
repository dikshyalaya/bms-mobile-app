import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:flutter/material.dart';

class HouseEmployeeHeaderCard extends StatelessWidget {
  const HouseEmployeeHeaderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 19),
      decoration: const BoxDecoration(
        color: Color(0xffD7ECFF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          const Text(
            "Name:",
            style: TextStyle(
              color: Color(0xff8A8181),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            "Sandip Patel",
            style: TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Container(
            height: 26,
            width: 26,
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset('edit'.iconImage()),
          )
        ],
      ),
    );
  }
}
