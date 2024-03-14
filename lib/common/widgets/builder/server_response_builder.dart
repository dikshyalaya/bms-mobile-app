import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:flutter/material.dart';

class ServerResponseBuilder extends StatelessWidget {
  final bool isDataFetching;
  final bool isNullData;
  final Widget Function(BuildContext context) builder;
  const ServerResponseBuilder({
    Key? key,
    required this.builder, required this.isDataFetching, required this.isNullData,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IfElseBuilder(
        condition: isDataFetching,
        ifBuilder: (context)=>const Center(child: CircularProgressIndicator(),),
        elseBulider: (context) {

          return IfElseBuilder(
              condition: isNullData,
              ifBuilder: (context)=>const Center(child:  Text("Something went wrong")),

              elseBulider: (context) {
                return builder(context);
              }
          );
        }
    );
  }
}
