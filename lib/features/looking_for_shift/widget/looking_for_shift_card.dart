import 'package:flutter/material.dart';
class LookingForShiftCard extends StatelessWidget {
  const LookingForShiftCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 126,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children:  [LookingForShiftCardHeader()],
        ),
      ),
    );
  }
}
