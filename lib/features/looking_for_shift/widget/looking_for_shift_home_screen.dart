import 'package:flutter/material.dart';

class LookingForShiftHomeScreen extends StatelessWidget {
  const LookingForShiftHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blueAccent,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "Schedule Period: ",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  TextSpan(
                    text: "3/2/2024 - 3/8/2024 ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => const LookingForShiftCard(),
              padding: const EdgeInsets.symmetric(vertical: 18),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 9,
                  ),
              itemCount: 8),
        ],
      ),
    );
  }
}
