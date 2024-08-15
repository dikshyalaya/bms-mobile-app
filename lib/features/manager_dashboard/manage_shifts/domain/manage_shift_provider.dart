import 'dart:developer';

import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/data/active_house_for_manager_model.dart'
    as house;
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/data/manager_active_shift_model.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/data/schedule_period_model.dart'
    as period;
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/domain/manage_shift_repo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManageShiftProvider extends ChangeNotifier {
  List<String> shiftStatus = ["All", "Open", "Closed"];
  List<String> dateOptions = [];
  List<String> shiftTime = [
    "8:00 AM - 3:00 PM",
    "3:00 PM - 10:00 PM",
    "10:00 PM - 8:00 AM",
    "Add Custom Shift"
  ];
  String? startTime;
  String? endTime;
  String day = '';
  List<String> requestedType = [];
  List<String> requestedDSP = [];

  String selectedShiftType = "All";
  period.Datum? selectedShiftPeriod;
  house.Datum? selectedHouse;
  String? selectedDate;
  String? selectedShiftTime;
  String? selectedRequestedType;
  String? selectedRequestedDSP;

  bool isLoadingShifts = false;

  period.SchedulePeriodModel? schedulePeriodModel;
  house.ActiveHouseForManagerModel? activeHouseForManagerModel;
  ManagerActiveShiftModel? managerActiveShiftModel;

  //Get Schedule Period by Shift Type
  Future<void> getSchedulePeriod() async {
    ManagerSchedulePeriodRepo schedulePeriodRepo = ManagerSchedulePeriodRepo();
    await schedulePeriodRepo.post(
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            onFutureNotifyListeners(() {
              final Map<String, dynamic> map = loadedState.response?.body;
              final response = map['response'];
              schedulePeriodModel =
                  period.SchedulePeriodModel.fromJson(response);
              notifyListeners();
            });
          },
          onErrorState: (errorState) {
            // getManagerPermission();
          },
          onLoadingState: (loadingState) {},
        );
      },
      body: {
        "shiftType": "${getShiftStatus(selectedShiftType)}",
        "recordFor": "week",
      },
    );
    notifyListeners();
  }

  //Get Active House for Manager with schedule period
  Future<void> getActiveHouseForManager() async {
    ActiveHouseForManagerRepo activeHouseForManagerRepo =
        ActiveHouseForManagerRepo();
    await activeHouseForManagerRepo.post(
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            onFutureNotifyListeners(() {
              final Map<String, dynamic> map = loadedState.response?.body;
              final response = map['response'];
              activeHouseForManagerModel =
                  house.ActiveHouseForManagerModel.fromJson(response);
              notifyListeners();
            });
          },
          onErrorState: (errorState) {
            // getManagerPermission();
          },
          onLoadingState: (loadingState) {},
        );
      },
      body: {
        "shiftType": "${getShiftStatus(selectedShiftType)}",
        "recordFor": "house",
        "schedulePeriod": selectedShiftPeriod?.schedulePeriod,
      },
    );
    notifyListeners();
  }

  //Get Active House for Manager with schedule period
  Future<void> getManagerActiveShifts() async {
    isLoadingShifts = true;
    notifyListeners();
    ManagerActiveShiftRepo managerActiveShiftRepo = ManagerActiveShiftRepo();
    await managerActiveShiftRepo.post(
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            onFutureNotifyListeners(() {
              final Map<String, dynamic> map = loadedState.response?.body;
              final response = map['response'];
              managerActiveShiftModel =
                  ManagerActiveShiftModel.fromJson(response);
              log("ManagerActiveShiftModel: ${managerActiveShiftModel?.data?.length}");
              isLoadingShifts = false;
              notifyListeners();
            });
          },
          onErrorState: (errorState) {
            // getManagerPermission();
          },
          onLoadingState: (loadingState) {},
        );
      },
      body: {
        "shiftType": "${getShiftStatus(selectedShiftType)}",
        "schedulePeriod": selectedShiftPeriod?.schedulePeriod,
        "houseId": selectedHouse?.id,
      },
    );
    isLoadingShifts = false;
    notifyListeners();
  }

  //Get shift type ID
  getShiftStatus(String status) {
    switch (status.toLowerCase()) {
      case "open":
        return 0;
      case "closed":
        return 1;
      default:
        return -1;
    }
  }

  //Get date options for schedule period
  getdateOptions() {
    dateOptions = [];
    final initialDate = selectedShiftPeriod!.schedulePeriod?.split(" - ")[0];
    DateFormat dateFormat = DateFormat('M/d/yyyy');
    DateTime date = dateFormat.parse(initialDate!);
    for (int i = 0; i < 7; i++) {
      dateOptions.add(dateFormat.format(date));
      date = date.add(const Duration(days: 1));
    }
    log("Date: $dateOptions");

    notifyListeners();
  }
}
