import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dashboard_navigator_card.dart';

class BottomCard extends StatelessWidget {
  final int index;
  final CardModel cardModel;
  final bool isFromPopUp;

  const BottomCard(
      {Key? key,
      required this.index,
      this.isFromPopUp = false,
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
      child: isFromPopUp
          ? Container(
              height: 53.h,
              width: double.infinity,
              color: const Color(0xFFBED1ED),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cardModel.title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color(0xff1E1D1D),
                          fontSize: isFromPopUp ? 15 : 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 25.h,
                      width: 25.w,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        Icons.navigate_next_sharp,
                        color: const Color(0xff325CA1),
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Card(
              elevation: 4,
              shadowColor: Colors.green,
              color: cardModel.bgColor,
              margin: EdgeInsetsDirectional.symmetric(
                  horizontal: isFromPopUp ? 8 : 24),
              child: SizedBox(
                height: 98,
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 19),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          cardModel.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: const Color(0xff1E1D1D),
                                  fontSize: isFromPopUp ? 19 : 22,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          Icons.navigate_next_sharp,
                          color: Color(0xff325CA1),
                          size: 44,
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

class BottomCard2 extends StatelessWidget {
  final int index;
  final CardModel cardModel;
  final bool isFromPopUp;

  const BottomCard2(
      {Key? key,
      required this.index,
      this.isFromPopUp = false,
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
        margin:
            EdgeInsetsDirectional.symmetric(horizontal: isFromPopUp ? 8 : 24),
        child: SizedBox(
          height: 98,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    cardModel.title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: const Color(0xff1E1D1D),
                        fontSize: isFromPopUp ? 19 : 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(
                    Icons.navigate_next_sharp,
                    color: Color(0xff325CA1),
                    size: 44,
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
