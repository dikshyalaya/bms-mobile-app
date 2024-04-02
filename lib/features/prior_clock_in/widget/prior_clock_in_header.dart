import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/features/prior_clock_in/data/prior_cloc_in_response_model.dart';
import 'package:flutter/material.dart';

class PriorClockInHeader extends StatelessWidget {
  final int index;
  final PriorClockInModel? priorClockInModel;

  const PriorClockInHeader(
      {Key? key, required this.index, this.priorClockInModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.08.h(context),
      padding: const EdgeInsets.symmetric(vertical: 7.55, horizontal: 7.55),
      decoration: const BoxDecoration(
          color: Color(0xffD7ECFF),
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 15.0, offset: Offset(0.0, 0.75))
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            priorClockInModel?.schedulePeriod ?? '',
            style: TextStyle(
                color: const Color(0xff373737),
                fontSize: 0.011.res(context),
                fontWeight: FontWeight.w500),
          ),
          Text(
            "${priorClockInModel?.accountName ?? ""} - ${priorClockInModel?.houseName ?? ''}",
            style: TextStyle(
                color: const Color(0xff1B1B1B),
                fontSize: 0.013.res(context),
                fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              priorClockInModel?.houseAddress ?? 'house address, null',
              maxLines: 1,
              style: TextStyle(
                color: const Color(0xff1B1B1B),
                fontSize: 0.011.res(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
