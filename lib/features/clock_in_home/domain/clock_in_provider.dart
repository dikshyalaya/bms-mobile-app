import 'dart:convert';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/clock_in_home/data/clock_in_response_model.dart';
import 'package:beacon_flutter/features/clock_in_home/domain/clock_in_repo.dart';
import 'package:flutter/cupertino.dart';

class CLockInProvider extends ChangeNotifier{
  final int dcId;
  CLockInProvider(this.dcId);

  final ClockInRepo _clockInRepo = ClockInRepo();
  bool isDataFetching = false;
  ClockInResponseModel? clockInResponseModel;

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
            onLoadedState: (loadedState) {
              onFutureNotifyListeners(() {
                final Map<String,dynamic> _map = loadedState.response?.body;
                 clockInResponseModel =
                clockInResponseModelFromJson(jsonEncode(_map['response']));
              });
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





}