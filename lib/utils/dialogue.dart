import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:flutter/material.dart';

class DialogueUtils {
  DialogueUtils._();
  static Future<bool> showErrorDialogue(
      {required BuildContext context,
      required String message,
      String? onYesText,
      String? onNoText,
      double? height}) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                height: 80,
                width: 288,
                padding: const EdgeInsets.only(left: 22, right: 17),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color(0xffD40000),
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 40,
                      width: 77,
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
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                          )),
                    ),
                  ],
                ),
              ),
            ));
  }

  static Future<bool> resetLinkDialogue(
      {required BuildContext context,
      Widget? cachedImageNetworkProgress,
      String? onYesText,
      String? onNoText,
      double? height}) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                height: 211,
                width: MediaQuery.of(context).size.width,
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
                    BeaconTextFormField(
                        textStyleSize:15,

                        iconData: Icons.email_outlined,
                        hintText: "Enter your email",
                        onChangedInput: (emailAddress) {}),
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
            ));
  }
}
