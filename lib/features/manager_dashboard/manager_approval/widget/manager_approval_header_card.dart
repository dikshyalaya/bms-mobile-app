import 'package:flutter/material.dart';

class ManagerApprovalHeaderCard extends StatelessWidget {
  const ManagerApprovalHeaderCard({Key? key}) : super(key: key);

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
      child: const Text(
        "Nakeem Berry",
        style: TextStyle(
          color: Color(0xff1B1B1B),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
