import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:flutter/cupertino.dart';

class ScaffoldBackGroundWrapper extends StatelessWidget {
  final Widget child;
  const ScaffoldBackGroundWrapper({key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "Dashboard".pngImage(),
            ),
            fit: BoxFit.cover,
          )),
      child: child,
    );
  }
}
