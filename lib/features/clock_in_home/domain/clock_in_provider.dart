import 'dart:convert';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/clock_in_home/data/clock_in_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/data/no_meal_reason_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/domain/clock_in_repo.dart';
import 'package:flutter/cupertino.dart';

class CLockInProvider extends ChangeNotifier{
  final int dcId;
  CLockInProvider(this.dcId);

  final ClockInRepo _clockInRepo = ClockInRepo();
  final NoMealReasonRepo _noMealReasonRepo = NoMealReasonRepo();
  bool isDataFetching = false;
  ClockInResponseModel? clockInResponseModel;
  NoMealReasonResponseModel? noMealReasonResponseModel;

  void setLoading(bool val) {
    isDataFetching = val;
    futureNotifyListeners();
  }
  Future<BMSResponse<ClockInResponseModel>> getClockInList() async {
    setLoading(true);
      await _clockInRepo.post(
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            // networkState: networkState,
            onLoadedState: (loadedState) async{
              onFutureNotifyListeners(() {
                final Map<String,dynamic> _map = loadedState.response?.body;
                 clockInResponseModel =
                clockInResponseModelFromJson(jsonEncode(_map['response']));
              });
             await getNoMealReasonList();
            },
            onErrorState: (errorState) {
              clockInResponseModel?.data=null;
              onFutureNotifyListeners(() {
                // loadedPostModel = errorState.response?.body;
              });
            },
            onLoadingState: (loadingState) {
            },
          );
        }, body: {
        'dcId': dcId.toString(),
      },
      );

    setLoading(false);
    return BMSResponse(body: clockInResponseModel);
  }

  Future<BMSResponse<NoMealReasonResponseModel>> getNoMealReasonList() async {
    setLoading(true);
      await _noMealReasonRepo.fetch(
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            // networkState: networkState,
            onLoadedState: (loadedState) {
              // onFutureNotifyListeners(() {
                final Map<String,dynamic> _map = loadedState.response?.body;
                noMealReasonResponseModel =
                noMealReasonResponseModelFromJson(jsonEncode(_map['response']));
              // });
            },
            onErrorState: (errorState) {
              noMealReasonResponseModel?.data=null;

            },
            onLoadingState: (loadingState) {
            },
          );
        },
      );

    setLoading(false);
    return BMSResponse(body: noMealReasonResponseModel);
  }





}