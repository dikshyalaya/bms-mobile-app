// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/clock_in_home/data/clock_in_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/data/no_meal_reason_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/domain/clock_in_repo.dart';
import 'package:beacon_flutter/location_denied_alert_diaouge_box.dart';
import 'package:beacon_flutter/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class CLockInProvider extends ChangeNotifier {
  final int dcId;

  CLockInProvider(this.dcId);

  final ClockInRepo _clockInRepo = ClockInRepo();
  final NoMealReasonRepo _noMealReasonRepo = NoMealReasonRepo();
  final PunchInRepo _punchInRepo = PunchInRepo();
  bool isDataFetching = false;
  ClockInResponseModel? clockInResponseModel;
  NoMealReasonResponseModel? noMealReasonResponseModel;
  bool isDataPosting = false;

  void setLoading(bool val) {
    isDataFetching = val;
    futureNotifyListeners();
  }

  void setDataPosting(bool val) {
    isDataPosting = val;
    futureNotifyListeners();
  }

  Future<BMSResponse<ClockInResponseModel>> getClockInList() async {
    setLoading(true);
    await _clockInRepo.post(
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          // networkState: networkState,
          onLoadedState: (loadedState) async {
            onFutureNotifyListeners(() {
              final Map<String, dynamic> map = loadedState.response?.body;
              clockInResponseModel =
                  clockInResponseModelFromJson(jsonEncode(map['response']));
              log(map['response'].toString());
            });
            await getNoMealReasonList();
            log("No Meal Reasons API Called");
          },
          onErrorState: (errorState) {
            clockInResponseModel?.data = null;
            onFutureNotifyListeners(() {
              // loadedPostModel = errorState.response?.body;
            });
          },
          onLoadingState: (loadingState) {},
        );
      },
      body: {
        'dcId': dcId.toString(),
      },
    );

    setLoading(false);
    return BMSResponse(body: clockInResponseModel);
  }

  Future<BMSResponse<NoMealReasonResponseModel>> getNoMealReasonList() async {
    setLoading(true);
    noMealReasonResponseModel = null;
    await _noMealReasonRepo.fetch(
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          // networkState: networkState,
          onLoadedState: (loadedState) {
            // onFutureNotifyListeners(() {
            final Map<String, dynamic> map = loadedState.response?.body;
            noMealReasonResponseModel =
                noMealReasonResponseModelFromJson(jsonEncode(map['response']));
            // });
          },
          onErrorState: (errorState) {
            noMealReasonResponseModel?.data = null;
          },
          onLoadingState: (loadingState) {},
        );
      },
    );

    setLoading(false);
    return BMSResponse(body: noMealReasonResponseModel);
  }

  void removeClockInListAfterCompleted(int shiftId) {
    if (clockInResponseModel != null &&
        clockInResponseModel!.data != null &&
        clockInResponseModel!.data!.isNotEmpty) {
      clockInResponseModel!.data!
          .removeWhere((element) => element.id == shiftId);
      log(clockInResponseModel!.data!.first.id.toString());
      log("Shift Removed Successfullt: $shiftId");
    }

    notifyListeners();
    log(clockInResponseModel!.data!.first.id.toString());
  }

  Future<void> punchIn(
    BuildContext context,
      int shiftId,
      String scheduleDate,
      String startTime,
      String endTime,
      String mealTime,
      String noMealReason,
      Function(bool) isCompleted,
      Function(bool) isLoaing) async {
      
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    await _punchInRepo.post(
      body: {
        "shiftId": shiftId,
        "scheduleDate": scheduleDate,
        "dcId": dcId,
        "actualStartTime": startTime,
        "actualEndTime": endTime,
        "mealTime": mealTime,
        "noMealReason": noMealReason,
        "location": {
          "latitude": position.latitude,
          "longitude": position.longitude
        }
      },
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          // networkState: networkState,
          onLoadedState: (loadedState) {
            setDataPosting(false);
            isCompleted.call(true);
            isLoaing.call(false);
          },
          onErrorState: (errorState) {
            shoErrorToast("Something went wrong, Please try again later.");
            isLoaing.call(false);

            setDataPosting(false);
          },
          onLoadingState: (loadingState) {
            isLoaing.call(true);
          },
        );
      },
    );
  }
}
