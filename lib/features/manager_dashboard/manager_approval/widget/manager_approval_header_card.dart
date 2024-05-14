import 'package:flutter/material.dart';

class ManagerApprovalHeaderCard extends StatelessWidget {
  final String title;
  final String hasDispute;
  final String startTime;
  final String endTime;
  const ManagerApprovalHeaderCard({
    Key? key,
    required this.title,
    this.hasDispute = '',
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 19),
      decoration: BoxDecoration(
        color: hasDispute.toLowerCase() == 'yes'
            ? const Color(0xFFFDF3BE)
            : const Color(0xffD7ECFF),
        // color: ,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "$startTime - $endTime",
            style: const TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
