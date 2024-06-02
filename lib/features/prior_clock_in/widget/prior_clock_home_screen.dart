import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/prior_clock_in/domain/prior_clock_in_provider.dart';
import 'package:beacon_flutter/utils/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../clock_in_home/widget/clock_in_home_screen.dart';
import 'prior_clock_card.dart';

class PriorClockInHomeScreen extends StatelessWidget {
  const PriorClockInHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackGroundWrapper(
      appBar: const BeaconAppBar(
        leadingIcon: AppBarLeadingIcon(),
        title: "Prior Clock-In",
      ),
      child: ChangeNotifierProxyProvider<AuthProvider, PriorClockInProvider>(
        update: (_, authProvider, clockInProvide) {
          return PriorClockInProvider()..getPriorClockInList();
        },
        lazy: false,
        create: (_) => PriorClockInProvider(),
        builder: (context, child) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const SizedBox(
                height: 29,
              ),
              Expanded(
                child: Selector<PriorClockInProvider, bool>(
                    builder: (context, isDataFetching, child) {
                      final priorClockInResponseData =
                          Provider.of<PriorClockInProvider>(context,
                                  listen: false)
                              .priorClockInResponseModel;

                      return ServerResponseBuilder(
                          builder: (context) => priorClockInResponseData!
                                  .data!.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'No Record Found',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.sp),
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      PriorClockInCard(
                                        index: index,
                                        priorClockInModel:
                                            priorClockInResponseData
                                                .data?[index],
                                      ),
                                  padding: bodyOnlyPadding(context),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 9,
                                      ),
                                  itemCount:
                                      priorClockInResponseData.data?.length ??
                                          0),
                          isDataFetching: isDataFetching,
                          isNullData: priorClockInResponseData?.data == null);
                    },
                    selector: (context, provider) => provider.isDataFetching),
              ),
              const SizedBox(
                height: 29,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
