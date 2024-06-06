import 'dart:convert';
import 'dart:developer';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/my_schedule/data/available_shifts_for_dc_model.dart';
import 'package:beacon_flutter/features/my_schedule/data/house_workedin_last_three_weeks_model.dart';
import 'package:beacon_flutter/features/my_schedule/domain/my_schedule_repo.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:beacon_flutter/constants/enums.dart';

class MyScheduleProvider extends ChangeNotifier {
  final int dcId;

  MyScheduleProvider(this.dcId);

  bool isDataFetching = false;
  bool isHouseLoading = false;
  bool isDataPosting = false;
  int selectedIndex = -1;

  AvailableShiftsForDcModel? _availableShiftsForDcModel;
  HouseWorkedInLastThreeWeeksModel? _houseWorkedInLastThreeWeeksModel;

  HouseWorkedInLastThreeWeeksModel get houseWorkedinLastThreeWeeksModel =>
      _houseWorkedInLastThreeWeeksModel ?? HouseWorkedInLastThreeWeeksModel();

  set houseWorkedinLastThreeWeeksModel(
      HouseWorkedInLastThreeWeeksModel? value) {
    _houseWorkedInLastThreeWeeksModel = value;
  }

  AvailableShiftsForDcModel get availableShiftsForDcModel =>
      _availableShiftsForDcModel ?? AvailableShiftsForDcModel();

  set availableShiftsForDcModel(AvailableShiftsForDcModel value) {
    _availableShiftsForDcModel = value;
  }

  void setLoading(bool val) {
    isDataFetching = val;
    // futureNotifyListeners();
    notifyListeners();
  }

  void setDataPosting(bool val) {
    isDataPosting = val;
    futureNotifyListeners();
  }

  Future<BMSResponse<AvailableShiftsForDcModel>>
      getAvailableShiftsForDcModel() async {
    final MyScheduleRepo availableShiftRepo = MyScheduleRepo(dcId.toString());
    setLoading(true);
    await availableShiftRepo.fetch(
        params: {},
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            onLoadedState: (loadedState) {
              onFutureNotifyListeners(() {
                final Map<String, dynamic> map = loadedState.response?.body;
                log("Available Shifts for DC Model: ${jsonEncode(map['response'])}");
                _availableShiftsForDcModel = availableShiftsForDcModelFromJson(
                    jsonEncode(map['response']));
              });
            },
            onErrorState: (errorState) {
              _availableShiftsForDcModel?.data = null;
              onFutureNotifyListeners(() {
                setLoading(false);
              });
            },
            onLoadingState: (loadingState) {},
          );
        });
    await getHouseWorkedInLastThreeWeeks();
    setLoading(false);
    return BMSResponse(body: availableShiftsForDcModel);
  }

  void cancelShift(
      BuildContext context, int shiftId, Function onFinished) async {
    setDataPosting(true);

    final CancelShiftRepo cancelShiftRepo = CancelShiftRepo(shiftId);
    await cancelShiftRepo.fetch(apiCallback: (networkState) {
      onApiCallback<dynamic>(
        networkState: networkState,
        onLoadedState: (loadedState) {
          DialogueUtils.popUpMessageDialogue(
            // ignore: use_build_context_synchronously
            context: context,
            message: "Shift Cancelled Successfully.",
            popUpType: PopUpType.error,
          );
          onFinished.call();
        },
        onErrorState: (errorState) {
           DialogueUtils.popUpMessageDialogue(
            context: context,
            message: errorState.message,
            popUpType: PopUpType.error,
          );
        },
        onLoadingState: (loadingState) {},
      );
    });
    setDataPosting(false);
  }

  Future<BMSResponse<HouseWorkedInLastThreeWeeksModel>>
      getHouseWorkedInLastThreeWeeks() async {
    final HouseWorkedInLastThreeWeeksRepo houseWorkedInLastThreeWeeksRepo =
        HouseWorkedInLastThreeWeeksRepo();
    isHouseLoading = true;
    notifyListeners();
    await houseWorkedInLastThreeWeeksRepo.fetch(
        params: {},
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            onLoadedState: (loadedState) {
              onFutureNotifyListeners(() {
                final Map<String, dynamic> map = loadedState.response?.body;
                houseWorkedinLastThreeWeeksModel =
                    houseWorkedInLastThreeWeeksModelFromJson(
                        jsonEncode(map['response']));
              });
            },
            onErrorState: (errorState) {
              houseWorkedinLastThreeWeeksModel.data = null;
              onFutureNotifyListeners(() {});
            },
            onLoadingState: (loadingState) {},
          );
        });
    isHouseLoading = true;
    notifyListeners();
    return BMSResponse(body: houseWorkedinLastThreeWeeksModel);
  }

  Future<void> createShift(BuildContext context,String scheduledDate, String startTime,
      String endTime, int houseId, Function(bool) isCreated) async {
    CreateShiftRepo createShiftRepo = CreateShiftRepo();
    setDataPosting(true);

    DateTime tempSceduleDate = DateTime.parse(scheduledDate);
    if (startTime.contains("PM")) {
      int tempStartTime = int.parse(startTime.split(":").first);
      tempStartTime = 12 + tempStartTime;
      startTime = "$tempStartTime:${startTime.split(":").last}";
      tempSceduleDate = tempSceduleDate.add(const Duration(days: 1));
    }

    if (endTime.contains("PM")) {
      int tempEndTime = int.parse(endTime.split(":").first);
      tempEndTime = 12 + tempEndTime;
      endTime = "$endTime:${endTime.split(":").last}";
    }

    await createShiftRepo.post(
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            // networkState: networkState,
            onLoadedState: (loadedState) {
              isCreated.call(true);

              setDataPosting(false);
            },
            onErrorState: (errorState) {
               DialogueUtils.popUpMessageDialogue(
                context: context,
                message: errorState.message,
                popUpType: PopUpType.error,
              );

              setDataPosting(false);
            },
            onLoadingState: (loadingState) {},
          );
        },
        body: {
          "houseId": houseId,
          "dcId": dcId,
          "scheduleDate": scheduledDate.substring(0, 10),
          "startTime": startTime,
          // '${scheduledDate.substring(0, 10)}T${startDate.split(" ").first}',
          "endTime": endTime,
          // '${tempSceduleDate.toString().substring(0, 10)}T${endDate.split(" ").first}'
        });
    isCreated.call(false);

    setDataPosting(false);
  }

  void notify() {
    futureNotifyListeners();
  }
}
