import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:flutter/material.dart';

class ToggleBar extends StatelessWidget {
  const ToggleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 0.03.h(context),
        width: 0.5.w(context),
        child: Row(
          children: [
            Expanded(
              child: cardBuilder(context,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  text: "Date"),
            ),
            const SizedBox(
              width: 1,
            ),
            Expanded(
              child: cardBuilder(context,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  text: "Distance"),
            ),
          ],
        ));
  }

  SizedBox cardBuilder(BuildContext context,
      {ShapeBorder? shape, required String text}) {
    return SizedBox(
      height: 0.03.h(context),
      child: Card(
        elevation: 6,
        margin: EdgeInsets.zero,
        color: const Color(0xff4579FF),
        shape: shape,
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 0.011.res(context),
          ),
        )),
      ),
    );
  }
}
