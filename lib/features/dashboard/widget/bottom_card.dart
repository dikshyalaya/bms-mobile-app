import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:flutter/material.dart';

import 'dashboard_navigator-card.dart';

class BottomCard extends StatelessWidget {
  final int index;
  final CardModel cardModel;


  const BottomCard({
    key,
    required this.index,
    required this.cardProvider,
    required this.cardModel
  });
  

  final CardProvider cardProvider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClockInHomeScreen()));
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.green,
        color: cardModel.bgColor,
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 24),
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
                        fontSize: 22,
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
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.navigate_next_sharp,
                      color: Color(0xff325CA1),
                      size: 44,
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
