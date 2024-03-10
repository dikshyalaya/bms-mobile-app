import 'package:flutter/material.dart';

class BottomModalSheetUtils{
  BottomModalSheetUtils._();
  static void onOpenBottomModalSheet(BuildContext context,Widget builder)async{

    await showModalBottomSheet<
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
  }
}