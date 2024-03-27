import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/utils/dimension_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScaffoldBackGroundWrapper extends StatelessWidget {
  final Widget child;
  PreferredSizeWidget? appBar;
   ScaffoldBackGroundWrapper({Key? key,required this.child,this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor:DimensionUtils.isTab(context)? Colors.grey:Colors.transparent,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width:DimensionUtils.isTab(context)?600: MediaQuery.of(context).size.width,
          decoration:  const BoxDecoration(
            color: Colors.grey,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF174CD6), // Top part color
                  Color(0xFF98BBFF), // Bottom part color
                ],
              ),
              ),
          child: child,
        ),
      ),
    );
  }
}
