import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/dashboard/widget/dashboard_navigator-card.dart';
import 'package:beacon_flutter/features/looking_for_shift/widget/looking_for_shift_home_screen.dart';
import 'package:beacon_flutter/features/my_schedule/widget/my_schedule_home.dart';
import 'package:beacon_flutter/features/prior_clock_in/widget/prior_clock_home_screen.dart';
import 'package:beacon_flutter/features/shift_availability/widget/shift_availavility_home.dart';
import 'package:flutter/material.dart';

class DashBoardGrid extends StatelessWidget {
  const DashBoardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardProvider = CardProvider();
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsetsDirectional.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 22.0,
            crossAxisSpacing: 12.0,
            childAspectRatio: 1 / 1.3),
        itemCount: cardProvider.gridCardProviders.length,
        itemBuilder: (BuildContext ctx, index) {
          return GridCard(
            cardModel: cardProvider.gridCardProviders[index],
            index: index,
          );
        });
  }
}

class GridCard extends StatelessWidget {
  final CardModel cardModel;
  final int index;
  const GridCard({Key? key, required this.cardModel, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ClockInHomeScreen()));
            break;
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyScheduleHomeScreen()));
            break;
          case 2:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ShiftAvailabilityHome()));
            break;
          case 3:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PriorClockInHomeScreen()));
            break;
          case 4:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LookingForShiftHomeScreen()));
            break;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Card(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  cardModel.asset,
                  height: 0.06.h(context),
                  width: 0.06.h(context),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.05.h(context),
            child: Text(
              cardModel.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 0.011.res(context),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
