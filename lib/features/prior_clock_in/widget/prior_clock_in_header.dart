import 'package:flutter/material.dart';

class PriorClockInHeader extends StatelessWidget {
  final int index;
  const PriorClockInHeader({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      padding: const EdgeInsets.symmetric(vertical: 7.55),
      decoration: const BoxDecoration(
          color: Color(0xffD7ECFF),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      alignment: Alignment.center,
      child: index.isEven
          ? Column(
        children: const [
          Text(
            "2/10/2024 - 2/16/2024",
            style: TextStyle(
                color: Color(0xff373737),
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Adapt - Brooklyn IRA (Apt 6N)",
            style: TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "175 Willoughby St,Brooklyn,NY 11201",
            style: TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 13,
            ),
          ),
        ],
      )
          : const SizedBox.shrink(),
    );
  }
}
