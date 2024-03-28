import 'dart:convert';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/dashboard/data/IncompleteActivitiesModel.dart';
import 'package:beacon_flutter/features/dashboard/domain/IncompleteActivitiesRepo.dart';
import 'package:flutter/cupertino.dart';

class IncompleteActivitiesProvider extends ChangeNotifier{
  final IncompleteActivitiesRepo _incompleteActivitiesRepo = IncompleteActivitiesRepo();
  bool isDataFetching = false;
  IncompleteActivitiesModel? incompleteActivitiesModel;

  void setLoading(bool val) {
  isDataFetching = val;
  futureNotifyListeners();
  }
  Future<BMSResponse<IncompleteActivitiesModel>> getIncompleteActivities() async {
  setLoading(true);
  await _incompleteActivitiesRepo.post(
  apiCallback: (networkState) {
  onApiCallback<dynamic>(
  networkState: networkState,
  // networkState: networkState,
  onLoadedState: (loadedState) async{
  onFutureNotifyListeners(() {
  final Map<String,dynamic> _map = loadedState.response?.body;
  incompleteActivitiesModel =
  incompleteActivitiesFromJson(jsonEncode(_map['response']));
  });
  },
  onErrorState: (errorState) {
    incompleteActivitiesModel?.data=null;
  onFutureNotifyListeners(() {
  // loadedPostModel = errorState.response?.body;
  });
  },
  onLoadingState: (loadingState) {
  },
  );
  }, body: {
    "shiftAccpetedInLastNDays":30,
    "includeShiftData": false
  },
  );

  setLoading(false);
  return BMSResponse(body: incompleteActivitiesModel);
  }







}