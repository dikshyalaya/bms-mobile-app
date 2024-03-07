import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:flutter/material.dart';

class BeaconAppBar extends StatelessWidget {
  final Widget? leadingIcon;
  final String title;
  const BeaconAppBar({
    Key? key,
    this.leadingIcon,
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      shadowColor: Colors.grey,
      backgroundColor: const Color(0xff4579FF),
      leadingWidth: 0,
      leading: IfElseBuilder(
        condition: leadingIcon == null,
        ifBuilder: (context) => const SizedBox.shrink(),
        elseBulider: (context) => leadingIcon!,
      ),
      title: Padding(
        padding: const EdgeInsetsDirectional.only(top: 17, start: 14),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 17, top: 17),
          child: Image.asset(
            "profile".pngImage(),
            height: 34,
            width: 34,
          ),
        )
      ],
    );
  }
}
