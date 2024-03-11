import 'package:beacon_flutter/features/clock_in_home/widget/bms_drop_down.dart';
import 'package:beacon_flutter/utils/time_utils.dart';
import 'package:flutter/material.dart';

class ClockInForm extends StatefulWidget {
  const ClockInForm({super.key});

  @override
  State<ClockInForm> createState() => _ClockInFormState();
}

class _ClockInFormState extends State<ClockInForm> {
  String? startTime ;
  String? endTime ;
  String? mealTime ;
  String? noMealReason ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430,
      width: MediaQuery.of(context).size.height,
      child: Column(
        children: [
Container(height: 80,width: double.infinity,decoration: const BoxDecoration(
  color: Color(0xffD9D9D9),

  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  )
),
child: const Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("Little Flower - Laurelton IRA",style: TextStyle(
      color: Colors.black,
      fontSize: 15,fontWeight: FontWeight.bold
    ),),
    SizedBox(height: 8,),
    Text("2/24/2024     08:00 AM - 04:00 PM",style: TextStyle(
        color: Color(0xff5B5B5B),
        fontSize: 15,fontWeight: FontWeight.w500
    ),),

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
                    BMSDropDownForm(options:timeOptions, onChooseOptions: (String val){
setState(() {
  startTime =val;
});
                    },hint: startTime,
                    )
                  ],
                ),
                const SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     buildTitleText("End Time"),

                    BMSDropDownForm(options:timeOptions, onChooseOptions: (String val){
setState(() {
  endTime =val;
});
                    },hint: endTime,
                    )
                  ],
                ),
                const SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTitleText("Meal Time"),

                    BMSDropDownForm(options: mealTimeOption, onChooseOptions: (String val){
setState(() {
  mealTime =val;
});
                    },hint: mealTime,
                    )
                  ],
                ),
                const SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTitleText("No Meal Reason"),

                    BMSDropDownForm(options: const ["","Reason A","Reason B","Reason C"], onChooseOptions: (String val){
setState(() {
  noMealReason = val;
});
                    },hint: mealTime!=null?" ":noMealReason,
                      ignoring: mealTime!=null,
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                 Align(
                  alignment: Alignment.centerRight,child: SizedBox(
                    height: 40,
                    width: 94.11,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff1870FF)),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))))
                        ),
                        onPressed: (){
                          Navigator.pop(context,"save");
                        }, child: const Text("Save",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,fontWeight: FontWeight.bold
                    ),))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Text buildTitleText(String key) {
    return  Text(key,style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),);
  }
}
