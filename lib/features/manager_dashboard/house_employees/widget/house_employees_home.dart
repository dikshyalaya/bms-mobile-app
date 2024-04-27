import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/house_employees/widget/house_employee_card.dart';
import 'package:flutter/material.dart';

class HouseEmployeeHomeScreen extends StatefulWidget {
  const HouseEmployeeHomeScreen({Key? key}) : super(key: key);

  @override
  State<HouseEmployeeHomeScreen> createState() =>
      _HouseEmployeeHomeScreenState();
}

class _HouseEmployeeHomeScreenState extends State<HouseEmployeeHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return ScaffoldBackGroundWrapper(
      appBar: BeaconAppBar(
        title: "House Employees",
        action: [
          GestureDetector(
            onTap: () async {},
            child: SizedBox(
              height: 34,
              width: 34,
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34)),
                child: const Icon(
                  Icons.add_rounded,
                  color: Color(0xff325CA1),
                ),
              ),
            ),
          ),
        ],
        leadingIcon: const AppBarLeadingIcon(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 12, vertical: 22),
          child: Column(
            children: [
              const Text(
                'Adapt - 1780 Stillwell Ave (DP)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: 14,
                  itemBuilder: (context, index) => const HouseEmployeeCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
