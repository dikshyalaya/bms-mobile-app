import 'package:flutter/material.dart';

class MyScheduleCardHeader extends StatelessWidget {

  const MyScheduleCardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(vertical: 7.55,horizontal: 19),
      decoration: const BoxDecoration(
          color: Color(0xffD7ECFF),
          boxShadow: [
            BoxShadow(
                color:  Color(0xff7A7A7A),
                blurRadius: 10.0,
                spreadRadius: 0 ,
                offset: Offset(0.0, 3)
            ),

          ],          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      alignment: Alignment.center,
      child:  const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("3/6/2024 - Wednesday",style: TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15,fontWeight: FontWeight.w500
          ),),
          Text("11:30 PM - 09:30 AM",style: TextStyle(
              color: Color(0xff1B1B1B),
              fontSize: 15,fontWeight: FontWeight.w500
          ),),

        ],
      ),

    );
  }
}
