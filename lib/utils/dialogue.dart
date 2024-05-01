import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/common/widgets/beacon_text_form.dart';
import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/common/widgets/password_change_field.dart';
import 'package:beacon_flutter/common/widgets/progress_dialogue.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/bms_drop_down.dart';
import 'package:beacon_flutter/features/dashboard/widget/dashboard_navigator_card.dart';
import 'package:beacon_flutter/features/looking_for_shift/data/schedule_period_response_model.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/domain/manager_approval_provider.dart';
import 'package:beacon_flutter/features/my_schedule/data/ListHouseForDCAddShiftModel.dart';
import 'package:beacon_flutter/features/my_schedule/domain/MyScheduleProvider.dart';
import 'package:beacon_flutter/utils/dimension_utils.dart';
import 'package:beacon_flutter/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogueUtils {
  DialogueUtils._();
  static Future<void> showErrorDialogue({
    required BuildContext context,
    required String message,
  }) async {
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
                    Expanded(
                      child: Text(
                        message,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: const Color(0xffD40000),
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
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
   static Future<bool> confirmMessageDialogue(
      {required BuildContext context}) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            width: DimensionUtils.isTab(context)
                ? _width()
                : MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 18),
            decoration: BoxDecoration(
                 color: Colors.white,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Are you sure want to cancel?",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context,false);
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
                              "No",
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
                    const SizedBox(width: 20,),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        width: 163,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context,true);
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
                              "Yes",
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
              ],
            ),
          ),
        ));
  }

  static Future<bool> resetLinkDialogue({required BuildContext context}) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                height: 211,
                width: DimensionUtils.isTab(context)
                    ? _width()
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
                    const BeaconTextFormField(
                        // textStyleSize: 15,
                        // iconData: Icons.email_outlined,
                        // hintText: "Enter your email",
                        // onChangedInput: (emailAddress) {}
                        ),
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

  static Text buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  static Future<void> onProfileIconClickDialogue(
      {required BuildContext context, required String userName}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                height: 403,
                width: DimensionUtils.isTab(context)
                    ? _width()
                    : MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 23),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Image.asset(
                        "profile".pngImage(),
                        height: 86,
                        width: 86,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        userName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff565656)),
                      ),
                    ]),
                    Column(
                      children: [
                        SizedBox(
                            height: 40,
                            width: 270,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff3B85FF)),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))))),
                                onPressed: () {
                                  changePasswordDialogue(context: context);
                                  // Navigator.pop(context,true);
                                },
                                child: const Text(
                                  "Change Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ))),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            authProvider.logOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
                                color: Color(0xff6F6F6F),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 37,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text(
                            "Close",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 13),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
   static Future<void> onPressedMyScheduleDialogue(
      {required BuildContext context,
      required VoidCallback onSaveSchedule,
      ListHouseForDcAddShiftModel? listHouseForDcAddShiftModel}) async {
    final availableShiftsProvider =
        Provider.of<MyScheduleProvider>(context, listen: false);
    List<String> listHouse = listHouseForDcAddShiftModel?.data
            ?.map((element) => element.accountNumber ?? '')
            .toList() ??
        [""];

     // listHouse.insert(0, "");
    bool isPosting = false;
    String selectedDate = "";
    String? selectedHouseNumber;
    String? shiftGivenByManager;
    String? startTime;
    String? endTime;
    String? scheduledDate;
     Row rowBuilder(String text, List<String> options,
        {String? hint, Function(String)? onChooseOption,bool ignoring=false}) {

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
          ),
          const SizedBox(
            width: 8,
          ),
          IfElseBuilder(
              condition: text == "Schedule Date",
              ifBuilder: (context) =>
                  StatefulBuilder(builder: (context, setState) {
                    return GestureDetector(
                      onTap: () async {
                        final returnDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate:
                            DateTime.now().add(const Duration(days: 30)));
                        setState(() {
                          if (returnDate != null) {
                            selectedDate = returnDate.toString().substring(0, 10);
                            onChooseOption?.call(returnDate.toString());
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 184,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffA9A9A9))),
                        padding:
                        const EdgeInsetsDirectional.only(start: 8, end: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedDate),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    );
                  }),
              elseBulider: (context) {
                return BMSDropDownForm(
                  ignoring: ignoring,
                  options: options,
                  onChooseOptions: (String val) {
                    onChooseOption?.call(val);
                  },
                  hint: hint,
                );
              })
        ],
      );
    }
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: StatefulBuilder(
                builder: (context, setState) => Container(
                  height: 358,
                  width: DimensionUtils.isTab(context)
                      ? _width()
                      : MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffD7ECFF),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 15.0,
                                  offset: Offset(0.0, 0.75))
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        height: 41,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          "Add a Shift",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 14.37,
                      ),
                      Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Was this shift given to you by manager?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  IfElseBuilder(
                                      condition: DimensionUtils.isTab(context),
                                      ifBuilder: (context) => BMSDropDownForm(
                                            options: const ["Yes", "No"],
                                            onChooseOptions: (String val) {
                                              setState(() {
                                                shiftGivenByManager = val;
                                              });
                                            },
                                            hint: shiftGivenByManager,
                                          ),
                                      elseBulider: (context) {
                                        return Expanded(
                                            child: BMSDropDownForm(
                                          options: const ["Yes", "No"],
                                          onChooseOptions: (String val) {
                                            setState(() {
                                              shiftGivenByManager = val;
                                            });
                                          },
                                          hint: shiftGivenByManager,
                                        ));
                                      })
                                ],
                              ),
                              const SizedBox(
                                height: 7.25,
                              ),
                              rowBuilder("House", listHouse,
                                  onChooseOption: (String val) {
                                selectedHouseNumber = val;
                              }),
                              const SizedBox(
                                height: 7.25,
                              ),
                              rowBuilder(
                                  "Schedule Date", const ["Select", "No"],
                                  onChooseOption: (String val) {
                                scheduledDate = val;
                              }),
                              const SizedBox(
                                height: 7.25,
                              ),
                              rowBuilder("Start Time", timeOptions,
                                  hint: startTime,
                                  onChooseOption: (String val) {
                                setState(() {
                                  startTime = val;
                                });
                              }),
                              const SizedBox(
                                height: 7.25,
                              ),
                              rowBuilder("End Time", timeOptions, hint: endTime,
                                  onChooseOption: (String val) {
                                setState(() {
                                  if((startTime?.contains("PM")??false)&&(val.contains("PM"))){
                                    shoErrorToast("Start time and end time must be valid");
                                    endTime = null;
                                  }else{
                                    endTime = val;
                                  }

                                });
                              },ignoring: startTime==null),
                              const SizedBox(
                                height: 16.25,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                    height: 38.33,
                                    width: 108.05,
                                    child: IfElseBuilder(
                                        condition: isPosting,
                                        ifBuilder: (context) =>
                                        const  Center(child:  CircularProgressIndicator()),
                                        elseBulider: (context) {
                                          return ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0xff3B85FF)),
                                                  shape: MaterialStateProperty.all(
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20))))),
                                              onPressed: () async {
                                                selectedHouseNumber ??= listHouse[0];
                                                if (selectedHouseNumber != null &&
                                                    startTime != null &&
                                                    endTime != null &&
                                                    scheduledDate != null) {
                                                  setState(() {
                                                    isPosting = true;
                                                  });
                                                  final houseId =
                                                      listHouseForDcAddShiftModel
                                                          ?.data
                                                          ?.firstWhere((element) =>
                                                              element
                                                                  .accountNumber ==
                                                              selectedHouseNumber)
                                                          .id;
                                                  await availableShiftsProvider
                                                      .createShift(
                                                          scheduledDate!,
                                                          startTime!,
                                                          endTime!,
                                                          houseId!,
                                                          (bool isCreated) {
                                                    if (isCreated) {
                                                      onSaveSchedule.call();
                                                    }
                                                  });
                                                  setState(() {
                                                    isPosting = false;
                                                  });
                                                } else {
                                                  shoErrorToast(
                                                      "Must select all the required field");
                                                }
                                              },
                                              child: const Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ));
                                        })),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ));



  }

  // static Future<void> onPressedMyScheduleDialogue(
  //     {required BuildContext context,
  //     required VoidCallback onSaveSchedule}) async {
  //   String? shiftGivenByManager;
  //   String? startTime;
  //   String? endTime;
  //   return await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       insetPadding: EdgeInsets.zero,
  //       backgroundColor: Colors.transparent,
  //       content: StatefulBuilder(
  //         builder: (context, setState) => Container(
  //           height: 358,
  //           width: DimensionUtils.isTab(context)
  //               ? _width()
  //               : MediaQuery.of(context).size.width,
  //           decoration: BoxDecoration(
  //               color: Colors.white, borderRadius: BorderRadius.circular(20)),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Container(
  //                 decoration: const BoxDecoration(
  //                     color: Color(0xffD7ECFF),
  //                     boxShadow: [
  //                       BoxShadow(
  //                           color: Colors.grey,
  //                           blurRadius: 15.0,
  //                           offset: Offset(0.0, 0.75))
  //                     ],
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(15),
  //                         topRight: Radius.circular(15))),
  //                 height: 41,
  //                 width: double.infinity,
  //                 alignment: Alignment.center,
  //                 child: const Text(
  //                   "Add a Shift",
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 14.37,
  //               ),
  //               Padding(
  //                   padding:
  //                       const EdgeInsetsDirectional.symmetric(horizontal: 16),
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           const Text(
  //                             "Was this shift given to you by manager?",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 13,
  //                                 color: Colors.black),
  //                           ),
  //                           const SizedBox(
  //                             width: 8,
  //                           ),
  //                           IfElseBuilder(
  //                               condition: DimensionUtils.isTab(context),
  //                               ifBuilder: (context) => BMSDropDownForm(
  //                                     options: const ["Yes", "No"],
  //                                     onChooseOptions: (String val) {
  //                                       setState(() {
  //                                         shiftGivenByManager = val;
  //                                       });
  //                                     },
  //                                     hint: shiftGivenByManager,
  //                                   ),
  //                               elseBulider: (context) {
  //                                 return Expanded(
  //                                     child: BMSDropDownForm(
  //                                   options: const ["Yes", "No"],
  //                                   onChooseOptions: (String val) {
  //                                     setState(() {
  //                                       shiftGivenByManager = val;
  //                                     });
  //                                   },
  //                                   hint: shiftGivenByManager,
  //                                 ));
  //                               })
  //                         ],
  //                       ),
  //                       const SizedBox(
  //                         height: 7.25,
  //                       ),
  //                       rowBuilder("House", const ["Select", "No"]),
  //                       const SizedBox(
  //                         height: 7.25,
  //                       ),
  //                       rowBuilder("Schedule Date", const ["Select", "No"]),
  //                       const SizedBox(
  //                         height: 7.25,
  //                       ),
  //                       rowBuilder("Start Time", timeOptions, hint: startTime,
  //                           onChooseOption: (String val) {
  //                         setState(() {
  //                           startTime = val;
  //                         });
  //                       }),
  //                       const SizedBox(
  //                         height: 7.25,
  //                       ),
  //                       rowBuilder("End Time", timeOptions, hint: endTime,
  //                           onChooseOption: (String val) {
  //                         setState(() {
  //                           endTime = val;
  //                         });
  //                       }),
  //                       const SizedBox(
  //                         height: 16.25,
  //                       ),
  //                       Align(
  //                         alignment: Alignment.centerRight,
  //                         child: SizedBox(
  //                           height: 38.33,
  //                           width: 108.05,
  //                           child: ElevatedButton(
  //                             style: ButtonStyle(
  //                                 backgroundColor: MaterialStateProperty.all(
  //                                     const Color(0xff3B85FF)),
  //                                 shape: MaterialStateProperty.all(
  //                                     const RoundedRectangleBorder(
  //                                         borderRadius: BorderRadius.all(
  //                                             Radius.circular(20))))),
  //                             onPressed: () {
  //                               onSaveSchedule.call();
  //                             },
  //                             child: const Text(
  //                               "Save",
  //                               style: TextStyle(
  //                                   color: Colors.white,
  //                                   fontSize: 15,
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ))
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  ///Manager Approval Filter Dialogue
  static Future<void> managerApprovalFilterDialogue(
      {required BuildContext context,
      required VoidCallback onSaveSchedule}) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF000000).withOpacity(0.25),
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          child: StatefulBuilder(
            builder: (context, setState) {
              ManagerApprovalProvider managerApprovalProvider =
                  Provider.of<ManagerApprovalProvider>(context, listen: false);
              managerApprovalProvider.getAccountHouses();
              return Consumer(
                builder: (context, value, child) => Container(
                  margin: const EdgeInsets.all(14),
                  // height: 300,
                  constraints: const BoxConstraints(
                    minHeight: 100,
                    maxHeight: 250,
                  ),
                  child: Selector<ManagerApprovalProvider, bool>(
                    selector: (context, provider) =>
                        provider.isAccountHousesLoading,
                    builder: (context, isDataFetching, child) {
                      final accountHousesData =
                          Provider.of<ManagerApprovalProvider>(context,
                                  listen: true)
                              .accountHousesResponseModel;
                      return ServerResponseBuilder(
                        builder: (context) {
                          return ListView.builder(
                            itemCount: managerApprovalProvider
                                    .accountHousesResponseModel?.data?.length ??
                                0,
                            itemBuilder: (context, index) {
                              final currentData =
                                  accountHousesData?.data?[index];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    height: 46,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      '${currentData?.accountNumber}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      itemCount:
                                          currentData?.houses?.length ?? 0,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final currentHouseData =
                                            currentData?.houses?[index];
                                        return Container(
                                          height: 46,
                                          margin:
                                              const EdgeInsets.only(top: 0.3),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFEAEAEA),
                                            borderRadius: index ==
                                                    (currentData?.houses
                                                                ?.length ??
                                                            0) -
                                                        1
                                                ? const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  )
                                                : null,
                                          ),
                                          child: ListTile(
                                            leading: Container(
                                              height: 32,
                                              width: 32,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              // child: Image.asset('edit'.iconImage()),
                                              child: const Icon(
                                                Icons.home,
                                                color: Color(0xFF325CA1),
                                              ),
                                            ),
                                            title: Text(
                                              '${currentHouseData?.accountNumber}',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            trailing: Container(
                                              height: 32,
                                              width: 32,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              // child: Image.asset('edit'.iconImage()),
                                              child: const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Color(0xFF325CA1),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              managerApprovalProvider
                                                  .getListShiftForApproval(
                                                      houseId: (currentHouseData
                                                                  ?.id ??
                                                              0)
                                                          .toString());
                                              managerApprovalProvider
                                                  .selectedShifts
                                                  .clear();
                                            },
                                          ),
                                        );
                                      }),
                                ],
                              );
                            },
                          );
                        },
                        isDataFetching: isDataFetching,
                        isNullData: accountHousesData?.data == null,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  static Row rowBuilder(String text, List<String> options,
      {String? hint, Function(String)? onChooseOption}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
        ),
        const SizedBox(
          width: 8,
        ),
        BMSDropDownForm(
          options: options,
          onChooseOptions: (String val) {
            onChooseOption?.call(val);
          },
          hint: hint,
        )
      ],
    );
  }

  static Future<String?> selectSchedulePeriodDialogue(
      {required BuildContext context,
      required List<SchedulePeriod> schedulePeriods,
      bool barrierDismissible = false}) async {
    String schedulePeriod = schedulePeriods.first.schedulePeriod;
    return await showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => AlertDialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              height: 160,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              width: DimensionUtils.isTab(context)
                  ? _width()
                  : MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Color(0xffD9D9D9),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    alignment: Alignment.center,
                    child: const Text(
                      "Select Schedule Period",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => BMSDropDownForm(
                      onChooseOptions: (String val) {
                        setState(() {
                          schedulePeriod = val;
                        });
                      },
                      options:
                          schedulePeriods.map((e) => e.schedulePeriod).toList(),
                      width: 217,
                      hint: schedulePeriod,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                      height: 40,
                      width: 163,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff3B85FF)),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                          onPressed: () {
                            Navigator.pop(context, schedulePeriod);
                          },
                          child: const Text(
                            "Search",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ))),
                ],
              ),
            )));
  }

  static double _width() => 560;

  static Future<void> successMessageDialogue(
      {required BuildContext context, required String successMessage}) async {
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
                  ? _width()
                  : MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 27, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Card(
                          margin: EdgeInsets.zero,
                          color: const Color(0xff079D28),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      Expanded(
                        child: Text(
                          successMessage,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
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
                          )),
                    ),
                  )
                ],
              ),
            )));
  }

  static Future<void> showProgressDialogue(
      BuildContext context, String message) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: message,
          );
        });
  }

  static Future<void> changePasswordDialogue(
      {required BuildContext context}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String newPassword = "";
    String confirmPassword = "";
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              content: Container(
                height: 240,
                width: DimensionUtils.isTab(context)
                    ? _width()
                    : MediaQuery.of(context).size.width,
                // padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Color(0xffD9D9D9)),
                      alignment: Alignment.center,
                      child: buildText("Change Password"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildText('New Password       '),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: PWChangeTextFormField(
                              onChangedInput: (String val) {
                                newPassword = val;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildText('Confirm Password'),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: PWChangeTextFormField(
                            onChangedInput: (String val) {
                              confirmPassword = val;
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 40,
                        width: 163,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (newPassword.isEmpty ||
                                  confirmPassword.isEmpty) {
                                shoErrorToast(
                                    "Password field must not be empty");
                              } else if (newPassword != confirmPassword) {
                                shoErrorToast("Password is not match");
                              } else {
                                FocusScope.of(context).unfocus();
                                showProgressDialogue(
                                    context, "Signing in, Please wait...");

                                await authProvider.changePassword(
                                    confirmPassword, onErrorState: (val) {
                                  Navigator.pop(context);
                                  shoErrorToast(
                                      val.response?.exception?.message ?? "");
                                }, onLoadedState: (val) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  successMessageDialogue(
                                      context: context,
                                      successMessage:
                                          "Password changed successfully.");
                                });
                              }
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
                              "Change Password",
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

  static Future<void> onSystemSettingsDialogue(
      {required BuildContext context}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                // height: 403,
                width: DimensionUtils.isTab(context)
                    ? _width()
                    : MediaQuery.of(context).size.width,
                // padding: const EdgeInsets.symmetric(vertical: 23),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child:  DashBoardNavigatorCard(),
              ),
            ));
  }
}
