import 'package:flutter/cupertino.dart';

class DimensionUtils{
  DimensionUtils._();
  static bool isTab(BuildContext context) => MediaQuery.of(context).size.shortestSide > 600;

}