import 'dart:developer';

import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:beacon_flutter/common/widgets/custom_elevated_button.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/shared_preference/share_preference.dart';
import 'package:beacon_flutter/utils/dimension_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PasswordResetDialog extends StatefulWidget {
  const PasswordResetDialog({Key? key}) : super(key: key);

  @override
  State<PasswordResetDialog> createState() => _PasswordResetDialogState();
}

class _PasswordResetDialogState extends State<PasswordResetDialog> {
  bool? isTablet = getBool("isTablet");
  bool isLoading = false;
  bool isSendingOtp = false;
  bool isResetPasswordScreen = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController otpValue = TextEditingController();

  @override
  void initState() {
    super.initState();
    isResetPasswordScreen = false;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent, // Making the background transparent
      child: isResetPasswordScreen == true
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
                      child: buildText("Reset Password", isTablet ?? false)),
                  SizedBox(height: isTablet == true ? 30.h : 20.h),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isTablet == true ? 10.w : 24.w),
                      child: BeaconTextFormField(
                        labelText: "New Password",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: isTablet == true ? 12.sp : 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                        floatingStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: isTablet == true ? 15.sp : 17.sp,
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
                  SizedBox(height: isTablet == true ? 20.h : 13.h),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isTablet == true ? 10.w : 24.w),
                      child: BeaconTextFormField(
                        labelText: "Confirm Password",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: isTablet == true ? 12.sp : 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                        floatingStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: isTablet == true ? 15.sp : 17.sp,
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
                  SizedBox(height: isTablet == true ? 20.h : 13.h),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isTablet == true ? 10.w : 24.w),
                      child: BeaconTextFormField(
                        labelText: "Enter Password Reset Code",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: isTablet == true ? 12.sp : 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                        floatingStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: isTablet == true ? 15.sp : 17.sp,
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
                  SizedBox(height: isTablet == true ? 20.h : 13.h),
                  Padding(
                    padding: EdgeInsets.only(
                        right: isTablet == true ? 40.w : 90.w,
                        bottom: 24.h,
                        left: isTablet == true ? 50.w : 90.w),
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
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (newPassword.text.isEmpty ||
                                        confirmPassword.text.isEmpty ||
                                        otpValue.text.isEmpty) {
                                      shoErrorToast(
                                          'Please enter all field to continue');
                                    } else {
                                      authProvider.resetPassword(
                                        otpValue.text,
                                        newPassword.text,
                                        confirmPassword.text,
                                        onErrorState: (errorState) {
                                          log("has error");
                                          shoErrorToast(errorState.message);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        onLoadingState: (loadingState) {
                                          log("IS Loading");
                                          setState(() {
                                            isLoading = true;
                                          });
                                        },
                                        onLoadedState: (loadedState) {
                                          log("IS Loaded");
                                          setState(() {
                                            isLoading = false;
                                            Navigator.pop(context);
                                            successMessageDialogue(
                                                context: context,
                                                successMessage:
                                                    "Password reset successfully.",
                                                isTablet: isTablet ?? false);
                                          });
                                        },
                                      );
                                    }
                                  },
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF1870FF), // Start color
                                      Color(0xFF2E5698), // End color
                                    ],
                                  ),
                                  text1: 'Set New Password',
                                  ftSize: isTablet == true ? 10.sp : 12.sp,
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
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 40.h),
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
                          controller: email,
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
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xFFC1C1C1),
                                    fontSize: isTablet == true ? 12.sp : 15.sp,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: isSendingOtp == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : CustomElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (email.text.isEmpty ||
                                    !isEmailValid(email.text)) {
                                  shoErrorToast(
                                      'Please enter a valid email to continue');
                                } else {
                                  authProvider.sendOtpByEmail(
                                    email.text,
                                    onErrorState: (errorState) {
                                      setState(() {
                                        isSendingOtp = false;
                                      });
                                      log("has error");
                                      shoErrorToast(errorState.message);
                                    },
                                    onLoadingState: (loadingState) {
                                      log("IS Loading");
                                      setState(() {
                                        isSendingOtp = true;
                                      });
                                    },
                                    onLoadedState: (loadedState) {
                                      log("IS Loaded");
                                      setState(() {
                                        isResetPasswordScreen = true;
                                        isSendingOtp = false;
                                      });
                                      shoErrorToast(
                                          "Password reset code sent to email successfully");
                                    },
                                  );
                                }
                              },
                              bdRadius: 20.r,
                              text1: 'Send OTP',
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
  }
}

Text buildText(String text, bool isTablet) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black,
        fontSize: isTablet == true ? 12.sp : 15.sp,
        fontWeight: FontWeight.bold),
  );
}

bool isEmailValid(String email) {
  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  // Check if the email matches the regex pattern
  return emailRegex.hasMatch(email);
}

Future<void> successMessageDialogue(
    {required BuildContext context,
    required String successMessage,
    required bool isTablet}) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            // height: 124,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            width: DimensionUtils.isTab(context)
                ? 560.w
                : MediaQuery.of(context).size.width,
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 27.h, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: const BoxDecoration(
                        color: Color(0xff079D28),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    // SizedBox(
                    //   height: 40.h,
                    //   width: 40.w,
                    //   child: Card(
                    //     margin: EdgeInsets.zero,
                    //     color: const Color(0xff079D28),
                    //     // shape: RoundedRectangleBorder(
                    //     //   borderRadius: BorderRadius.circular(40.r),
                    //     // ),
                    // child: const Icon(
                    //   Icons.check,
                    //   color: Colors.white,
                    // ),
                    //   ),
                    // ),
                    SizedBox(
                      width: 11.w,
                    ),
                    Expanded(
                      child: Text(
                        successMessage,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isTablet == true ? 12.sp : 15.sp,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 40.h,
                    width: (94.11).w,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsetsDirectional.zero),
                            elevation: MaterialStateProperty.all(4),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff3B85FF)),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))))),
                        child: Text(
                          "Ok",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: isTablet == true ? 12.sp : 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                        )),
                  ),
                )
              ],
            ),
          )));
}
