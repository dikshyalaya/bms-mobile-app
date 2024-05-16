import 'package:beacon_flutter/common/widgets/scaffold_background_wrapper.dart';
import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/dashboard/domain/system_setting_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dashboard_navigator_card.dart';
import 'package:beacon_flutter/features/looking_for_shift/widget/looking_for_shift_home_screen.dart';
import 'package:beacon_flutter/features/my_schedule/widget/my_schedule_home.dart';
import 'package:beacon_flutter/features/prior_clock_in/widget/prior_clock_home_screen.dart';
import 'package:beacon_flutter/features/shift_availability/widget/shift_availavility_home.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/beacon_app_bar.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context, listen: false)
    //   ..getUserDetail();
    return ScaffoldBackGroundWrapper(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 68),
          child: Selector<AuthProvider, BmsUserModel?>(
            selector: (context, provider) => provider.bmsUserModel,
            builder: (context, bmsUserModel, child) => BeaconAppBar(
              title:
                  "${bmsUserModel?.empFirstName} ${bmsUserModel?.empLastName}",
            ),
          )),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: GridView.count(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 12,
                    crossAxisCount: 3,
                    children: List.generate(
                        CardProvider().gridCardProviders.length, (index) {
                      final systemSettingsProvider =
                          Provider.of<SystemSettingProvider>(context,
                              listen: false);
                      return InkWell(
                        onTap: () {
                          switch (index) {
                            case 0:
                              if (systemSettingsProvider.systemSettingsModel
                                      ?.siteSetting.clockIn.enable ??
                                  false) {
                                onSystemSettingsDialogue(context);
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ClockInHomeScreen()));
                              }
                              break;
                            case 1:
                              if (systemSettingsProvider.systemSettingsModel
                                      ?.siteSetting.mySchedule.enable ??
                                  false) {
                                onSystemSettingsDialogue(context);
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyScheduleHomeScreen()));
                              }
                              break;
                            case 2:
                              if (systemSettingsProvider.systemSettingsModel
                                      ?.siteSetting.shiftAvailability.enable ??
                                  false) {
                                onSystemSettingsDialogue(context);
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ShiftAvailabilityHome()));
                              }
                              break;
                            case 3:
                              if (systemSettingsProvider.systemSettingsModel
                                      ?.siteSetting.priorClockIn.enable ??
                                  false) {
                                onSystemSettingsDialogue(context);
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PriorClockInHomeScreen()));
                              }
                              break;
                            case 4:
                              if (systemSettingsProvider.systemSettingsModel
                                      ?.siteSetting.lookingForShift.enable ??
                                  false) {
                                onSystemSettingsDialogue(context);
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LookingForShiftHomeScreen()));
                              }
                              break;
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 23, vertical: 19),
                                child: Image.asset(CardProvider()
                                    .gridCardProviders[index]
                                    .asset),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              CardProvider().gridCardProviders[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                // child: DashBoardGrid(),
              ),
              DashBoardNavigatorCard(),
            ],
          ),
        ),
      ),
    );
  }

  void onSystemSettingsDialogue(BuildContext context) {
    DialogueUtils.onSystemSettingsDialogue(
      context: context,
    );
  }
}
