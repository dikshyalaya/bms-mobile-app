import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:flutter/material.dart';

class DashBoardNavigatorCard extends StatelessWidget {
  const DashBoardNavigatorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardProvider = CardProvider();
    return ListView.separated(
      padding: const EdgeInsetsDirectional.only(top: 54),
      itemBuilder: (context, index) => Card(
        elevation: 4,
        shadowColor: Colors.green,
        color: cardProvider.navigatorCards[index].bgColor,
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 24),
        child: SizedBox(
          height: 124,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 19),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    cardProvider.navigatorCards[index].title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: const Color(0xff1E1D1D),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.navigate_next,
                      color: Color(0xff325CA1),
                      size: 54,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 22,
      ),
      itemCount: cardProvider.navigatorCards.length,
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
        title: "Shift\nAvailability", asset: "shift-availiability".pngImage()),
    CardModel(title: "Prior Clock-In", asset: "prior-clock-in".pngImage()),
    CardModel(title: "Add a Shift", asset: "add-shift".pngImage()),
    CardModel(title: "Looking for\nShift", asset: "looking".pngImage()),
  ];
}

class CardModel {
  final String title;
  final String asset;
  final Color? bgColor;

  CardModel({required this.title, this.asset = "", this.bgColor});
}
