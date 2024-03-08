
import 'package:flutter/material.dart';

class ClockInHomeScreen extends StatelessWidget {
  const ClockInHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blueAccent,
      body: ListView.separated(
          itemBuilder: (context, index) => const ClockInDisplayCard(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 29),
          separatorBuilder: (context, index) => const SizedBox(
            height: 3,
          ),
          itemCount: 5),
    );
  }
}