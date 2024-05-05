import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:beacon_flutter/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared_preference/share_preference.dart';

Future<dynamic> DialougeBoxShowingWidget(BuildContext context) {
 bool? isTablet = getBool("isTablet");

  return showDialog(
    context: context,
    builder: ((context) {
      return Dialog(
        backgroundColor:
            Colors.transparent, // Making the background transparent
        child: Container(
          // height: 210.h,
          // height: double.infinity,
          padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF033992),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 40.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Password reset link will be sent to your email.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        12.sp, // Using screen utils for responsive font size
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                    height: 10.h), // Using screen utils for responsive height
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    height: 50.h,
                    child: BeaconTextFormField(
                      hintText: 'Email your email',
                      radius: 50.r,
                      prefixIcon: Padding(
                        padding:  EdgeInsets.only(left:8.w),
                        child: Icon(
                          Icons.mail,
                          color: const Color(0xFFC1C1C1),
                          size: 20.sp,
                        ),
                      ),
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color:  Color(0xFFC1C1C1),
                                fontSize: isTablet == true?12.sp: 15.sp,
                              ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    bdRadius: 20.r,
                    text1: 'Reset Password',
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1870FF), // Start color
                        Color(0xFF2E5698), // End color
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }),
  );
}
