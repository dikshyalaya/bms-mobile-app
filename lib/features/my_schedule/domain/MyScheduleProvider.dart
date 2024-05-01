import 'dart:convert';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/login/src/login_screen.dart';
import 'package:beacon_flutter/features/my_schedule/data/AvailableShiftsForDCModel.dart';
import 'package:beacon_flutter/features/my_schedule/data/ListHouseForDCAddShiftModel.dart';
import 'package:beacon_flutter/features/my_schedule/domain/my_schedule_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyScheduleProvider extends ChangeNotifier {
  final int dcId;

  MyScheduleProvider(this.dcId);

  bool isDataFetching = false;
  bool isDataPosting = false;
  int selectedIndex = -1;

  AvailableShiftsForDcModel? _availableShiftsForDcModel;
  ListHouseForDcAddShiftModel? _listHouseForDCAddShiftModel;

  ListHouseForDcAddShiftModel? get listHouseForDCAddShiftModel =>
      _listHouseForDCAddShiftModel;

  set listHouseForDCAddShiftModel(ListHouseForDcAddShiftModel? value) {
    _listHouseForDCAddShiftModel = value;
  }

  AvailableShiftsForDcModel get availableShiftsForDcModel =>
      _availableShiftsForDcModel ?? AvailableShiftsForDcModel();

  set availableShiftsForDcModel(AvailableShiftsForDcModel value) {
    _availableShiftsForDcModel = value;
  }

  void setLoading(bool val) {
    isDataFetching = val;
    futureNotifyListeners();
  }

  void setDataPosting(bool val) {
    isDataPosting = val;
    futureNotifyListeners();
  }

  Future<BMSResponse<AvailableShiftsForDcModel>>
      getAvailableShiftsForDcModel() async {
    final MyScheduleRepo availableShiftRepo =
        MyScheduleRepo(dcId.toString());
    setLoading(true);
    await availableShiftRepo.fetch(
        params: {},
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            // networkState: networkState,
            onLoadedState: (loadedState) {
              onFutureNotifyListeners(() {
                final Map<String, dynamic> map = loadedState.response?.body;
                availableShiftsForDcModel = availableShiftsForDcModelFromJson(
                    jsonEncode(map['response']));
              });
            },
            onErrorState: (errorState) {
              availableShiftsForDcModel.data = null;
              onFutureNotifyListeners(() {
                // loadedPostModel = errorState.response?.body;
              });
            },
            onLoadingState: (loadingState) {},
          );
        });
    setLoading(false);
    return BMSResponse(body: availableShiftsForDcModel);
  }

  void cancelShift(int shiftId,Function onFinished) async {
    setDataPosting(true);

    final CancelShiftRepo cancelShiftRepo = CancelShiftRepo(shiftId);
    await cancelShiftRepo.fetch(apiCallback: (networkState) {
      onApiCallback<dynamic>(
        networkState: networkState,
        onLoadedState: (loadedState) {
          Fluttertoast.showToast(msg: "Successfully cancelled the shift");
          onFinished.call();
        },
        onErrorState: (errorState) {
          shoErrorToast(errorState.message);
        },
        onLoadingState: (loadingState) {},
      );
    });
    setDataPosting(false);
  }



  Future<BMSResponse<ListHouseForDcAddShiftModel>>
      getListHouseForDCAddShift() async {
    final ListHouseForDCAddShiftRepo listHouseForDCAddShiftRepo =
        ListHouseForDCAddShiftRepo();
    setLoading(true);
    await listHouseForDCAddShiftRepo.fetch(
        params: {},
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            onLoadedState: (loadedState) {
              onFutureNotifyListeners(() {
                final Map<String, dynamic> map = loadedState.response?.body;
                listHouseForDCAddShiftModel =
                    listHouseForDcAddShiftModelFromJson(
                        jsonEncode(map['response']));
              });
            },
            onErrorState: (errorState) {
              listHouseForDCAddShiftModel?.data = null;
              onFutureNotifyListeners(() {});
            },
            onLoadingState: (loadingState) {},
          );
        });
    setLoading(false);
    return BMSResponse(body: listHouseForDCAddShiftModel);
  }

  Future<void> createShift(String scheduledDate,String startDate,String endDate,int houseId,Function(bool)isCreated) async{
    CreateShiftRepo createShiftRepo = CreateShiftRepo();
    setDataPosting(true);

    DateTime tempSceduleDate = DateTime.parse(scheduledDate);
    if(startDate.contains("PM")){
      int tempStartTime = int.parse(startDate.split(":").first);
      tempStartTime= 12+tempStartTime;
      startDate = "$tempStartTime:${startDate.split(":").last}";
      tempSceduleDate= tempSceduleDate.add(const Duration(days: 1));
    }

    if(endDate.contains("PM")){
      int tempEndTime = int.parse(endDate.split(":").first);
      tempEndTime= 12+tempEndTime;
      endDate = "$endDate:${endDate.split(":").last}";
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
              shoErrorToast(
                  "Something went wrong, Please try again later.");

              setDataPosting(false);
            },
            onLoadingState: (loadingState) {},
          );
        },
        body: {
          "houseId": houseId,
          "dcId": dcId,
          "scheduleDate": scheduledDate.substring(0,10),
          "startDateTime": '${scheduledDate.substring(0,10)}T${startDate.split(" ").first}',
          "endDateTime": '${tempSceduleDate.toString().substring(0,10)}T${endDate.split(" ").first}'

        });
    isCreated.call(false);

    setDataPosting(false);

  }

  void notify(){
    futureNotifyListeners();
  }
}
