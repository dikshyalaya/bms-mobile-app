import 'package:beacon_flutter/features/manager_dashboard/manager_approval/data/shift_for_approval_response_model.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/domain/manager_approval_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/manager_approval/widget/manager_approval_header_card.dart';
import 'package:beacon_flutter/utils/bottom_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManagerApprovalCard extends StatefulWidget {
  final Datum shiftData;
  const ManagerApprovalCard({Key? key, required this.shiftData})
      : super(key: key);

  @override
  State<ManagerApprovalCard> createState() => _ManagerApprovalCardState();
}

class _ManagerApprovalCardState extends State<ManagerApprovalCard> {
  bool isTrue = false;
  @override
  Widget build(BuildContext context) {
    final managerApprovalProvider =
        Provider.of<ManagerApprovalProvider>(context, listen: true);
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ManagerApprovalHeaderCard(
            title: widget.shiftData.directCare ?? "N/A",
          ),
          const SizedBox(
            height: 11,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Schedule Date:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Shift Time:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Meal Time:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Total Hours:",
                      style: TextStyle(
                        color: Color(0xff8A8181),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.shiftData.scheduleDate}",
                      style: const TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${widget.shiftData.startTime} - ${widget.shiftData.endTime}",
                      // "${widget.shiftData.actualStartDateTime} - ${widget.shiftData.actualEndDateTime}",
                      style: const TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${widget.shiftData.lunchTime} Min",
                      style: const TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${widget.shiftData.totalTime?.toDouble()} Hrs",
                      style: const TextStyle(
                        color: Color(0xff1B1B1B),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 19),
            decoration: const BoxDecoration(
              color: Color(0xffF2F2F2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 35,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      BottomModalSheetUtils.openBottomModalSheetForDispute(
                          context);
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsetsDirectional.zero),
                        elevation: MaterialStateProperty.all(4),
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffD57300)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))))),
                    child: Text(
                      "Dispute",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 25,
                      child: FittedBox(
                        child: Switch(
                            activeColor: Colors.blue,
                            key: UniqueKey(),
                            value: isTrue,
                            onChanged: (bool val) {
                              setState(() {
                                isTrue = val;
                                managerApprovalProvider
                                    .addOrRemoveSelectedShift(
                                  widget.shiftData.id ?? 0,
                                  val,
                                );
                              });
                            }),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Approve",
                      style: TextStyle(color: Color(0xff324054), fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
