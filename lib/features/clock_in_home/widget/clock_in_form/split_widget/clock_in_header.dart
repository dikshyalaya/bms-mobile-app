import 'package:beacon_flutter/features/clock_in_home/data/clock_in_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockInHeader extends StatelessWidget {
  final ClockInResponse? clockInResponse;

  const ClockInHeader({Key? key, this.clockInResponse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0.9,
            blurRadius: 12.r,
          )
        ],
        color: const Color(0xffD9D9D9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${clockInResponse?.accountName} \n${clockInResponse?.houseName}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "${clockInResponse?.scheduleDate ?? ''}     ${clockInResponse?.startTime} - ${clockInResponse?.endTime}",
            style: TextStyle(
              color: const Color(0xff5B5B5B),
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}