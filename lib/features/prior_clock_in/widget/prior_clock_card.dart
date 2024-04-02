import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/features/prior_clock_in/data/prior_cloc_in_response_model.dart';
import 'package:beacon_flutter/features/prior_clock_in/widget/prior_clock_in_header.dart';
import 'package:flutter/material.dart';

class PriorClockInCard extends StatelessWidget {
  final int index;
  final PriorClockInModel? priorClockInModel;
  const PriorClockInCard(
      {Key? key, required this.index, required this.priorClockInModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // surfaceTintColor: const Color(0xff7A7A7A),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color(0xff7A7A7A),
                blurRadius: 2.0,
                spreadRadius: 0,
                offset: Offset(0.0, 3)),
          ],
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          PriorClockInHeader(
            index: index,
            priorClockInModel: priorClockInModel,
          ),
          SizedBox(height: 0.009.h(context)),
          richText(
              context, 'ScheduleDate: ', priorClockInModel?.scheduleDate ?? ''),
          buildDivider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              richText(
                  context, "Start Time: ", priorClockInModel?.startTime ?? ''),
              SizedBox(width: 0.03.w(context)),
              richText(context, "End Time: ", priorClockInModel?.endTime ?? '')
            ],
          ),
          buildDivider(),
          (priorClockInModel?.noBreakReason.isNotEmpty ?? false)
              ? richText(context, "No Meal Reason: ",
                  priorClockInModel?.noBreakReason ?? '')
              : richText(context, "Meal Time: ",
                  "${priorClockInModel?.lunchTime ?? ''} Min"),
          const SizedBox(
            height: 8,
          ),
          buildDivider(height: 0, indent: 0),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsetsDirectional.only(bottom: 6.55, top: 8),
            decoration: const BoxDecoration(
                color: Color(0xffF2F2F2),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: "Total Time: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 0.013.res(context),
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                    text:
                        '${(priorClockInModel?.totalTime.toString()) ?? ""} Hrs',
                    style: TextStyle(
                      fontSize: 0.013.res(context),
                      color: const Color(0xff2B2B2B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget richText(BuildContext context, String key, String val) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: key,
              style: TextStyle(
                  color: const Color(0xff8A8181),
                  fontSize: 0.013.res(context))),
          TextSpan(
            text: val,
            style: TextStyle(
                fontSize: 0.013.res(context), color: const Color(0xff2B2B2B)),
          ),
        ],
      ),
    );
  }
}

Divider buildDivider({double? height, double? indent}) {
  return Divider(
    thickness: 0.25,
    height: height,
    indent: indent,
    color: const Color(0xffB5B5B5),
  );
}
