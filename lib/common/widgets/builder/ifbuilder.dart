import 'package:flutter/material.dart';

class IfBuilder extends StatelessWidget {
  final bool condition;
  final Widget Function(BuildContext context) builder;
  const IfBuilder({Key? key, required this.builder, required this.condition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? builder(context) : const SizedBox.shrink();
  }
}
