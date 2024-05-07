import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/domain/manager_approval_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/widget/manager_approval_card.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagerApprovalHomeScreen extends StatefulWidget {
  const ManagerApprovalHomeScreen({Key? key}) : super(key: key);

  @override
  State<ManagerApprovalHomeScreen> createState() =>
      _ManagerApprovalHomeScreenState();
}

class _ManagerApprovalHomeScreenState extends State<ManagerApprovalHomeScreen> {
  @override
  void initState() {
    showFilterPopUp();
    ManagerApprovalProvider().selectedShifts.clear();
    super.initState();
  }

  showFilterPopUp() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DialogueUtils.managerApprovalFilterDialogue(
        context: context,
        onSaveSchedule: () {
          Navigator.pop(context);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final managerApprovalProvider =
        Provider.of<ManagerApprovalProvider>(context, listen: true);
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
        body: Consumer(
          builder: (context, value, child) => Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12, vertical: 22),
            child: Selector<ManagerApprovalProvider, bool>(
              selector: (context, provider) =>
                  provider.isShiftForApprovalLoading,
              builder: (context, isListLoading, child) {
                return ServerResponseBuilder(
                  isDataFetching: isListLoading,
                  isNullData:
                      managerApprovalProvider.shiftForApprovalResponseModel ==
                          null,
                  builder: (context) {
                    return Column(
                      children: [
                        Text(
                          '${managerApprovalProvider.shiftForApprovalResponseModel?.data?[0].accountName ?? ""} - ${managerApprovalProvider.shiftForApprovalResponseModel?.data?[0].houseName ?? ""}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: managerApprovalProvider
                                    .shiftForApprovalResponseModel
                                    ?.data
                                    ?.length ??
                                0,
                            itemBuilder: (context, index) {
                              final currentShift = managerApprovalProvider
                                  .shiftForApprovalResponseModel!.data![index];
                              return ManagerApprovalCard(
                                shiftData: currentShift,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Consumer(
                          builder: (context, value, child) =>
                              managerApprovalProvider.isShiftApprovalPosting ==
                                      true
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : SizedBox(
                                      height: 40,
                                      width: 163.47,
                                      child: ElevatedButton(
                                        onPressed: managerApprovalProvider
                                                .selectedShifts.isEmpty
                                            ? null
                                            : () {
                                                ManagerApprovalProvider()
                                                    .postListShiftForApproval(
                                                        managerApprovalProvider
                                                            .selectedShifts);
                                                // DialogueUtils.successMessageDialogue(
                                                //     context: context,
                                                //     successMessage:
                                                //         "Approval Saved Successfully.");
                                              },
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsetsDirectional.zero),
                                            elevation:
                                                MaterialStateProperty.all(4),
                                            backgroundColor: MaterialStateProperty.all(
                                                managerApprovalProvider
                                                        .selectedShifts.isEmpty
                                                    ? const Color.fromARGB(
                                                        255, 156, 156, 156)
                                                    : const Color(0xff1870FF)),
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
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
