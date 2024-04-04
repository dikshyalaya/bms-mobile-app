import 'package:flutter/material.dart';

class ScaffoldBackGroundWrapper extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  const ScaffoldBackGroundWrapper({Key? key, required this.child, this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
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
        child: Center(
          child: SizedBox(
            width: 400,
            child: child,
          ),
        ),
      ),
    );
  }
}
