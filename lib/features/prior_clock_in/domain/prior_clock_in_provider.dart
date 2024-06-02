import 'dart:convert';
import 'dart:developer';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/prior_clock_in/data/prior_cloc_in_response_model.dart';
import 'package:beacon_flutter/features/prior_clock_in/domain/prior_clock_in_repo.dart';
import 'package:flutter/cupertino.dart';

class PriorClockInProvider extends ChangeNotifier{
 
  PriorClockInProvider();
  bool isDataFetching = false;

  PriorClockInResponseModel? _priorClockInResponseModel;

  PriorClockInResponseModel? get priorClockInResponseModel =>
      _priorClockInResponseModel;

  set priorClockInResponseModel(PriorClockInResponseModel? value) {
    _priorClockInResponseModel = value;
  }

  void setLoading(bool val) {
    isDataFetching = val;
    futureNotifyListeners();
  }

  Future<BMSResponse<PriorClockInResponseModel>> getPriorClockInList() async {
    final PriorClockInRepo priorClockInRepo = PriorClockInRepo();
    setLoading(true);
    await priorClockInRepo.fetch(
      params: {

      },
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          // networkState: networkState,
          onLoadedState: (loadedState) {
             onFutureNotifyListeners(() {
              final Map<String, dynamic> map = loadedState.response?.body;
              log(map.toString()); // Log the entire map for debugging
              try {
                priorClockInResponseModel =
                    priorClockInResponseModelFromJson(jsonEncode(map['response']));
              } catch (e) {
                log("Error parsing JSON: $e");
              }
            });
          },
          onErrorState: (errorState) {
            _priorClockInResponseModel?.data=null;
            onFutureNotifyListeners(() {
              // loadedPostModel = errorState.response?.body;
            });
          },
          onLoadingState: (loadingState) {
          },
        );
      }
    );
    setLoading(false);
    return BMSResponse(body: priorClockInResponseModel);
  }

}