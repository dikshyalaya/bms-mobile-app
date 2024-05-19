import 'package:beacon_flutter/common/widgets/beacon_app_bar.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/clock_in_home/domain/clock_in_provider.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_display_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClockInHomeScreen extends StatelessWidget {
  const ClockInHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AuthProvider, CLockInProvider>(
      update: (_, authProvider, clockInProvide) {
        return CLockInProvider(authProvider.bmsUserModel?.empId ?? 0)
          ..getClockInList();
      },
      lazy: false,
      create: (_) => CLockInProvider(0),
      child: ScaffoldBackGroundWrapper(
        appBar: BeaconAppBar(
          leadingIcon: const AppBarLeadingIcon(),
          title: "Clock-In".toUpperCase(),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF174CD6), // Top part color
                  Color(0xFF98BBFF), // Bottom part color
                ],
              ),
            ),
            child: Selector<CLockInProvider, bool>(
              selector: (context, provider) => provider.isDataFetching,
              builder: (context, isDataFetching, child) {
                final clockInResponseData =
                    Provider.of<CLockInProvider>(context, listen: true)
                        .clockInResponseModel;
                return ServerResponseBuilder(
                  builder: (context) => ListView.separated(
                      itemBuilder: (context, index) => ClockInDisplayCard(
                            clockInResponse: clockInResponseData?.data?[index],
                          ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 29),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 3,
                          ),
                      itemCount: clockInResponseData?.data?.length ?? 0),
                  isDataFetching: isDataFetching,
                  isNullData: clockInResponseData?.data == null,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarLeadingIcon extends StatelessWidget {
  const AppBarLeadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: SizedBox(
        height: 34,
        width: 34,
        child: Card(
            color: Colors.white,
            margin: const EdgeInsets.only(left: 20, bottom: 10, top: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
            child: const Icon(
              Icons.navigate_before,
              color: Color(0xff325CA1),
            )),
      ),
    );
  }
}
