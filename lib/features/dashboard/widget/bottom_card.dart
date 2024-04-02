import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:flutter/material.dart';

import 'dashboard_navigator-card.dart';

class BottomCard extends StatelessWidget {
  final int index;
  final CardModel cardModel;

  const BottomCard(
      {Key? key,
      required this.index,
      required this.cardProvider,
      required this.cardModel})
      : super(key: key);

  final CardProvider cardProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ClockInHomeScreen()));
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.green,
        color: cardModel.bgColor,
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 24),
        child: SizedBox(
          height: 0.12.h(context),
          width: 1.0.w(context),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    cardModel.title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color(0xff1E1D1D),
                          fontSize: 0.018.res(context),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(width: 0.1.w(context)),
                Container(
                  height: 0.055.h(context),
                  width: 0.055.h(context),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.navigate_next_sharp,
                      color: const Color(0xff325CA1),
                      size: 0.03.res(context),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
