import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TooEarlyWidget extends StatelessWidget {
  const TooEarlyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: const Column(
        children: [
          Icon(Icons.abc),
          Text('You are Too Early'),
        ],
      ),
    );
  }
}
