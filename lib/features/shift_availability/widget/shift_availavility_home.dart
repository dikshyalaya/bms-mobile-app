import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/builder/if_else_builder.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/shift_availability/domain/AvailableShiftProvider.dart';
import 'package:beacon_flutter/features/shift_availability/widget/shift_availabilty_card.dart';
import 'package:beacon_flutter/features/shift_availability/widget/toggle_bar.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShiftAvailabilityHome extends StatefulWidget {
  const ShiftAvailabilityHome({Key? key}) : super(key: key);

  @override
  State<ShiftAvailabilityHome> createState() => _ShiftAvailabilityHomeState();
}

class _ShiftAvailabilityHomeState extends State<ShiftAvailabilityHome> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AuthProvider, AvailableShiftProvider>(
      update: (_, authProvider, clockInProvide) {
        return AvailableShiftProvider(authProvider.bmsUserModel?.empId ?? 0)
          ..getAvailableShiftsForDcModel();
      },
      lazy: false,
      create: (_) => AvailableShiftProvider(0),
      builder: (context, child) => ScaffoldBackGroundWrapper(
          appBar: const BeaconAppBar(
            title: "Shift Availability",
            leadingIcon: AppBarLeadingIcon(),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Selector<AvailableShiftProvider, bool>(
                  builder: (context, isDataFetching, child) {
                    final availableShiftsForDcModel =
                        Provider.of<AvailableShiftProvider>(context,
                                listen: false)
                            .availableShiftsForDcModel;

                    final availableShiftProvider =Provider.of<AvailableShiftProvider>(context,
                        listen: false);

                    return ServerResponseBuilder(
                        builder: (context) => Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 12),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsetsDirectional.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sort By",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          width: 22,
                                        ),
                                        ToggleBar()
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) =>
                                            ShiftAvailabilityCard(
                                              scheduleCardModel:
                                                  availableShiftsForDcModel
                                                      .data![index],
                                              onCardAvailable: (isChecked, id) {
                                                availableShiftProvider.addRemoveShiftId(isChecked, id);
                                              },
                                            ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              height: 9,
                                            ),
                                        itemCount: availableShiftsForDcModel
                                                .data?.length ??
                                            0),
                                  ),
                                  SizedBox(
                                    height: 81,
                                    child: Center(
                                      child: SizedBox(
                                        height: 40,
                                        width: 163.47,
                                        child:


                                        Selector<AvailableShiftProvider,List<int>>(builder: (context,shiftIds,child)=>

                                            IfElseBuilder(
                                                condition:Provider.of<AvailableShiftProvider>(context,
                                                    listen: true).isDataPosting,
                                                ifBuilder: (context) =>
                                                const Center(
                                                  child:
                                                  CircularProgressIndicator(),
                                                ),
                                                elseBulider: (context) {
                                                  return ElevatedButton(
                                                      onPressed: () async {
                                                        if (shiftIds.isNotEmpty) {
                                                          // setState(() {
                                                          //   isPosting = true;
                                                          // });
                                                          await Provider.of<
                                                              AvailableShiftProvider>(
                                                              context,
                                                              listen: false)
                                                              .postShiftAvailability(
                                                              shiftIds, () {
                                                            DialogueUtils
                                                                .successMessageDialogue(
                                                                context:
                                                                context,
                                                                successMessage:
                                                                "Availability Saved Successfully.");
                                                          });
                                                          // setState(() {
                                                          //   isPosting = false;
                                                          // });
                                                        }
                                                      },
                                                      style: ButtonStyle(
                                                          padding: MaterialStateProperty.all(
                                                              EdgeInsetsDirectional
                                                                  .zero),
                                                          elevation:
                                                          MaterialStateProperty
                                                              .all(4),
                                                          backgroundColor:
                                                          MaterialStateProperty.all(
                                                              shiftIds.isEmpty?Colors.grey:  const Color(
                                                                  0xff1870FF)),
                                                          shape: MaterialStateProperty.all(
                                                              const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(20))))),
                                                      child: Text(
                                                        "Save",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ));
                                                }), selector: (context,provider)=>provider.shiftIds)

                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                        isDataFetching: isDataFetching,
                        isNullData: availableShiftsForDcModel?.data == null);
                  },
                  selector: (context, provider) => provider.isDataFetching))),
    );
  }
}
