import 'package:flutter/material.dart';

class IfElseBuilder extends StatelessWidget {
  final bool condition;
  final Widget Function(BuildContext context) ifBuilder;
  final Widget Function(BuildContext context) elseBulider;
  const IfElseBuilder({
    Key? key,
    required this.condition,
    required this.ifBuilder,
    required this.elseBulider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? ifBuilder(context) : elseBulider(context);
  }
}
