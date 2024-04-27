import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/widget/manage_shift_card.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';

class ManageShiftHomeScreen extends StatefulWidget {
  const ManageShiftHomeScreen({Key? key}) : super(key: key);

  @override
  State<ManageShiftHomeScreen> createState() => _ManageShiftHomeScreenState();
}

class _ManageShiftHomeScreenState extends State<ManageShiftHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return ScaffoldBackGroundWrapper(
      appBar: BeaconAppBar(
        title: "Manage Shifts",
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
                  Icons.filter_alt_rounded,
                  color: Color(0xff325CA1),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
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
          )
        ],
        leadingIcon: const AppBarLeadingIcon(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10, vertical: 22),
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
              const SizedBox(height: 5),
              const Text(
                '3/16/2024 - 3/22/2024',
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
                  itemBuilder: (context, index) => const ManageShiftCard(),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                width: 163.47,
                child: ElevatedButton(
                  onPressed: () {
                    DialogueUtils.successMessageDialogue(
                        context: context,
                        successMessage: "Approval Saved Successfully.");
                  },
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(EdgeInsetsDirectional.zero),
                      elevation: MaterialStateProperty.all(4),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff1870FF)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))))),
                  child: Text(
                    "Save",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
