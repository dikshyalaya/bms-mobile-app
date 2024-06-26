import 'package:beacon_flutter/features/auth/data/bms_user_model.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/features/clock_in_home/widget/clock_in_home_screen.dart';
import 'package:beacon_flutter/features/dashboard/domain/incomplete_activities_provider.dart';
import 'package:beacon_flutter/features/dashboard/domain/system_setting_provider.dart';
import 'package:beacon_flutter/features/dashboard/widget/dashboard_navigator_card.dart';
import 'package:beacon_flutter/features/get_device_size/get_device_size.dart';
import 'package:beacon_flutter/features/looking_for_shift/widget/looking_for_shift_home_screen.dart';
import 'package:beacon_flutter/features/my_schedule/widget/my_schedule_home.dart';
import 'package:beacon_flutter/features/prior_clock_in/widget/prior_clock_home_screen.dart';
import 'package:beacon_flutter/features/shift_availability/widget/shift_availavility_home.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/beacon_app_bar.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool value = isTablet(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 68),
          child: Selector<AuthProvider, BmsUserModel?>(
            selector: (context, provider) => provider.bmsUserModel,
            builder: (context, bmsUserModel, child) => BeaconAppBar(
              title:
                  "${bmsUserModel?.empFirstName} ${bmsUserModel?.empLastName}",
            ),
          )),
      // backgroundColor: const Color.fromARGB(0, 232, 10, 10),
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
                padding: EdgeInsets.only(
                    top: value ? 70.h : 20.h, left: 15.w, right: 15.w),
                child: GridView.count(
                  mainAxisSpacing: value ? 50 : 20,
                  crossAxisSpacing: value ? 110 : 0,
                  crossAxisCount: 3,
                  children: List.generate(
                      CardProvider().gridCardProviders.length, (index) {
                    final systemSettingsProvider =
                        Provider.of<SystemSettingProvider>(context,
                            listen: false);
                    final incompleteActivitiesProvider =
                        Provider.of<IncompleteActivitiesProvider>(context,
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
                                routeNavigation(
                                  context,
                                  const ClockInHomeScreen(),
                                );
                              }
                              break;
                            case 1:
                              if (systemSettingsProvider.systemSettingsModel
                                      ?.siteSetting.mySchedule.enable ??
                                  false) {
                                onSystemSettingsDialogue(context);
                              } else {
                                routeNavigation(
                                  context,
                                  const MyScheduleHomeScreen(),
                                );
                              }
                              break;
                            case 2:
                              if (systemSettingsProvider.systemSettingsModel
                                      ?.siteSetting.shiftAvailability.enable ??
                                  false) {
                                onSystemSettingsDialogue(context);
                              } else {
                                routeNavigation(
                                  context,
                                  const ShiftAvailabilityHome(),
                                );
                              }
                              break;
                            case 3:
                              if (systemSettingsProvider.systemSettingsModel
                                      ?.siteSetting.priorClockIn.enable ??
                                  false) {
                                onSystemSettingsDialogue(context);
                              } else {
                                routeNavigation(
                                  context,
                                  const PriorClockInHomeScreen(),
                                );
                              }
                              break;
                            case 4:
                              final totalPendingActivities =
                                  (incompleteActivitiesProvider
                                              .incompleteActivitiesModel
                                              ?.data
                                              ?.pendingClockIns
                                              .count ??
                                          0) +
                                      (incompleteActivitiesProvider
                                              .incompleteActivitiesModel
                                              ?.data
                                              ?.pendingInvites
                                              .count ??
                                          0);

                              if (systemSettingsProvider.systemSettingsModel
                                      ?.siteSetting.lookingForShift.enable ??
                                  false) {
                                if (totalPendingActivities > 0) {
                                  onSystemSettingsDialogue(context);
                                } else {
                                  routeNavigation(
                                    context,
                                    const LookingForShiftHomeScreen(),
                                  );
                                }
                              } else {
                                routeNavigation(
                                  context,
                                  const LookingForShiftHomeScreen(),
                                );
                              }
                              break;
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: value ? 100.h : 90.h,
                              width: value ? 100.w : 90.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 20.h),
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
                                    fontSize: value ? 8.sp : 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ));
                  }),
                ),
              ),
              // child: DashBoardGrid(),
            ),
            DashBoardNavigatorCard(
              isFromPopUp: false,
            ),
          ],
        ),
      ),
    );
  }

  void onSystemSettingsDialogue(
    BuildContext context,
  ) {
    DialogueUtils.onSystemSettingsDialogue(
      context: context,
    );
  }

  routeNavigation(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
}
