import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/common/widgets/builder/ifbuilder.dart';
import 'package:beacon_flutter/common/widgets/builder/server_response_builder.dart';
import 'package:beacon_flutter/features/dashboard/domain/incomplete_activities_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/bottom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardNavigatorCard extends StatelessWidget {
  const DashBoardNavigatorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardProvider = CardProvider();
    return ChangeNotifierProvider<IncompleteActivitiesProvider>(
      create: (_) => IncompleteActivitiesProvider()..getIncompleteActivities(),
      builder: (context, child) => Selector<IncompleteActivitiesProvider, bool>(
        selector: (context, provider) => provider.isDataFetching,
        builder: (context, isDataFetching, child) {
          final incompleteActivities =
              Provider.of<IncompleteActivitiesProvider>(context, listen: false)
                  .incompleteActivitiesModel;

          List<CardModel> navigatorCards = [
            if ((incompleteActivities?.data?.pendingClockIns.count ?? 0) > 0)
              CardModel(
                  title:
                      "You have ${incompleteActivities?.data?.pendingClockIns.count} Pending Clock-In(s)",
                  bgColor: const Color(0xffFFB986)),
            if ((incompleteActivities?.data?.pendingInvites.count ?? 0) > 0)
              CardModel(
                  title:
                      "You have  ${incompleteActivities?.data?.pendingInvites.count} Pending  Invitation(s)",
                  bgColor: const Color(0xff51AAFD)),
          ];
          return ServerResponseBuilder(
            builder: (context) => IfBuilder(
                condition:
                    !(incompleteActivities?.data?.pendingClockIns.count == 0 &&
                        incompleteActivities?.data?.pendingInvites.count == 0),
                builder: (context) {
                  return Container(
                    // height: 285,
                    constraints: const BoxConstraints(
                      minHeight: 100,
                      maxHeight: 285,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsetsDirectional.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(-3, -3),
                              blurRadius: 4),
                        ]),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => BottomCard(
                        cardProvider: cardProvider,
                        index: index,
                        cardModel: navigatorCards[index],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 22,
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
    );
  }
}

class CardProvider {
  List<CardModel> gridCardProviders = [
    CardModel(title: "Clock In", asset: "clock-in".pngImage()),
    CardModel(title: "My Schedule", asset: "schedule".pngImage()),
    CardModel(
        title: "Shift Availability", asset: "shift-availiability".pngImage()),
    CardModel(title: "Prior Clock-In", asset: "prior-clock-in".pngImage()),
    CardModel(title: "Looking for Shift", asset: "looking".pngImage()),
  ];
}

class CardModel {
  final String title;
  final String asset;
  final Color? bgColor;

  CardModel({required this.title, this.asset = "", this.bgColor});
}
