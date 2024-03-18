import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:flutter/cupertino.dart';

class ScaffoldBackGroundWrapper extends StatelessWidget {
  final Widget child;
  const ScaffoldBackGroundWrapper({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
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
    );
  }
}
