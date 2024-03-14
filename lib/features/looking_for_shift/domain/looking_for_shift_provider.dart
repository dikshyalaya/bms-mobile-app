import 'dart:convert';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/looking_for_shift/data/schedule_period_response_model.dart';
import 'package:beacon_flutter/features/looking_for_shift/domain/looking_for_shift_repo.dart';
import 'package:flutter/cupertino.dart';

class LookingForShiftProvider extends ChangeNotifier{

  bool isDataFetching = false;
  SchedulePeriodResponseModel? _schedulePeriodResponseModel;



  final SchedulePeriodRepo _schedulePeriodRepo =SchedulePeriodRepo();

  void setLoading(bool val) {
    isDataFetching = val;
    futureNotifyListeners();
  }
  SchedulePeriodResponseModel? get schedulePeriodResponseModel =>
      _schedulePeriodResponseModel;

  set schedulePeriodResponseModel(SchedulePeriodResponseModel? value) {
    _schedulePeriodResponseModel = value;
  }

  Future<BMSResponse<SchedulePeriodResponseModel>> getAllSchedulePeriods() async {
    await _schedulePeriodRepo.fetch(
        params: {

        },
        apiCallback: (networkState) {
          onApiCallback<dynamic>(
            networkState: networkState,
            // networkState: networkState,
            onLoadedState: (loadedState) {
              onFutureNotifyListeners(() {
                final Map<String,dynamic> map = loadedState.response?.body;
                _schedulePeriodResponseModel =
                    schedulePeriodResponseModelFromJson(jsonEncode(map['response']));
              });
            },
            onErrorState: (errorState) {
              _schedulePeriodResponseModel?.data=null;
              onFutureNotifyListeners(() {
                // loadedPostModel = errorState.response?.body;
              });
            },
            onLoadingState: (loadingState) {
            },
          );
        }
    );
    return BMSResponse(body: _schedulePeriodResponseModel);
  }

}