// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    Key? key,
    this.bdRadius,
    this.elevation,
    this.bgColor,
    this.widgetIcon,
    this.text1,
    this.ftSize,
    this.txtColor,
    this.onPressed,
    this.isLoadingPart,
    this.borderColor,
    this.gradient, // New property for gradient
  }) : super(key: key);

  final double? bdRadius;
  final double? elevation;
  final Color? bgColor;
  final String? text1;
  final double? ftSize;
  final Color? txtColor;
  final Color? borderColor;
  final Function()? onPressed;
  final Widget? widgetIcon;
  bool? isLoadingPart;
  final Gradient? gradient; // New property for gradient

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(bdRadius ?? 2.r),
        ),
        padding: EdgeInsets.all(12.r), // Adjust padding as needed
        child: Center(
          child: (isLoadingPart == true)
              ? Padding(
                  padding: EdgeInsets.only(left: 100.w),
                  child: Row(
                    children: [
                      Text('Loading',
                          style: TextStyle(
                              fontSize: ftSize ?? 12.sp,
                              color: txtColor ?? Colors.white)),
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: const CircularProgressIndicator(),
                      )
                    ],
                  ),
                )
              : Text(
                  "$text1",
                  style: TextStyle(
                      fontSize: ftSize ?? 12.sp,
                      fontWeight: FontWeight.bold,
                      color: txtColor ?? Colors.white),
                ),
        ),
      ),
    );
  }
}
