import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/domain/manage_shift_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/widget/manage_shift_card.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageShiftHomeScreen extends StatefulWidget {
  const ManageShiftHomeScreen({Key? key}) : super(key: key);

  @override
  State<ManageShiftHomeScreen> createState() => _ManageShiftHomeScreenState();
}

class _ManageShiftHomeScreenState extends State<ManageShiftHomeScreen> {
  @override
  void initState() {
    showFilterPopUp(goHome: true);
    super.initState();
  }

  showFilterPopUp({bool goHome = false}) async {
    final provider = Provider.of<ManageShiftProvider>(context, listen: false);
    provider.selectedShiftPeriod = null;
    provider.selectedHouse = null;
    provider.schedulePeriodModel = null;
    provider.managerActiveShiftModel = null;
    provider.activeHouseForManagerModel = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DialogueUtils.manageShiftFilterDialogue(
        goHome: goHome,
        context: context,
        onSaveSchedule: () {
          Navigator.pop(context);
        },
      );
    });
    await provider.getSchedulePeriod();
  }

  @override
  void dispose() {
    Provider.of<ManageShiftProvider>(context, listen: false)
        .managerActiveShiftModel = null;
    Provider.of<ManageShiftProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackGroundWrapper(
      appBar: BeaconAppBar(
        title: "Manage Shifts",
        action: [
          GestureDetector(
            onTap: () {
              showFilterPopUp(goHome: false);
              // DialogueUtils.manageShiftFilterDialogue(
              //   goHome: false,
              //   context: context,
              //   onSaveSchedule: () {
              //     Navigator.pop(context);
              //   },
              // );
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
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () async {
              DialogueUtils.addShiftBottomSheet(
                context: context,
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
          child: Consumer<ManageShiftProvider>(
            builder: (context, shiftProvider, _) {
              return shiftProvider.managerActiveShiftModel == null
                  ? const Center(
                      child: Text(
                        "Please search shift",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : shiftProvider.isLoadingShifts == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : (shiftProvider.activeHouseForManagerModel?.data ?? [])
                              .isEmpty
                          ? const Center(
                              child: Text(
                                "No active shifts found",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Text(
                                  shiftProvider.selectedHouse?.accountNumber ??
                                      "",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  shiftProvider.selectedShiftPeriod
                                          ?.schedulePeriod ??
                                      "",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: shiftProvider
                                        .managerActiveShiftModel!.data!.length,
                                    itemBuilder: (context, index) {
                                      final currentShift = shiftProvider
                                          .managerActiveShiftModel!
                                          .data![index];
                                      return ManageShiftCard(
                                        managerActiveShift: currentShift,
                                      );
                                    },
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
                                          successMessage:
                                              "Approval Saved Successfully.");
                                    },
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsetsDirectional.zero),
                                        elevation: MaterialStateProperty.all(4),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0xff1870FF)),
                                        shape: MaterialStateProperty.all(
                                            const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))))),
                                    child: Text(
                                      "Save",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            );
            },
          ),
        ),
      ),
    );
  }
}
