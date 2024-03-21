import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/features/dashboard/widget/bottom_card.dart';
import 'package:flutter/material.dart';

class DashBoardNavigatorCard extends StatelessWidget {
  const DashBoardNavigatorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardProvider = CardProvider();
    return Container(
      height: 285,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsetsDirectional.symmetric(vertical: 30),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey, offset: Offset(-3, -3), blurRadius: 4),
          ]),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => BottomCard(cardProvider: cardProvider,index: index,),
        separatorBuilder: (context, index) => const SizedBox(
          height: 22,
        ),
        itemCount: cardProvider.navigatorCards.length,
      ),
    );
  }
}

class CardProvider {
  List<CardModel> navigatorCards = [
    CardModel(
        title: "You have 3 Pending Clock-In(s)",
        bgColor: const Color(0xffFFB986)),
    CardModel(
        title: "You have  3 Pending  Invitation(s)",
        bgColor: const Color(0xff51AAFD)),
  ];
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
