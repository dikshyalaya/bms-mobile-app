import 'dart:convert';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/dashboard/data/incomplete_activities_model.dart';
import 'package:beacon_flutter/features/dashboard/domain/incomplete_activities_repo.dart';
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
  final Map<String,dynamic> map = loadedState.response?.body;
  incompleteActivitiesModel =
  incompleteActivitiesFromJson(jsonEncode(map['response']));
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