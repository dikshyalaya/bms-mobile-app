import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';

class BottomModalSheetUtils {
  BottomModalSheetUtils._();
  static void onOpenBottomModalSheet(
      BuildContext context, Widget builder) async {
    final val = await showModalBottomSheet<String?>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) => builder,
    );

    if (val == "save") {
      await DialogueUtils.successMessageDialogue(
          context: context, successMessage: "Clock-In Saved Successfully.");
    }
  }

  //Bootom Model sheet for manager approval Dispute
  static void openBottomModalSheetForDispute(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
        minWidth: double.infinity,
        minHeight: 100,
        maxHeight: 700,
      ),
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                padding:
                    const EdgeInsets.symmetric(vertical: 7.55, horizontal: 19),
                decoration: BoxDecoration(
                  color: const Color(0xff000000).withOpacity(0.25),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(9),
                    topRight: Radius.circular(9),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Dispute Information",
                  style: TextStyle(
                    color: Color(0xff1B1B1B),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Schedule Date:",
                              style: TextStyle(
                                color: Color(0xff8A8181),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Shift Time:",
                              style: TextStyle(
                                color: Color(0xff8A8181),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Meal Time:",
                              style: TextStyle(
                                color: Color(0xff8A8181),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Total Hours:",
                              style: TextStyle(
                                color: Color(0xff8A8181),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "2/10/2024",
                              style: TextStyle(
                                color: Color(0xff1B1B1B),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "08:00 AM - 04:00 PM",
                              style: TextStyle(
                                color: Color(0xff1B1B1B),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "30 Min",
                              style: TextStyle(
                                color: Color(0xff1B1B1B),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "8 Hrs",
                              style: TextStyle(
                                color: Color(0xff1B1B1B),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Comment:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        minLines: 3,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                            color: Color(0xff8A8181),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 40,
                        width: 94.11,
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
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
