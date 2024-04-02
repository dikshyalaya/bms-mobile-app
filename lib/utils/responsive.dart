import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive({Key? key,required this.mobile, required this.tablet, required this.desktop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
