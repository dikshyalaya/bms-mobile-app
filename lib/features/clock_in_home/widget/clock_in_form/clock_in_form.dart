import 'dart:developer';

import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/split_widget/clock_in_details.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/split_widget/clock_in_header.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/split_widget/too_early_widget.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/clock_in_home/data/clock_in_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/data/no_meal_reason_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/domain/clock_in_provider.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/bms_drop_down.dart';
import 'package:beacon_flutter/utils/time_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ClockInForm extends StatefulWidget {
  final List<NoMealResponseModel> noMealResonList;
  final ClockInResponse? clockInResponse;
  final CLockInProvider cLockInProvider;

  const ClockInForm({
    Key? key,
    required this.noMealResonList,
    this.clockInResponse,
    required this.cLockInProvider,
  }) : super(key: key);

  @override
  State<ClockInForm> createState() => _ClockInFormState();
}

class _ClockInFormState extends State<ClockInForm> {
  String? startTime;
  String? endTime;
  String? mealTime;
  String? noMealReason;
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController mealTimeController = TextEditingController();
  TextEditingController noMealReasonController = TextEditingController();
  TextEditingController noMealReasonIdController = TextEditingController();
  bool isSaving = false;
  double? differenceInHours;
  bool? isEarlyOrExceeded;
  bool isEndTimeEmpty = true;

  @override
  void initState() {
    super.initState();
    calculate();
    startTime = (widget.clockInResponse!.actualStartTime != null &&
            widget.clockInResponse!.actualStartTime != '')
        ? widget.clockInResponse!.actualStartTime
        : widget.clockInResponse?.startTime ?? '';
    startTimeController.text = startTime!;
    endTime = widget.clockInResponse?.endTime ?? "";
    endTimeController.text = '';
    mealTimeController.text =
        convertMealTimeToString(widget.clockInResponse?.lunchTime ?? '');
    noMealReasonIdController.text =
        (widget.clockInResponse!.noBreakReason != null)
            ? widget.clockInResponse!.noBreakReason.toString()
            : '';
    noMealReasonController.text =
        (widget.clockInResponse!.noBreakReason != null)
            ? getNameById('1', widget.noMealResonList)
            : '';
  }

  void calculate() {
    // Parse scheduled date and time strings into DateTime objects
    DateFormat combinedFormat = DateFormat('M/d/yyyy h:mm a');
    DateTime scheduledDateTime = combinedFormat.parse(
        '${widget.clockInResponse?.scheduleDate ?? ''} ${widget.clockInResponse?.startTime ?? ''}');

    DateTime currentDate = DateTime.now();
    setState(() {
      isEarlyOrExceeded = currentDate
              .isBefore(scheduledDateTime.subtract(const Duration(hours: 2))) ||
          currentDate.isAfter(scheduledDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClockInHeader(clockInResponse: widget.clockInResponse),
        if (isEarlyOrExceeded == true)
          ClockInDetails(
            noMealReasonList: widget.noMealResonList,
            endTime: endTime!,
            startTime: startTime!,
            startTimeController: startTimeController,
            endTimeController: endTimeController,
            mealTimeController: mealTimeController,
            noMealReasonController: noMealReasonController,
            noMealReasonIdController: noMealReasonIdController,
            isSaving: isSaving,
            onSave: () => _handleSave(),
          )
        else
          const TooEarlyWidget(),
      ],
    );
  }

  void _handleSave() async {
    setState(() {
      isSaving = true;
    });
    log('----Start Time------');
    log(startTimeController.text);
    log('----End Time------');
    log(endTimeController.text);
    log('----meal Time------');
    log(mealTimeController.text);
    log('----no meal reason ------');
    log(noMealReasonController.text);
    if ((startTimeController.text.isNotEmpty &&
            endTimeController.text.isEmpty &&
            mealTimeController.text.isEmpty &&
            noMealReasonController.text.isEmpty) ||
        (startTimeController.text.isNotEmpty &&
            endTimeController.text.isNotEmpty &&
            mealTimeController.text == 'No Meal' &&
            noMealReasonController.text.isNotEmpty) ||
        (startTimeController.text.isNotEmpty &&
            endTimeController.text.isNotEmpty &&
            mealTimeController.text != 'No Meal' &&
            noMealReasonController.text.isEmpty) ||
        (startTimeController.text.isNotEmpty &&
            endTimeController.text.isEmpty &&
            mealTimeController.text != 'No Meal' &&
            noMealReasonController.text.isNotEmpty) ||
        (startTimeController.text.isNotEmpty &&
            endTimeController.text.isEmpty &&
            mealTimeController.text == 'No Meal' &&
            noMealReasonController.text.isNotEmpty) ||
        (startTimeController.text.isNotEmpty &&
            endTimeController.text.isNotEmpty &&
            mealTimeController.text.isNotEmpty &&
            noMealReasonController.text.isNotEmpty) ||
        (startTimeController.text.isNotEmpty &&
            endTimeController.text.isEmpty &&
            mealTimeController.text.isNotEmpty &&
            noMealReasonController.text.isEmpty)) {
      await widget.cLockInProvider.punchIn(
          widget.clockInResponse?.id ?? -1,
          widget.clockInResponse?.scheduleDate ?? '',
          startTimeController.text,
          endTimeController.text,
          convertStringToMeal(mealTimeController.text),
          noMealReasonIdController.text, (val) {
        if (val) {
          Navigator.pop(context, "save");
          widget.clockInResponse!.actualStartTime = startTimeController.text;
          widget.clockInResponse!.lunchTime =
              convertStringToMeal(mealTimeController.text);
          widget.clockInResponse!.noBreakReason =
              int.parse(noMealReasonIdController.text);
        }
      }, ((p0) {
        if (p0) {
          setState(() {
            isSaving = true;
          });
        } else {
          setState(() {
            isSaving = false;
          });
        }
      }));
    } else {
      setState(() {
        isSaving = false;
      });
      shoErrorToast("Enter valid input");
    }

    // handle save operation
  }

// onPressed: () async {
  //   setState(() {
  //     isSaving = true;
  //   });
  //   log(startTimeController.text);
  //   log(endTimeController.text);
  //   log(mealTimeController.text);
  //   log(noMealReasonController.text);

  //   if ((startTimeController
  //               .text.isNotEmpty &&
  //           endTimeController
  //               .text.isEmpty &&
  //           mealTimeController
  //               .text.isEmpty &&
  //           noMealReasonController
  //               .text.isEmpty) ||
  //       (startTimeController
  //               .text.isNotEmpty &&
  //           endTimeController
  //               .text.isNotEmpty &&
  //           mealTimeController
  //                   .text ==
  //               'No Meal' &&
  //           noMealReasonController
  //               .text.isNotEmpty) ||
  //       (startTimeController
  //               .text.isNotEmpty &&
  //           endTimeController
  //               .text.isNotEmpty &&
  //           mealTimeController
  //                   .text !=
  //               'No Meal' &&
  //           noMealReasonController
  //               .text.isEmpty) ||
  //       (startTimeController
  //               .text.isNotEmpty &&
  //           endTimeController
  //               .text.isEmpty &&
  //           mealTimeController
  //                   .text !=
  //               'No Meal' &&
  //           noMealReasonController
  //               .text.isNotEmpty) ||
  //       (startTimeController
  //               .text.isNotEmpty &&
  //           endTimeController
  //               .text.isEmpty &&
  //           mealTimeController
  //                   .text ==
  //               'No Meal' &&
  //           noMealReasonController
  //               .text.isNotEmpty) ||
  //       (startTimeController
  //               .text.isNotEmpty &&
  //           endTimeController
  //               .text.isNotEmpty &&
  //           mealTimeController
  //               .text.isNotEmpty &&
  //           noMealReasonController
  //               .text.isNotEmpty) ||
  //       (startTimeController
  //               .text.isNotEmpty &&
  //           endTimeController
  //               .text.isEmpty &&
  //           mealTimeController
  //               .text.isNotEmpty &&
  //           noMealReasonController
  //               .text.isEmpty)) {
  // await widget.cLockInProvider.punchIn(
  //     widget.clockInResponse?.id ?? -1,
  //     widget.clockInResponse
  //             ?.scheduleDate ??
  //         '',
  //     startTimeController.text,
  //     endTimeController.text,
  //     convertStringToMeal(
  //         mealTimeController.text),
  //     noMealReasonIdController.text,
  //     (val) {
  //   if (val) {
  //     Navigator.pop(context, "save");
  //     widget.clockInResponse!
  //             .actualStartTime =
  //         startTimeController.text;
  //     widget.clockInResponse!
  //             .lunchTime =
  //         convertStringToMeal(
  //             mealTimeController.text);
  //     widget.clockInResponse!
  //             .noBreakReason =
  //         int.parse(
  //             noMealReasonIdController
  //                 .text);
  //   }
  // }, ((p0) {
  //   if (p0) {
  //     setState(() {
  //       isSaving = true;
  //     });
  //   } else {
  //     setState(() {
  //       isSaving = false;
  //     });
  //   }
  // }));
  //   } else {
  //     // else {
  // setState(() {
  //   isSaving = false;
  // });
  // shoErrorToast("Enter valid input");
  //   }
  // },

  String convertStringToMeal(String mealTime) {
    switch (mealTime) {
      case '30 Minutes':
        return '30';
      case '60 Minutes':
        return '60';
      case 'No Meal':
        return '0';
      default:
        return '';
    }
  }

  String convertMealTimeToString(String mealTime) {
    switch (mealTime) {
      case '30':
        return '30 Minutes';
      case '60':
        return '60 Minutes';
      case '0':
        return 'No Meal';
      default:
        return '';
    }
  }

  String getNameById(String id, List<NoMealResponseModel> itemList) {
    // Find the item with the matching ID
    NoMealResponseModel item =
        itemList.firstWhere((element) => element.id == int.parse(id));
    // Return the name if found, or an empty string if not found
    return item.name;
  }
}

// class ClockInForm extends StatefulWidget {
//   final List<NoMealResponseModel> noMealResonList;

//   final ClockInResponse? clockInResponse;

//   final CLockInProvider cLockInProvider;
//   const ClockInForm(
//       {Key? key,
//       required this.noMealResonList,
//       this.clockInResponse,
//       required this.cLockInProvider})
//       : super(key: key);

//   @override
//   State<ClockInForm> createState() => _ClockInFormState();
// }

// class _ClockInFormState extends State<ClockInForm> {
//   String? startTime;
// String? endTime;
//   String? mealTime;
//   String? noMealReason;
//   TextEditingController startTimeController = TextEditingController();
//   TextEditingController endTimeController = TextEditingController();
//   TextEditingController mealTimeController = TextEditingController();
//   TextEditingController noMealReasonController = TextEditingController();
//   TextEditingController noMealReasonIdController = TextEditingController();
//   bool isSaving = false;
//   double? differenceInHours;
//   bool? isEarlyOrExceeded;
//   bool isEndTimeEmpty = true;

//   @override
//   void initState() {
//     log("No Meal Reason Contains: ${widget.noMealResonList.length}");
//     // widget.noMealResonList.insert(0,
//     //     NoMealResponseModel(name: '', description: '', masterFor: '', id: 0));
// startTime = (widget.clockInResponse!.actualStartTime != null &&
//         widget.clockInResponse!.actualStartTime != '')
//     ? widget.clockInResponse!.actualStartTime
//     : widget.clockInResponse?.startTime ?? '';

// endTime = widget.clockInResponse?.endTime ?? "";
// startTimeController.text = startTime!;
// endTimeController.text = '';
// mealTimeController.text =
//     convertMealTimeToString(widget.clockInResponse?.lunchTime ?? '');
//     noMealReasonIdController.text =
//         widget.clockInResponse!.noBreakReason != null
//             ? widget.clockInResponse!.noBreakReason.toString()
//             : '';
//     noMealReasonController.text =
//         (widget.clockInResponse!.noBreakReason != null)
//             ? getNameById(noMealReasonIdController.text, widget.noMealResonList)
//             : '';
//     isEndTimeEmpty = false;

//     super.initState();
//     calculate();
//     // getSurroundingTimes(startTime ?? '');
//   }

//   List<String> getSurroundingTimes(String givenTime, bool isStartDate) {
//     int index = timeOptions.indexOf(givenTime);
//     if (index == -1) return []; // Given time not found in the list

//     int startIndex = index - 8 < 0 ? 0 : index - 8;
//     int endIndex =
//         index + 8 >= timeOptions.length ? timeOptions.length - 1 : index + 8;

//     List<String> surroundingTimes =
//         List<String>.from(timeOptions.sublist(startIndex, endIndex + 1));
//     // surroundingTimes.removeAt(index - startIndex); // Removing the current time

//     if (!isStartDate) {
//       surroundingTimes.insert(0, ""); // Add empty string at the beginning
//     }

//     log(surroundingTimes.toList().toString());
//     return surroundingTimes;
//   }

// void calculate() {
//   // Parse scheduled date and time strings into DateTime objects
//   DateFormat combinedFormat = DateFormat('M/d/yyyy h:mm a');
//   DateTime scheduledDateTime = combinedFormat.parse(
//       '${widget.clockInResponse?.scheduleDate ?? ''} ${widget.clockInResponse?.startTime ?? ''}');

//   DateTime currentDate = DateTime.now();
//   setState(() {
//     isEarlyOrExceeded = currentDate
//             .isBefore(scheduledDateTime.subtract(const Duration(hours: 2))) ||
//         currentDate.isAfter(scheduledDateTime);
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // height: 480.h,
//       width: MediaQuery.of(context).size.height,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             height: 80.h,
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                       offset: const Offset(0, 0),
//                       color: Colors.black.withOpacity(0.3),
//                       spreadRadius: 0.9,
//                       blurRadius: 12.r)
//                 ],
//                 color: const Color(0xffD9D9D9),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20.r),
//                   topRight: Radius.circular(20.r),
//                 )),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "${widget.clockInResponse?.accountName} \n${widget.clockInResponse?.houseName}",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   height: 8.h,
//                 ),
//                 Text(
//                   "${widget.clockInResponse?.scheduleDate ?? ''}     ${widget.clockInResponse?.startTime} - ${widget.clockInResponse?.endTime}",
//                   style: TextStyle(
//                       color: const Color(0xff5B5B5B),
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//           ),
//           // (differenceInHours! >= -2 && differenceInHours! <= 1)
//           isEarlyOrExceeded == true
//               ? Padding(
//                   padding: EdgeInsetsDirectional.symmetric(
//                       horizontal: 20.w, vertical: 10.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
// SizedBox(
//   height: 10.h,
// ),
// buildTitleText("Start Time"),
// SizedBox(
//   height: 5.h,
// ),
// CustomDropdownButton(
//   hintText: 'Select Start Time',
//   items: getSurroundingTimes(startTime!, true),
//   selectedItem: startTimeController.text,
//   onChanged: (value) {
//     setState(() {
//       startTimeController.text = value;
//     });
//   },
// ),
// SizedBox(
//   height: 10.h,
// ),
// // const SizedBox(
// //   height: 7,
// // ),
// // // const Text("End Time"),

// // SizedBox(
// //   height: 10.h,
// // ),

// buildTitleText("Meal Time"),
// SizedBox(
//   height: 5.h,
// ),
// CustomDropdownButton(
//   hintText: 'Select Meal Time',
//   items: isEndTimeEmpty == false
//       ? mealTimeOption
//       : mealTimeOption
//           .where((item) => item != "")
//           .toList(),
//   selectedItem: mealTimeController.text,
//   onChanged: (value) {
//     setState(() {
//       // mealTime = value;
//       mealTimeController.text = value;
//       if (value == 'No Meal') {
//         noMealReasonController.text =
//             'Community inclusion';
//       } else {
//         noMealReasonController.text = '';
//       }
//     });
//   },
// ),
// SizedBox(
//   height: 10.h,
// ),
// mealTimeController.text == 'No Meal'
//     ? buildTitleText("No Meal Reason")
//     : const SizedBox(),
// mealTimeController.text == 'No Meal'
//     ? SizedBox(
//         height: 5.h,
//       )
//     : const SizedBox(),
// mealTimeController.text == 'No Meal'
//     ? Padding(
//         padding: EdgeInsets.only(bottom: 10.h),
//         child: CustomDropdownButton(
//           hintText: 'Select your no meal reason',
//           items: widget.noMealResonList
//               .map((e) => e.name)
//               .toList(),
//           selectedItem: widget.noMealResonList.first.name,
//           // selectedItem: noMealReason ?? '',
//           onChanged: (value) {
//             setState(() {
//               // noMealReason = value;
//               noMealReasonController.text = value;
//               noMealReasonIdController.text = getIdByName(
//                   value, widget.noMealResonList);
//             });
//           },
//         ),
//       )
//     : const SizedBox(),
// // const SizedBox(
// //   height: 18,
// // ),
// buildTitleText("End Time"),
// SizedBox(
//   height: 5.h,
// ),
// CustomDropdownButton(
//   hintText: 'Select End Time',
//   items: getSurroundingTimes(endTime!, false),
//   selectedItem: endTimeController.text,
//   onChanged: (value) {
//     setState(() {
//       endTimeController.text = value;
//       if (value == '') {
//         isEndTimeEmpty = false;
//         mealTimeController.text = '';
//         noMealReasonController.text = '';
//       } else {
//         isEndTimeEmpty = true;
//         mealTimeController.text = 'No Meal';
//         noMealReasonController.text =
//             'Community inclusion';
//       }
//     });
//   },
// ),
// const SizedBox(
//   height: 18,
// ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: SizedBox(
//                             height: 40,
//                             width: 94.11,
//                             child: IfElseBuilder(
//                                 condition: isSaving,
//                                 ifBuilder: (context) => const Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                 elseBulider: (context) {
//                                   return ElevatedButton(
//                                       style: ButtonStyle(
//                                           backgroundColor:
//                                               MaterialStateProperty.all(
//                                                   const Color(0xff1870FF)),
//                                           shape: MaterialStateProperty.all(
//                                               const RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(
//                                                               20))))),
//                                       onPressed: () async {
//                                         setState(() {
//                                           isSaving = true;
//                                         });
//                                         log(startTimeController.text);
//                                         log(endTimeController.text);
//                                         log(mealTimeController.text);
//                                         log(noMealReasonController.text);

//                                         if ((startTimeController
//                                                     .text.isNotEmpty &&
//                                                 endTimeController
//                                                     .text.isEmpty &&
//                                                 mealTimeController
//                                                     .text.isEmpty &&
//                                                 noMealReasonController
//                                                     .text.isEmpty) ||
//                                             (startTimeController
//                                                     .text.isNotEmpty &&
//                                                 endTimeController
//                                                     .text.isNotEmpty &&
//                                                 mealTimeController
//                                                         .text ==
//                                                     'No Meal' &&
//                                                 noMealReasonController
//                                                     .text.isNotEmpty) ||
//                                             (startTimeController
//                                                     .text.isNotEmpty &&
//                                                 endTimeController
//                                                     .text.isNotEmpty &&
//                                                 mealTimeController
//                                                         .text !=
//                                                     'No Meal' &&
//                                                 noMealReasonController
//                                                     .text.isEmpty) ||
//                                             (startTimeController
//                                                     .text.isNotEmpty &&
//                                                 endTimeController
//                                                     .text.isEmpty &&
//                                                 mealTimeController
//                                                         .text !=
//                                                     'No Meal' &&
//                                                 noMealReasonController
//                                                     .text.isNotEmpty) ||
//                                             (startTimeController
//                                                     .text.isNotEmpty &&
//                                                 endTimeController
//                                                     .text.isEmpty &&
//                                                 mealTimeController
//                                                         .text ==
//                                                     'No Meal' &&
//                                                 noMealReasonController
//                                                     .text.isNotEmpty) ||
//                                             (startTimeController
//                                                     .text.isNotEmpty &&
//                                                 endTimeController
//                                                     .text.isNotEmpty &&
//                                                 mealTimeController
//                                                     .text.isNotEmpty &&
//                                                 noMealReasonController
//                                                     .text.isNotEmpty) ||
//                                             (startTimeController
//                                                     .text.isNotEmpty &&
//                                                 endTimeController
//                                                     .text.isEmpty &&
//                                                 mealTimeController
//                                                     .text.isNotEmpty &&
//                                                 noMealReasonController
//                                                     .text.isEmpty)) {
//                                           await widget.cLockInProvider.punchIn(
//                                               widget.clockInResponse?.id ?? -1,
//                                               widget.clockInResponse
//                                                       ?.scheduleDate ??
//                                                   '',
//                                               startTimeController.text,
//                                               endTimeController.text,
//                                               convertStringToMeal(
//                                                   mealTimeController.text),
//                                               noMealReasonIdController.text,
//                                               (val) {
//                                             if (val) {
//                                               Navigator.pop(context, "save");
//                                               widget.clockInResponse!
//                                                       .actualStartTime =
//                                                   startTimeController.text;
//                                               widget.clockInResponse!
//                                                       .lunchTime =
//                                                   convertStringToMeal(
//                                                       mealTimeController.text);
//                                               widget.clockInResponse!
//                                                       .noBreakReason =
//                                                   int.parse(
//                                                       noMealReasonIdController
//                                                           .text);
//                                             }
//                                           }, ((p0) {
//                                             if (p0) {
//                                               setState(() {
//                                                 isSaving = true;
//                                               });
//                                             } else {
//                                               setState(() {
//                                                 isSaving = false;
//                                               });
//                                             }
//                                           }));
//                                         } else {
//                                           // else {
//                                           setState(() {
//                                             isSaving = false;
//                                           });
//                                           shoErrorToast("Enter valid input");
//                                         }
//                                       },
//                                       child: const Text(
//                                         "Save",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold),
//                                       ));
//                                 })),
//                       )
//                     ],
//                   ),
//                 )
//               : SizedBox(
//                   height: 200.h,
//                   child: const Column(
//                     children: [Icon(Icons.abc), Text('You are Too Early')],
//                   ))
//         ],
//       ),
//     );
//   }

//   Text buildTitleText(String key) {
//     return Text(
//       key,
//       style: const TextStyle(
//         color: Colors.black,
//         fontWeight: FontWeight.bold,
//         fontSize: 15,
//       ),
//     );
//   }
// }

// String getIdByName(String name, List<NoMealResponseModel> itemList) {
//   // Find the item with the matching name
//   NoMealResponseModel item =
//       itemList.firstWhere((element) => element.name == name);
//   return item.id.toString();
// }

// String getNameById(String id, List<NoMealResponseModel> itemList) {
//   // Find the item with the matching ID
//   NoMealResponseModel item =
//       itemList.firstWhere((element) => element.id == int.parse(id));
//   // Return the name if found, or an empty string if not found
//   return item.name;
// }

// String convertStringToMeal(String mealTime) {
//   switch (mealTime) {
//     case '30 Minutes':
//       return '30';
//     case '60 Minutes':
//       return '60';
//     case 'No Meal':
//       return '0';
//     default:
//       return '';
//   }
// }

// String convertMealTimeToString(String mealTime) {
//   switch (mealTime) {
//     case '30':
//       return '30 Minutes';
//     case '60':
//       return '60 Minutes';
//     case '0':
//       return 'No Meal';
//     default:
//       return '';
//   }
// }
