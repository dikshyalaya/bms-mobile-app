import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/features/dashboard/widget/dashboard_navigator_card.dart';
import 'package:beacon_flutter/features/manager_dashboard/house_employees/widget/house_employees_home.dart';
import 'package:beacon_flutter/features/manager_dashboard/house_shift/widget/house_shift_home.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/widget/manage_shift_home.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/widget/manager_approval_home.dart';
import 'package:flutter/material.dart';

class ManagerDashBoardGrid extends StatelessWidget {
  const ManagerDashBoardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsetsDirectional.all(14),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 22.0,
          crossAxisSpacing: 12.0,
          childAspectRatio: 1 / 1.3),
      itemCount: newGridCardProviders.length,
      itemBuilder: (BuildContext ctx, index) {
        return GridCard(
          cardModel: newGridCardProviders[index],
          index: index,
        );
      },
    );
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
                    builder: (context) => const ManagerApprovalHomeScreen()));
            break;
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ManageShiftHomeScreen()));
            break;
          case 2:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HouseEmployeeHomeScreen()));
            break;
          case 3:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HouseShiftHomeScreen()));
            break;
          case 4:
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const HouseEmployeeHomeScreen()));
            break;
          case 5:
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const HouseEmployeeHomeScreen()));
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
                  height: 52,
                  width: 62,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 38,
            child: Text(
              cardModel.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}

List<CardModel> newGridCardProviders = [
  CardModel(title: "Manager Approval", asset: "clock-in".pngImage()),
  CardModel(title: "Manage Shifts", asset: "prior-clock-in".pngImage()),
  CardModel(title: "House Employees", asset: "add-shift".pngImage()),
  CardModel(title: "House Shifts", asset: "house-shift".pngImage()),
  CardModel(title: "Approval History", asset: "shift-availiability".pngImage()),
  // CardModel(title: "View Bill & TS", asset: "schedule".pngImage()),
];
