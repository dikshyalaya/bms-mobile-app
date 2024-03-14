import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/prior_clock_in/domain/prior_clock_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../clock_in_home/widget/clock_in_home_screen.dart';
import 'prior_clock_card.dart';

class PriorClockInHomeScreen extends StatelessWidget {
  const PriorClockInHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackGroundWrapper(
      child: ChangeNotifierProxyProvider<AuthProvider,
          PriorClockInProvider>(
          update: (_, authProvider, clockInProvide) {
            return PriorClockInProvider(authProvider.bmsUserModel?.empId??0)..getPriorClockInList();
          },
          lazy: false,
          create: (_) => PriorClockInProvider(
              0
          ),builder:(context,child)=> Scaffold(
        appBar:const BeaconAppBar(
          leadingIcon: AppBarLeadingIcon(),
          title: "Prior Clock-In",
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(
              height: 29,
            ),

            Expanded(
              child: Selector<PriorClockInProvider,bool>(builder: (context,isDataFetching,child) {
                final priorClockInResponseData = Provider.of<PriorClockInProvider>(context,listen: false).priorClockInResponseModel;
              
                return ServerResponseBuilder(builder: (context)=> ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => PriorClockInCard(
                      index: index,
                      priorClockInModel: priorClockInResponseData?.data?[index],
                    ),
                    padding: const EdgeInsets.only(left: 12,right: 12, bottom: 29),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 9,
                    ),
                    itemCount: priorClockInResponseData?.data?.length??0), isDataFetching: isDataFetching, isNullData: priorClockInResponseData?.data==null);
              }, selector: (context,provider)=>provider.isDataFetching),
            )

          ],
        ),
      ),),


    );
  }
}
