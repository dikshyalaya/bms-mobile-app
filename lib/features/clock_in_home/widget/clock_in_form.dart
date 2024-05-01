import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/clock_in_home/data/clock_in_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/data/no_meal_reason_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/domain/clock_in_provider.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/bms_drop_down.dart';
import 'package:beacon_flutter/utils/time_utils.dart';
import 'package:flutter/material.dart';

class ClockInForm extends StatefulWidget {
  final List<NoMealResponseModel> niMealResonList;

  final ClockInResponse? clockInResponse;

  final CLockInProvider cLockInProvider;
  const ClockInForm(
      {Key? key, required this.niMealResonList, this.clockInResponse,required this.cLockInProvider})
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

  @override
  void initState() {
    widget.niMealResonList.insert(0,
        NoMealResponseModel(name: '', description: '', masterFor: '', id: 0));
    startTime = widget.clockInResponse?.startTime ?? "";
    // endTime =widget.clockInResponse?.endTime??"";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 430,
      width: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.clockInResponse?.accountName} - ${widget.clockInResponse?.houseName}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${widget.clockInResponse?.scheduleDate ?? ''}     ${widget.clockInResponse?.startTime} - ${widget.clockInResponse?.endTime}",
                  style: const TextStyle(
                      color: Color(0xff5B5B5B),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.all(44),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTitleText("Start Time"),
                    BMSDropDownForm(
                      options: timeOptions,
                      onChooseOptions: (String val) {
                        setState(() {
                          startTime = val;
                        });
                      },
                      hint: startTime,
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTitleText("End Time"),
                    BMSDropDownForm(
                      options: timeOptions,
                      onChooseOptions: (String val) {
                        setState(() {
                          endTime = val;
                        });
                      },
                      hint: endTime,
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTitleText("Meal Time"),
                    BMSDropDownForm(
                      options: mealTimeOption,
                      onChooseOptions: (String val) {
                        setState(() {
                          mealTime = val;
                        });
                      },
                      hint: mealTime,
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTitleText("No Meal Reason"),
                    Expanded(
                      child: BMSDropDownForm(
                        options:
                            widget.niMealResonList.map((e) => e.name).toList(),
                        onChooseOptions: (String val) {
                          setState(() {
                            noMealReason = val;
                          });
                        },
                        hint: mealTime != "None" ? "" : noMealReason,
                        ignoring: mealTime != "None",
                      ),
                    )
                  ],
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
                        ifBuilder: (context)=>const Center(child: CircularProgressIndicator(),),
                        elseBulider: (context) {
                          return ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff1870FF)),
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))))),
                              onPressed: () async{
                                setState(() {
                                  isSaving =true;
                                });
                                if((startTime!=null&&endTime!=null)&&((mealTime=="None"||mealTime==null)&&noMealReason==null)){
                                  shoErrorToast("Enter valid input");
                                }else{
                                  if((startTime!=null)){
                                    if((mealTime=="None"&&noMealReason==null)){
                                      shoErrorToast("Enter valid input");
                                    }else{
                                      await  widget.cLockInProvider.punchIn(widget.clockInResponse?.id??-1, startTime??'', endTime??'', mealTime??'', noMealReason??'',(val){
                                        if(val){
                                          Navigator.pop(context, "save");
                                        }
                                      });
                                    }

                                  }else{
                                    shoErrorToast("Enter valid input");
                                  }

                                }
                                setState(() {
                                  isSaving =false;
                                });
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ));
                        }
                      )),
                )
              ],
            ),
          )
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
