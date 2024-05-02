import 'package:beacon_flutter/features/login/split_widgets/alert_dialouge_forget_password.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Forget Password?',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
        ),
        SizedBox(height: 7.h,),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "No worries, click ",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
            children: [
              TextSpan(
                text: 'HERE',
                recognizer: TapGestureRecognizer()
                  ..onTap = () 
                  {
                    DialougeBoxShowingWidget(context);

                  },
                  // => DialogueUtils.confirmMessageDialogue(context: context),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
              ),
              TextSpan(
                text: ' to reset your password.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}