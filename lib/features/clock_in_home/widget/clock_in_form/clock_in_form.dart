import 'dart:developer';

import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/split_widget/clock_in_details.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/split_widget/clock_in_header.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/split_widget/function/clock_in_functions.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/split_widget/function/input_validator.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_form/split_widget/too_early_widget.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/clock_in_home/data/clock_in_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/data/no_meal_reason_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/domain/clock_in_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  bool isEarlyOrExceeded = false;
  bool isEndTimeEmpty = true;

  @override
  void initState() {
    super.initState();
    setInitalValues();
  }

  void setInitalValues() {
    startTime = (widget.clockInResponse!.actualStartTime != null &&
            widget.clockInResponse!.actualStartTime != '')
        ? widget.clockInResponse!.actualStartTime
        : widget.clockInResponse?.startTime ?? '';
    startTimeController.text = startTime!;
    endTime = widget.clockInResponse?.endTime ?? "";
    endTimeController.text = '';
    mealTimeController.text = ClockInUtils.convertMealTimeToString(
        widget.clockInResponse?.lunchTime ?? '');
    noMealReasonIdController.text =
        (widget.clockInResponse!.noBreakReason != null)
            ? widget.clockInResponse!.noBreakReason.toString()
            : '';
    noMealReasonController.text =
        (widget.clockInResponse!.noBreakReason != null)
            ? ClockInUtils.getNameById(
                noMealReasonIdController.text, widget.noMealResonList)
            : '';
    calculateEarlyOrExceeded();
  }

  void calculateEarlyOrExceeded() {
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
    return ChangeNotifierProvider.value(
        value: widget.cLockInProvider,
        builder: (context, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClockInHeader(clockInResponse: widget.clockInResponse),
              if (isEarlyOrExceeded) ...[
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
              ] else
                const TooEarlyWidget(),
            ],
          );
        });
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
    bool isValidate = InputValidator.isValidInput(
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        mealTime: mealTimeController.text,
        noMealReason: noMealReasonController.text);
    if (isValidate) {
      await widget.cLockInProvider.punchIn(
          widget.clockInResponse?.id ?? -1,
          widget.clockInResponse?.scheduleDate ?? '',
          startTimeController.text,
          endTimeController.text,
          ClockInUtils.convertStringToMeal(mealTimeController.text),
          noMealReasonIdController.text, (val) {
        if (val) {
          Navigator.pop(context, "save");
          widget.clockInResponse!.actualStartTime = startTimeController.text;
          widget.clockInResponse!.lunchTime =
              ClockInUtils.convertStringToMeal(mealTimeController.text);
          widget.clockInResponse!.noBreakReason =
              int.parse(noMealReasonIdController.text);
          if (endTimeController.text.isNotEmpty) {
            widget.cLockInProvider
                .removeClockInListAfterCompleted(widget.clockInResponse!.id!);
            // setState(() {});
          }
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
}
