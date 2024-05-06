import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:beacon_flutter/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared_preference/share_preference.dart';

Future<dynamic> DialougeBoxShowingWidget(BuildContext context) {
  bool? isTablet = getBool("isTablet");
  bool isLoading = false;
  bool isResetPasswordScreen = false;
  // final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController otpValue = TextEditingController();

  return showDialog(
    context: context,
    builder: ((context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor:
            Colors.transparent, // Making the background transparent
        child: isResetPasswordScreen == false
            ? Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                          color: const Color(0xffD9D9D9),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7D7B7B).withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: buildText("Reset Your Password")),
                    SizedBox(height: 20.h),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isTablet == true ? 10.w : 24.w),
                        child: BeaconTextFormField(
                          labelText: "Enter the OTP",
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                          floatingStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                          controller: otpValue,
                          verticalPadding: 10.h,
                          horizontalPadding: 25.w,
                          radius: 25.r,
                          backgroundColor: const Color(0xFFFFFFFF),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFA9A9A9)),
                        )),
                    SizedBox(height: 13.h),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isTablet == true ? 10.w : 24.w),
                        child: BeaconTextFormField(
                          labelText: "New Password",
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                          floatingStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                          controller: newPassword,
                          verticalPadding: 10.h,
                          horizontalPadding: 25.w,
                          radius: 25.r,
                          backgroundColor: const Color(0xFFFFFFFF),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFA9A9A9)),
                        )),
                    SizedBox(height: 13.h),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isTablet == true ? 10.w : 24.w),
                        child: BeaconTextFormField(
                          labelText: "Confirm Password",
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                          floatingStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                          controller: confirmPassword,
                          verticalPadding: 10.h,
                          horizontalPadding: 25.w,
                          radius: 25.r,
                          backgroundColor: const Color(0xFFFFFFFF),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFA9A9A9)),
                        )),
                    SizedBox(
                      height: 13.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: isTablet == true ? 10.w : 24.w,
                          bottom: 24.h,
                          left: isTablet == true ? 120.w : 150.w),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          child: isLoading == true
                              ? SizedBox(
                                  width: 230.w,
                                  height: 40.h,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                        color: Color(0xFF1870FF)),
                                  ),
                                )
                              : SizedBox(
                                  child: CustomElevatedButton(
                                    onPressed: () async {},
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF1870FF), // Start color
                                        Color(0xFF2E5698), // End color
                                      ],
                                    ),
                                    text1: 'Reset Password',
                                    ftSize: isTablet == true ? 8.sp : 12.sp,
                                    bdRadius: 20.r,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                // height: 210.h,
                // height: double.infinity,
                padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF033992),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 40.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Password reset link will be sent to your email.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12
                              .sp, // Using screen utils for responsive font size
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                          height:
                              10.h), // Using screen utils for responsive height
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 50.h,
                          child: BeaconTextFormField(
                            hintText: 'Email your email',
                            radius: 50.r,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Icon(
                                Icons.mail,
                                color: const Color(0xFFC1C1C1),
                                size: 20.sp,
                              ),
                            ),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: const Color(0xFFC1C1C1),
                                  fontSize: isTablet == true ? 12.sp : 15.sp,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: CustomElevatedButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            isResetPasswordScreen = false;
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

Text buildText(String text) {
  return Text(
    text,
    style: const TextStyle(
        color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
  );
}
