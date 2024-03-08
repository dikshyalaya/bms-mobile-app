import 'package:flutter/material.dart';

class PriorClockInHomeScreen extends StatelessWidget {
  const PriorClockInHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.blueAccent,
      body: ListView.separated(
          itemBuilder: (context, index) => PriorClockInCard(
            index: index,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 29),
          separatorBuilder: (context, index) => const SizedBox(
            height: 9,
          ),
          itemCount: 8),
    );
  }
}
