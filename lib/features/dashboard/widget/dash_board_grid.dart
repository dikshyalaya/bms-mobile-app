import 'package:beacon_flutter/features/dashboard/widget/dashboard_navigator-card.dart';
import 'package:flutter/material.dart';

class DashBoardGrid extends StatelessWidget {
  const DashBoardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardProvider = CardProvider();
    return Container(
      height: 380,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
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
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsetsDirectional.all(14),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 22.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 1 / 1.3),
          itemCount: cardProvider.gridCardProviders.length,
          itemBuilder: (BuildContext ctx, index) {
            return GridCard(
              cardModel: cardProvider.gridCardProviders[index],
            );
          }),
    );
  }
}

class GridCard extends StatelessWidget {
  final CardModel cardModel;
  const GridCard({Key? key, required this.cardModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            child: Center(
              child: Image.asset(
                cardModel.asset,
                height: 52,
                width: 62,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 38,
          child: Text(
            cardModel.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
