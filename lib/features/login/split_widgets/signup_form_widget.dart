import 'package:beacon_flutter/common/urls.dart';
import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/login/split_widgets/custom_signup_button.dart';
import 'package:beacon_flutter/features/shared_preference/share_preference.dart';
import 'package:beacon_flutter/utils/custom_webview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({Key? key}) : super(key: key);

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    bool? isTablet = getBool("isTablet");
    return Padding(
      padding: EdgeInsets.only(top: 90.h, left: 15.w, right: 12.w),
      child: Column(
        children: [
          Container(
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
                    "SIGN UP",
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
                      controller: firstname,
                      verticalPadding: 10.h,
                      horizontalPadding: 25.w,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: 20.sp,
                          color: const Color(0xFFC1C1C1),
                        ),
                      ),
                      radius: 25.r,
                      backgroundColor: const Color(0xFFFFFFFF),
                      hintText: 'First Name',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              fontWeight: FontWeight.normal,
                              color: const Color(0xFFC1C1C1),
                              fontSize: isTablet == true ? 12.sp : 15.sp),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 50.h,
                    child: BeaconTextFormField(
                      controller: lastName,
                      verticalPadding: 10.h,
                      horizontalPadding: 25.h,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(Icons.account_circle_rounded,
                            size: 20.sp, color: const Color(0xFFC1C1C1)),
                      ),
                      radius: 25.r,
                      backgroundColor: Colors.white,
                      hintText: 'Last Name',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: isTablet == true ? 12.sp : 15.sp,
                              color: const Color(0xFFC1C1C1)),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 50.h,
                    child: BeaconTextFormField(
                      controller: email,
                      verticalPadding: 10.h,
                      horizontalPadding: 25.h,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(Icons.email,
                            size: 20.sp, color: const Color(0xFFC1C1C1)),
                      ),
                      radius: 25.r,
                      backgroundColor: Colors.white,
                      hintText: 'Email',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: isTablet == true ? 12.sp : 15.sp,
                              color: const Color(0xFFC1C1C1)),
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
                        padding: EdgeInsets.only(left: 8.w),
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
                              fontSize: isTablet == true ? 12.sp : 15.sp,
                              color: const Color(0xFFC1C1C1)),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 50.h,
                    child: BeaconTextFormField(
                      controller: confirmPassword,
                      isPassword: true,
                      verticalPadding: 10.h,
                      horizontalPadding: 25.h,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(Icons.lock,
                            size: 20.sp, color: const Color(0xFFC1C1C1)),
                      ),
                      radius: 25.r,
                      backgroundColor: Colors.white,
                      hintText: 'Confirm Password',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: isTablet == true ? 12.sp : 15.sp,
                              color: const Color(0xFFC1C1C1)),
                    ),
                  ),
                  SizedBox(height: 15.95.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Consumer<AuthProvider>(builder: (context, _, widget) {
                        return Checkbox(
                          value: authProvider.isAgreeTerms,
                          checkColor: Colors.black,
                          activeColor: Colors.white,
                          onChanged: (val) {
                            authProvider.toggleAgreeTerms();
                          },
                        );
                      }),
                      Flexible(
                        child: RichText(
                          maxLines: 3,
                          text: TextSpan(
                            text: "By signing up, I agree to the ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                            children: [
                              TextSpan(
                                text: 'Terms and Conditions',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const CustomWebView(
                                            url: termsAndConditionsUrl,
                                            title: "Terms and Conditions",
                                          ),
                                        ));
                                  },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              TextSpan(
                                text: ' and ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const CustomWebView(
                                            url: privacyPolicyUrl,
                                            title: "Privacy Policy",
                                          ),
                                        ));
                                  },
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  CustomSignupButton(
                    firstName: firstname,
                    lastName: lastName,
                    email: email,
                    password: password,
                    confirmPassword: confirmPassword,
                  ),
                  SizedBox(height: 20.h),

                  //Don't have an account? Sign Up
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                      children: [
                        TextSpan(
                          text: 'LOGIN',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                        ),
                      ],
                    ),
                  ),
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
