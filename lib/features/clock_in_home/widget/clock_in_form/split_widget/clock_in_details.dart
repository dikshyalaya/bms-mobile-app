// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:beacon_flutter/features/clock_in_home/data/no_meal_reason_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/split_widget/custom_drop_down.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/split_widget/function/clock_in_functions.dart';
import 'package:beacon_flutter/utils/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClockInDetails extends StatefulWidget {
  // Declare necessary variables as constructor parameters
  TextEditingController startTimeController;
  TextEditingController endTimeController;
  TextEditingController mealTimeController;
  TextEditingController noMealReasonController;
  TextEditingController noMealReasonIdController;
  String startTime;
  String endTime;
  bool isSaving;
  List<NoMealResponseModel> noMealReasonList;
  Function() onSave;

  ClockInDetails({
    Key? key,
    required this.startTimeController,
    required this.endTimeController,
    required this.mealTimeController,
    required this.noMealReasonController,
    required this.noMealReasonIdController,
    required this.startTime,
    required this.endTime,
    required this.isSaving,
    required this.onSave,
    required this.noMealReasonList,

    // Pass necessary variables to the constructor
  }) : super(key: key);

  @override
  State<ClockInDetails> createState() => _ClockInDetailsState();
}

class _ClockInDetailsState extends State<ClockInDetails> {
  List<String> getSurroundingTimes(String givenTime, bool isStartDate) {
    int index = timeOptions.indexOf(givenTime);
    if (index == -1) return []; // Given time not found in the list

    int startIndex = index - 8 < 0 ? 0 : index - 8;
    int endIndex =
        index + 8 >= timeOptions.length ? timeOptions.length - 1 : index + 8;

    List<String> surroundingTimes =
        List<String>.from(timeOptions.sublist(startIndex, endIndex + 1));

    if (!isStartDate) {
      surroundingTimes.insert(0, "");
    }

    log(surroundingTimes.toList().toString());
    return surroundingTimes;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          SizedBox(
            height: 10.h,
          ),
          buildTitleText("Start Time"),
          SizedBox(
            height: 5.h,
          ),
          CustomDropdownButton(
            hintText: 'Select Start Time',
            items:
                // mealTimeOption,
                getSurroundingTimes(widget.startTime, true),
            selectedItem: widget.startTimeController.text,
            onChanged: (value) {
              setState(() {
                widget.startTimeController.text = value;
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
            selectedItem: widget.mealTimeController.text,
            onChanged: (value) {
              setState(() {
                // mealTime = value;
                widget.mealTimeController.text = value;
                if (value == 'No Meal') {
                  widget.noMealReasonController.text = 'Community inclusion';
                  widget.noMealReasonIdController.text =
                      ClockInUtils.getIdByName(
                          'Community inclusion', widget.noMealReasonList);
                } else {
                  widget.noMealReasonController.text = '';
                  widget.noMealReasonIdController.text = '';
                }
              });
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          widget.mealTimeController.text == 'No Meal'
              ? buildTitleText("No Meal Reason")
              : const SizedBox(),
          widget.mealTimeController.text == 'No Meal'
              ? SizedBox(
                  height: 5.h,
                )
              : const SizedBox(),
          widget.mealTimeController.text == 'No Meal'
              ? Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: CustomDropdownButton(
                    hintText: 'Select your no meal reason',
                    items: widget.noMealReasonList.map((e) => e.name).toList(),
                    selectedItem: widget.noMealReasonController.text,
                    onChanged: (value) {
                      setState(() {
                        // noMealReasonId = value;
                        widget.noMealReasonController.text = value;
                        widget.noMealReasonIdController.text =
                            ClockInUtils.getIdByName(
                                value, widget.noMealReasonList);
                      });
                    },
                  ),
                )
              : const SizedBox(),
          buildTitleText("End Time"),
          SizedBox(
            height: 5.h,
          ),
          CustomDropdownButton(
            hintText: 'Select End Time',
            items:
                //  mealTimeOption,
                getSurroundingTimes(widget.endTime, false),
            selectedItem: widget.endTimeController.text,
            onChanged: (value) {
              setState(() {
                widget.endTimeController.text = value;
              });
            },
          ),
          const SizedBox(
            height: 18,
          ),
          Align(
            alignment: Alignment.center,
            child: widget.isSaving
                ? const CircularProgressIndicator()
                : SizedBox(
                    height: 40,
                    width: 94.11,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff1870FF)),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))))),
                        onPressed: widget.onSave,
                        child: const Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ))),
          ),
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
