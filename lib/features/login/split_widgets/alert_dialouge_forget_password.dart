import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:beacon_flutter/utils/dimension_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> DialougeBoxShowingWidget(BuildContext context) {
  double width() => 560;
  return showDialog(
    context: context,
    builder: ((context) {
      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack( // Wrap with Stack
          children: [
            Positioned.fill( // Make the container fill the entire screen
              child: Container(
                color: Colors.black.withOpacity(0.6), // Semi-transparent black color for background
              ),
            ),
            AlertDialog(
              // shadowColor: Colors.black,
              backgroundColor:Colors.black.withOpacity(0.9), // Set background color to transparent
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.r))),
              content: Container(
                // height: 211,
                width: DimensionUtils.isTab(context)
                    ? width()
                    : MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: const Color(0xff033992),
                  borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Password reset link will be sent to your email.",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const BeaconTextFormField(),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 40,
                        width: 163,
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
                              "Reset Password",
                              style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }),
  );
}
