import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/domain/manager_approval_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/widget/manager_approval_card.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';

class ManagerApprovalHomeScreen extends StatefulWidget {
  const ManagerApprovalHomeScreen({Key? key}) : super(key: key);

  @override
  State<ManagerApprovalHomeScreen> createState() =>
      _ManagerApprovalHomeScreenState();
}

class _ManagerApprovalHomeScreenState extends State<ManagerApprovalHomeScreen> {
  @override
  void initState() {
    DialogueUtils.managerApprovalFilterDialogue(
      context: context,
      onSaveSchedule: () {
        Navigator.pop(context);
      },
    );
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   DialogueUtils.managerApprovalFilterDialogue(
  //     context: context,
  //     onSaveSchedule: () {
  //       Navigator.pop(context);
  //     },
  //   );
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    ManagerApprovalProvider().getAccountHouses();
    return ScaffoldBackGroundWrapper(
      appBar: BeaconAppBar(
        title: "Manager Approval",
        action: [
          GestureDetector(
            onTap: () async {
              DialogueUtils.managerApprovalFilterDialogue(
                context: context,
                onSaveSchedule: () {
                  Navigator.pop(context);
                  // DialogueUtils.successMessageDialogue(
                  //     context: context,
                  //     successMessage: "Shift Added Successfully.");
                },
              );
            },
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
          )
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
                  itemBuilder: (context, index) => const ManagerApprovalCard(),
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
