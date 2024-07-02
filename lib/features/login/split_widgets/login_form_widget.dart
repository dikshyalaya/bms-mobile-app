import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:beacon_flutter/features/login/split_widgets/custom_login_button.dart';
import 'package:beacon_flutter/features/login/split_widgets/forget_password_text_widget.dart';
import 'package:beacon_flutter/features/shared_preference/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 bool? isTablet = getBool("isTablet");

    final TextEditingController username = TextEditingController();
    final TextEditingController password = TextEditingController();
    return Padding(
      padding: EdgeInsets.only(top: 90.h, left: 15.w, right: 12.w),
      child: Column(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0x25000000), // 25% opacity black
                  offset: const Offset(0, 4), // X=0, Y=4
                  blurRadius: 4.r,
                  spreadRadius: 0,
                ),
              ],
              color: const Color(0xFF3C85FF),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 32.h, 20.w, 14.h),
              child: Column(
                children: [
                  Text(
                    "LOGIN",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                  ),
                  SizedBox(height: 22.h),
                  SizedBox(
                    height: 50.h,
                    child: BeaconTextFormField(
                      controller: username,
                      verticalPadding: 10.h,
                      horizontalPadding: 25.w,
                      prefixIcon: Padding(
                        padding:  EdgeInsets.only(left:8.w),
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: 20.sp,
                          color: const Color(0xFFC1C1C1),
                        ),
                      ),
                      radius: 25.r,
                      backgroundColor: const Color(0xFFFFFFFF),
                      hintText: 'Username',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                            fontWeight:  FontWeight.normal,
                              color: const Color(0xFFC1C1C1), fontSize: isTablet == true? 12.sp:15.sp),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 50.h,
                    child: BeaconTextFormField(
                      controller: password,
                      isPassword: true,
                      verticalPadding: 10.h,
                      horizontalPadding: 25.h,
                      prefixIcon: Padding(
                        padding:  EdgeInsets.only(left:8.w),
                        child: Icon(Icons.lock,
                            size: 20.sp, color: const Color(0xFFC1C1C1)),
                      ),
                      radius: 25.r,
                      backgroundColor: Colors.white,
                      hintText: 'Password',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                            fontWeight: FontWeight.normal,
                              fontSize: isTablet == true?12.sp: 15.sp, color: const Color(0xFFC1C1C1)),
                    ),
                  ),
                  SizedBox(height: 15.95.h),
                  CustomLoginButton(
                    userName: username,
                    password: password,
                  ),
                  SizedBox(height: 13.h),
                  const ForgetPasswordText(),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'The Beacon Group',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
