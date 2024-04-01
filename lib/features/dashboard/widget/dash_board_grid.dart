import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/dashboard/domain/systemSetting_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dashboard_navigator-card.dart';
import 'package:beacon_flutter/features/looking_for_shift/widget/looking_for_shift_home_screen.dart';
import 'package:beacon_flutter/features/my_schedule/widget/my_schedule_home.dart';
import 'package:beacon_flutter/features/prior_clock_in/widget/prior_clock_home_screen.dart';
import 'package:beacon_flutter/features/shift_availability/widget/shift_availavility_home.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardGrid extends StatelessWidget {
  const DashBoardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardProvider = CardProvider();
    return GridView.builder(
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
            index: index,
          );
        });
  }
}

class GridCard extends StatelessWidget {
  final CardModel cardModel;
  final int index;
  const GridCard({Key? key, required this.cardModel,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final systemSettingsProvider = Provider.of<SystemSettingProvider>(context,listen: false);
    return GestureDetector(
      onTap: (){
        switch(index){
          case 0:

            if(systemSettingsProvider.systemSettingsModel?.siteSetting.clockIn.enable??false){
              onSystemSettingsDialogue(context);
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClockInHomeScreen()));
            }
            break;
            case 1:
              if(systemSettingsProvider.systemSettingsModel?.siteSetting.mySchedule.enable??false){
                onSystemSettingsDialogue(context);
              }else {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const MyScheduleHomeScreen()));
              }
            break;
            case 2:
              if(systemSettingsProvider.systemSettingsModel?.siteSetting.shiftAvailability.enable??false){
                onSystemSettingsDialogue(context);
              }else {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const ShiftAvailabilityHome()));
              }
              break;
          case 3:
            if(systemSettingsProvider.systemSettingsModel?.siteSetting.priorClockIn.enable??false){
              onSystemSettingsDialogue(context);
            }else {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const PriorClockInHomeScreen()));
            }
            break;
            case 5:
              if(systemSettingsProvider.systemSettingsModel?.siteSetting.lookingForShift.enable??false){
                onSystemSettingsDialogue(context);
              }else {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const LookingForShiftHomeScreen()));
              }
            break;


        }
      },
      child: Column(
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
                  color: Colors.white, fontSize: 13,),
            ),
          )
        ],
      ),
    );
  }

  void onSystemSettingsDialogue(BuildContext context) {
    DialogueUtils.onSystemSettingsDialogue(context: context,);
  }
}
