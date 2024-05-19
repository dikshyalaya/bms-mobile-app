import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TooEarlyWidget extends StatelessWidget {
  const TooEarlyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Icon(
            Icons.lock_clock_rounded,
            size: 33.sp,
            color: Colors.orange[900],
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'You are Too Early',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.orange[900]),
          ),
        ],
      ),
    );
  }
}
