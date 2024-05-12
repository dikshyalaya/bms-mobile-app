import 'dart:developer';

import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/clock_in_home/data/clock_in_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/data/no_meal_reason_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/domain/clock_in_provider.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/bms_drop_down.dart';
import 'package:beacon_flutter/utils/time_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ClockInForm extends StatefulWidget {
  final List<NoMealResponseModel> niMealResonList;

  final ClockInResponse? clockInResponse;

  final CLockInProvider cLockInProvider;
  const ClockInForm(
      {Key? key,
      required this.niMealResonList,
      this.clockInResponse,
      required this.cLockInProvider})
      : super(key: key);

  @override
  State<ClockInForm> createState() => _ClockInFormState();
}

class _ClockInFormState extends State<ClockInForm> {
  String? startTime;
  String? endTime;
  String? mealTime;
  String? noMealReason;
  bool isSaving = false;
  double? differenceInHours;

  @override
  void initState() {
    widget.niMealResonList.insert(0,
        NoMealResponseModel(name: '', description: '', masterFor: '', id: 0));
    startTime = widget.clockInResponse?.startTime ?? "";
    // endTime =widget.clockInResponse?.endTime??"";
    super.initState();
    calculate();
  }

  void calculate() {
    // Parse scheduled date and time strings into DateTime objects
    DateFormat combinedFormat = DateFormat('M/d/yyyy h:mm a');
    DateTime scheduledDateTime = combinedFormat.parse(
        '${widget.clockInResponse?.scheduleDate ?? ''} ${widget.clockInResponse?.startTime ?? ''}');

    DateTime currentDate = DateTime.now();

    // Calculate the difference
    Duration difference = currentDate.difference(scheduledDateTime);

    // Convert difference to hours
    setState(() {
      differenceInHours = difference.inHours.toDouble();
    });

    log(differenceInHours.toString().replaceAll('-', ''));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 480.h,
      width: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xffD9D9D9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.clockInResponse?.accountName} - ${widget.clockInResponse?.houseName}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "${widget.clockInResponse?.scheduleDate ?? ''}     ${widget.clockInResponse?.startTime} - ${widget.clockInResponse?.endTime}",
                  style: TextStyle(
                      color: const Color(0xff5B5B5B),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          (differenceInHours! >= -2 && differenceInHours! <= 1)
              ? Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTitleText("Start Time"),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomDropdownButton(
                        hintText: 'Select Start Time',
                        items: timeOptions,
                        selectedItem: startTime!,
                        onChanged: (value) {
                          setState(() {
                            startTime = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      // const Text("End Time"),
                      buildTitleText("End Time"),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomDropdownButton(
                        hintText: 'Select End Time',
                        items: timeOptions,
                        selectedItem: '',
                        onChanged: (value) {
                          setState(() {
                            endTime = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),

                      buildTitleText("Meal Time"),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomDropdownButton(
                        hintText: 'Select Meal Time',
                        items: mealTimeOption,
                        selectedItem: '',
                        onChanged: (value) {
                          setState(() {
                            mealTime = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      buildTitleText("No Meal Reason"),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomDropdownButton(
                        hintText: 'Select your no meal reason',
                        items: mealTimeOption,
                        selectedItem: '',
                        onChanged: (value) {
                          setState(() {
                            noMealReason = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            height: 40,
                            width: 94.11,
                            child: IfElseBuilder(
                                condition: isSaving,
                                ifBuilder: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                elseBulider: (context) {
                                  return ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xff1870FF)),
                                          shape: MaterialStateProperty.all(
                                              const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20))))),
                                      onPressed: () async {
                                        setState(() {
                                          isSaving = true;
                                        });
                                        if ((startTime != null &&
                                                endTime != null) &&
                                            ((mealTime == "None" ||
                                                    mealTime == null) &&
                                                noMealReason == null)) {
                                          shoErrorToast("Enter valid input");
                                        } else {
                                          if ((startTime != null)) {
                                            if ((mealTime == "None" &&
                                                noMealReason == null)) {
                                              shoErrorToast(
                                                  "Enter valid input");
                                            } else {
                                              await widget.cLockInProvider
                                                  .punchIn(
                                                      widget.clockInResponse
                                                              ?.id ??
                                                          -1,
                                                      startTime ?? '',
                                                      endTime ?? '',
                                                      mealTime ?? '',
                                                      noMealReason ?? '',
                                                      (val) {
                                                if (val) {
                                                  Navigator.pop(
                                                      context, "save");
                                                }
                                              });
                                            }
                                          } else {
                                            shoErrorToast("Enter valid input");
                                          }
                                        }
                                        setState(() {
                                          isSaving = false;
                                        });
                                      },
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ));
                                })),
                      )
                    ],
                  ),
                )
              : Container(
                  child: const Column(
                  children: [Text('No Data')],
                ))
        ],
      ),
    );
  }

  Text buildTitleText(String key) {
    return Text(
      key,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }
}

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton(
      {Key? key,
      required this.items,
      required this.selectedItem,
      required this.onChanged,
      required this.hintText})
      : super(key: key);
  final List<String> items;
  final String selectedItem;
  final String hintText;
  final ValueChanged<String> onChanged;
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: widget.selectedItem,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // Add more decoration..
      ),
      hint: Text(
        widget.hintText,
        style: const TextStyle(fontSize: 14),
      ),
      items: widget.items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      // validator: (value) {
      //   if (value == null) {
      //     return 'Please select gender.';
      //   }
      //   return null;
      // },
      onChanged: (value) {
        //Do something when selected item is changed.
        log("Ischanged");
        widget.onChanged(value!);
      },
      onSaved: (value) {
        log("IsSaved");

        // endTime = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
