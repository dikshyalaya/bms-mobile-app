import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';

class BottomModalSheetUtils{
  BottomModalSheetUtils._();
  static void onOpenBottomModalSheet(BuildContext context,Widget builder)async{

   final val= await showModalBottomSheet<
    String?>(
    context: context,
    isScrollControlled: true,
    shape:
    const RoundedRectangleBorder(
    borderRadius:
    BorderRadius.only(
    topLeft:
    Radius.circular(20.0),
    topRight:
    Radius.circular(20.0),
    ),
    ),
    builder: (context) =>builder
    ,
    );

   if(val=="save"){
    await DialogueUtils.successMessageDialogue(context: context,successMessage: "Clock-In Saved Successfully.");
   }
  }
}