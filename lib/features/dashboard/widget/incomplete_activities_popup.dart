import 'dart:ui';

import 'package:beacon_flutter/common/widgets/builder/ifbuilder.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/features/dashboard/domain/incomplete_activities_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dashboard_navigator_card.dart';
import 'package:beacon_flutter/utils/dimension_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IncompleteActivitiesPopUp extends StatelessWidget {
  const IncompleteActivitiesPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            width: DimensionUtils.isTab(context)
                ? 560
                : MediaQuery.of(context).size.width,
            // padding: const EdgeInsets.symmetric(vertical: 23), // Adjust if needed
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ChangeNotifierProvider<IncompleteActivitiesProvider>(
              create: (_) =>
                  IncompleteActivitiesProvider()..getIncompleteActivities(),
              builder: (context, child) =>
                  Selector<IncompleteActivitiesProvider, bool>(
                selector: (context, provider) => provider.isDataFetching,
                builder: (context, isDataFetching, child) {
                  final incompleteActivities =
                      Provider.of<IncompleteActivitiesProvider>(context,
                              listen: false)
                          .incompleteActivitiesModel;
                  List<dynamic> navigatorCards = [];

                  navigatorCards = [
                    if ((incompleteActivities?.data?.pendingClockIns.count ??
                            0) >
                        0)
                      CardModel(
                          title:
                              "You have ${incompleteActivities?.data?.pendingClockIns.count} Pending Clock-In(s)",
                          bgColor: const Color(0xffFFB986)),
                    if ((incompleteActivities?.data?.pendingInvites.count ??
                            0) >
                        0)
                      CardModel(
                          title:
                              "You have  ${incompleteActivities?.data?.pendingInvites.count} Pending  Invitation(s)",
                          bgColor: const Color(0xff51AAFD)),
                  ];

                  return ServerResponseBuilder(
                    builder: (context) => IfBuilder(
                        condition: !(incompleteActivities
                                    ?.data?.pendingClockIns.count ==
                                0 &&
                            incompleteActivities?.data?.pendingInvites.count ==
                                0),
                        builder: (context) {
                          return Container(
                            // height: 285,
                            constraints: const BoxConstraints(
                              minHeight: 100,
                              maxHeight: 285,
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsetsDirectional.symmetric(
                                vertical: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final cardModel = navigatorCards[index];
                                return Container(
                                  height: 53.h,
                                  width: double.infinity,
                                  color: const Color(0xFFBED1ED),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          cardModel.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  color:
                                                      const Color(0xff1E1D1D),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          height: 25.h,
                                          width: 25.w,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Icon(
                                            Icons.navigate_next_sharp,
                                            color: const Color(0xff325CA1),
                                            size: 20.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 3,
                              ),
                              itemCount: navigatorCards.length,
                            ),
                          );
                        }),
                    isDataFetching: isDataFetching,
                    isNullData: incompleteActivities?.data == null,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
