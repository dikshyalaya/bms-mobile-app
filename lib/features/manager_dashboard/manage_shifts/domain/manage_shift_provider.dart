// import 'dart:developer';

// import 'package:beacon_flutter/core/network/network_extension.dart';
// import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/data/active_house_for_manager_model.dart'
//     as house;
// import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/data/manager_active_shift_model.dart';
// import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/data/schedule_period_model.dart'
//     as period;
// import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/domain/manage_shift_repo.dart';
// import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/model/manage_shift_shift_model.dart';
// import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/model/requested_dsp_model.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ManageShiftProvider extends ChangeNotifier {
//   List<String> shiftStatus = ["All", "Open", "Closed"];
//   List<String> dateOptions = [];
//   List<String> shiftTime = [
//     "8:00 AM - 3:00 PM",
//     "3:00 PM - 10:00 PM",
//     "10:00 PM - 8:00 AM",
//     "Add Custom Shift"
//   ];
//   String? startTime;
//   String? endTime;
//   String day = '';
//   List<String> requestedType = [
//     "Any",
//     "Male",
//     "Female",
//     "Maintenance",
//     "Driver"
//   ];
//   List<String> requestedDSP = [];

//   String selectedShiftType = "All";
//   period.Datum? selectedShiftPeriod;
//   house.Datum? selectedHouse;
//   String? selectedDate;
//   dynamic selectedShiftTime;
//   String? selectedRequestedType;
//   dynamic? selectedRequestedDSP;

//   bool isLoadingShifts = false;
//   bool isLoadingAllShifts = false;
//   bool isLoadingforRequestedDsp = false;

//   bool isLoadingActiveHouse = false;

//   period.SchedulePeriodModel? schedulePeriodModel;
//   ShiftForAddShiftModel? allShiftForAddShiftModel;
//   RequestedDspModel? allRequestedDspModel;

//   house.ActiveHouseForManagerModel? activeHouseForManagerModel;
//   ManagerActiveShiftModel? managerActiveShiftModel;

//   //Get Schedule Period by Shift Type
//   Future<void> getSchedulePeriod() async {
//     ManagerSchedulePeriodRepo schedulePeriodRepo = ManagerSchedulePeriodRepo();
//     await schedulePeriodRepo.post(
//       apiCallback: (networkState) {
//         onApiCallback<dynamic>(
//           networkState: networkState,
//           onLoadedState: (loadedState) {
//             onFutureNotifyListeners(() {
//               final Map<String, dynamic> map = loadedState.response?.body;
//               final response = map['response'];
//               schedulePeriodModel =
//                   period.SchedulePeriodModel.fromJson(response);
//               notifyListeners();
//             });
//           },
//           onErrorState: (errorState) {
//             // getManagerPermission();
//           },
//           onLoadingState: (loadingState) {
//             bool isActiveHouse = false;
//           },
//         );
//       },
//       body: {
//         "shiftType": "${getShiftStatus(selectedShiftType)}",
//         "recordFor": "week",
//       },
//     );
//     notifyListeners();
//   }

//   //Get Active House for Manager with schedule period
//   Future<void> getActiveHouseForManager() async {
//     isLoadingActiveHouse = true;
//     notifyListeners(); // Notify listeners that loading has started
//     ActiveHouseForManagerRepo activeHouseForManagerRepo =
//         ActiveHouseForManagerRepo();
//     await activeHouseForManagerRepo.post(
//       apiCallback: (networkState) {
//         onApiCallback<dynamic>(
//           networkState: networkState,
//           onLoadedState: (loadedState) {
//             onFutureNotifyListeners(() {
//               final Map<String, dynamic> map = loadedState.response?.body;
//               final response = map['response'];
//               activeHouseForManagerModel =
//                   house.ActiveHouseForManagerModel.fromJson(response);
//               notifyListeners();
//             });
//           },
//           onErrorState: (errorState) {
//             // getManagerPermission();
//           },
//           onLoadingState: (loadingState) {},
//         );
//       },
//       body: {
//         "shiftType": "${getShiftStatus(selectedShiftType)}",
//         "recordFor": "house",
//         "schedulePeriod": selectedShiftPeriod?.schedulePeriod,
//       },
//     );
//     isLoadingActiveHouse = false;
//     notifyListeners();
//   }

//   //Get Active House for Manager with schedule period
//   Future<void> getManagerActiveShifts() async {
//     isLoadingShifts = true;
//     notifyListeners();
//     ManagerActiveShiftRepo managerActiveShiftRepo = ManagerActiveShiftRepo();
//     await managerActiveShiftRepo.post(
//       apiCallback: (networkState) {
//         onApiCallback<dynamic>(
//           networkState: networkState,
//           onLoadedState: (loadedState) {
//             onFutureNotifyListeners(() {
//               final Map<String, dynamic> map = loadedState.response?.body;
//               final response = map['response'];
//               managerActiveShiftModel =
//                   ManagerActiveShiftModel.fromJson(response);
//               log("ManagerActiveShiftModel: ${managerActiveShiftModel?.data?.length}");
//               isLoadingShifts = false;
//               notifyListeners();
//             });
//           },
//           onErrorState: (errorState) {
//             // getManagerPermission();
//           },
//           onLoadingState: (loadingState) {},
//         );
//       },
//       body: {
//         "shiftType": "${getShiftStatus(selectedShiftType)}",
//         "schedulePeriod": selectedShiftPeriod?.schedulePeriod,
//         "houseId": selectedHouse?.id,
//       },
//     );
//     isLoadingShifts = false;
//     notifyListeners();
//   }

//   //Get shift type ID
//   getShiftStatus(String status) {
//     switch (status.toLowerCase()) {
//       case "open":
//         return 0;
//       case "closed":
//         return 1;
//       default:
//         return -1;
//     }
//   }

//   //Get date options for schedule period
//   getdateOptions() {
//     dateOptions = [];
//     final initialDate = selectedShiftPeriod!.schedulePeriod?.split(" - ")[0];
//     DateFormat dateFormat = DateFormat('M/d/yyyy');
//     DateTime date = dateFormat.parse(initialDate!);
//     for (int i = 0; i < 7; i++) {
//       dateOptions.add(dateFormat.format(date));
//       date = date.add(const Duration(days: 1));
//     }
//     log("Date: $dateOptions");

//     notifyListeners();
//   }

//   //Get Shift Type for Add Shift
//   Future<void> getShiftForAllShift() async {
//     isLoadingAllShifts = true;
//     notifyListeners(); // Notify listeners that loading has started
//     AddShiftForManagerShiftListRepo allShiftListForAddShiftForManagerRepo =
//         AddShiftForManagerShiftListRepo();
//     await allShiftListForAddShiftForManagerRepo.post(
//       apiCallback: (networkState) {
//         onApiCallback<dynamic>(
//           networkState: networkState,
//           onLoadedState: (loadedState) {
//             onFutureNotifyListeners(() {
//               final Map<String, dynamic> map = loadedState.response?.body;
//               final response = map['response'];
//               allShiftForAddShiftModel =
//                   ShiftForAddShiftModel.fromJson(response);
//               notifyListeners();
//             });
//           },
//           onErrorState: (errorState) {
//             // getManagerPermission();
//           },
//           onLoadingState: (loadingState) {
//             // bool isActiveHouse = false;
//           },
//         );
//       },
//       body: {
//         "houseId": selectedHouse?.id,
//       },
//     );
//     isLoadingAllShifts = false;
//     notifyListeners();
//   }

//   // Determine the day(s) based on selected shift and times
//   String getShiftDays() {
//     if (selectedDate == null ||
//         (selectedShiftTime == null && startTime == null && endTime == null)) {
//       return "";
//     }

//     // DateTime selectedDateTime = DateFormat('yyyy-MM-dd').parse(selectedDate!);
//     DateTime selectedDateTime = DateFormat('M/d/yyyy').parse(selectedDate!);

//     String startDay = DateFormat('E').format(selectedDateTime);
//     String endDay = startDay;

//     if (selectedShiftTime is DatumForAllShift) {
//       // Assuming shiftStartTime and shiftEndTime are in 24-hour format
//       DateTime shiftStart =
//           DateFormat('HH:mm').parse(selectedShiftTime.shiftStartTime);
//       DateTime shiftEnd =
//           DateFormat('HH:mm').parse(selectedShiftTime.shiftEndTime);

//       if (shiftStart.isAfter(shiftEnd)) {
//         endDay = DateFormat('E')
//             .format(selectedDateTime.add(const Duration(days: 1)));
//       }
//     } else if (startTime != null && endTime != null) {
//       DateTime shiftStart = DateFormat('HH:mm').parse(startTime!);
//       DateTime shiftEnd = DateFormat('HH:mm').parse(endTime!);

//       if (shiftStart.isAfter(shiftEnd)) {
//         endDay = DateFormat('E')
//             .format(selectedDateTime.add(const Duration(days: 1)));
//       }
//     }

//     return "$startDay - $endDay";
//   }

//   //Get requested dsp
//   Future<void> getRequestedDsp(String val) async {
//     isLoadingforRequestedDsp = true;
//     notifyListeners(); // Notify listeners that loading has started
//     GetRequestedDspRepo allRequestedDspRepo = GetRequestedDspRepo();
//     await allRequestedDspRepo.post(
//       apiCallback: (networkState) {
//         onApiCallback<dynamic>(
//           networkState: networkState,
//           onLoadedState: (loadedState) {
//             onFutureNotifyListeners(() {
//               final Map<String, dynamic> map = loadedState.response?.body;
//               final response = map['response'];
//               allRequestedDspModel = RequestedDspModel.fromJson(response);
//               notifyListeners();
//             });
//           },
//           onErrorState: (errorState) {
//             // getManagerPermission();
//           },
//           onLoadingState: (loadingState) {
//             // bool isActiveHouse = false;
//           },
//         );
//       },
//       body: {
//         "type": selectedRequestedType,
//         "houseId": selectedHouse?.id,
//         "schedulePeriod": selectedShiftPeriod?.schedulePeriod ?? "",
//         "scheduleDate": selectedDate,
//         "startTime": selectedShiftTime == 'Add Custom Shift'
//             ? startTime
//             : selectedShiftTime.shiftStartTime,
//         "endTime": selectedShiftTime == 'Add Custom Shift'
//             ? startTime
//             : selectedShiftTime.shiftEndTime,
//         "keyword": val,
//         "classPage": "0"
//       },
//     );
//     isLoadingforRequestedDsp = false;
//     notifyListeners();
//   }
// }

import 'dart:developer';
import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/data/active_house_for_manager_model.dart'
    as house;
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/data/manager_active_shift_model.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/data/schedule_period_model.dart'
    as period;
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/domain/manage_shift_repo.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/model/manage_shift_shift_model.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/model/requested_dsp_model.dart';
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
  List<String> requestedType = [
    "Any",
    "Male",
    "Female",
    "Maintenance",
    "Driver"
  ];
  List<String> requestedDSP = [];

  String selectedShiftType = "All";
  period.Datum? selectedShiftPeriod;
  house.Datum? selectedHouse;
  String? selectedDate;
  dynamic selectedShiftTime;
  String? selectedRequestedType;
  dynamic selectedRequestedDSP;

  bool isLoadingShifts = false;
  bool isLoadingAllShifts = false;
  bool isLoadingforRequestedDsp = false;

  bool isLoadingActiveHouse = false;

  period.SchedulePeriodModel? schedulePeriodModel;
  ShiftForAddShiftModel? allShiftForAddShiftModel;
  RequestedDspModel? allRequestedDspModel;

  house.ActiveHouseForManagerModel? activeHouseForManagerModel;
  ManagerActiveShiftModel? managerActiveShiftModel;

  // ValueNotifier for dynamic dropdown updates
  ValueNotifier<List<RequestedDspModel>> requestedDspNotifier =
      ValueNotifier([]);

  // Get Schedule Period by Shift Type
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
            // Handle error
          },
          onLoadingState: (loadingState) {
            // Handle loading state
          },
        );
      },
      body: {
        "shiftType": "${getShiftStatus(selectedShiftType)}",
        "recordFor": "week",
      },
    );
    notifyListeners();
  }

  // Get Active House for Manager with schedule period
  Future<void> getActiveHouseForManager() async {
    isLoadingActiveHouse = true;
    notifyListeners();
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
            // Handle error
          },
          onLoadingState: (loadingState) {
            // Handle loading state
          },
        );
      },
      body: {
        "shiftType": "${getShiftStatus(selectedShiftType)}",
        "recordFor": "house",
        "schedulePeriod": selectedShiftPeriod?.schedulePeriod,
      },
    );
    isLoadingActiveHouse = false;
    notifyListeners();
  }

  // Get Manager Active Shifts
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
            // Handle error
          },
          onLoadingState: (loadingState) {
            // Handle loading state
          },
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

  // Get Shift Status
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

  // Get Date Options for Schedule Period
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

  // Get Shift Type for Add Shift
  Future<void> getShiftForAllShift() async {
    isLoadingAllShifts = true;
    notifyListeners();
    AddShiftForManagerShiftListRepo allShiftListForAddShiftForManagerRepo =
        AddShiftForManagerShiftListRepo();
    await allShiftListForAddShiftForManagerRepo.post(
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            onFutureNotifyListeners(() {
              final Map<String, dynamic> map = loadedState.response?.body;
              final response = map['response'];
              allShiftForAddShiftModel =
                  ShiftForAddShiftModel.fromJson(response);
              notifyListeners();
            });
          },
          onErrorState: (errorState) {
            // Handle error
          },
          onLoadingState: (loadingState) {
            // Handle loading state
          },
        );
      },
      body: {
        "houseId": selectedHouse?.id,
      },
    );
    isLoadingAllShifts = false;
    notifyListeners();
  }

  // Determine the Day(s) Based on Selected Shift and Times
  String getShiftDays() {
    if (selectedDate == null ||
        (selectedShiftTime == null && startTime == null && endTime == null)) {
      return "";
    }

    DateTime selectedDateTime = DateFormat('M/d/yyyy').parse(selectedDate!);
    String startDay = DateFormat('E').format(selectedDateTime);
    String endDay = startDay;

    if (selectedShiftTime is DatumForAllShift) {
      DateTime shiftStart =
          DateFormat('HH:mm').parse(selectedShiftTime.shiftStartTime);
      DateTime shiftEnd =
          DateFormat('HH:mm').parse(selectedShiftTime.shiftEndTime);

      if (shiftStart.isAfter(shiftEnd)) {
        endDay = DateFormat('E')
            .format(selectedDateTime.add(const Duration(days: 1)));
      }
    } else if (startTime != null && endTime != null) {
      DateTime shiftStart = DateFormat('HH:mm').parse(startTime!);
      DateTime shiftEnd = DateFormat('HH:mm').parse(endTime!);

      if (shiftStart.isAfter(shiftEnd)) {
        endDay = DateFormat('E')
            .format(selectedDateTime.add(const Duration(days: 1)));
      }
    }

    return "$startDay - $endDay";
  }

  // Get Requested DSP
//   Future<void> getRequestedDsp(String val) async {
//   isLoadingforRequestedDsp = true;
//   notifyListeners();
//   GetRequestedDspRepo allRequestedDspRepo = GetRequestedDspRepo();
//   await allRequestedDspRepo.post(
//     apiCallback: (networkState) {
//       onApiCallback<dynamic>(
//         networkState: networkState,
//         onLoadedState: (loadedState) {
//           onFutureNotifyListeners(() {
//             final Map<String, dynamic> map = loadedState.response?.body;
//             final response = map['response'];

//             // Ensure you correctly parse and convert the response to a List<RequestedDspModel>
//             if (response is List) {
//               List<RequestedDspModel> dspList = response.map((item) {
//                 return RequestedDspModel.fromJson(item as Map<String, dynamic>);
//               }).toList();
//               // Update ValueNotifier with the correctly typed list
//               requestedDspNotifier.value = dspList;
//             } else {
//               // Handle the case where response is not a List
//               requestedDspNotifier.value = [];
//             }
//             notifyListeners();
//           });
//         },
//         onErrorState: (errorState) {
//           // Handle error
//         },
//         onLoadingState: (loadingState) {
//           // Handle loading state
//         },
//       );
//     },
//     body: {
//       "type": selectedRequestedType,
//       "houseId": selectedHouse?.id,
//       "schedulePeriod": selectedShiftPeriod?.schedulePeriod ?? "",
//       "scheduleDate": selectedDate,
//       "startTime": selectedShiftTime == 'Add Custom Shift' ? startTime : selectedShiftTime.shiftStartTime,
//       "endTime": selectedShiftTime == 'Add Custom Shift' ? startTime : selectedShiftTime.shiftEndTime,
//       "keyword": val,
//       "classPage": "0"
//     },
//   );
//   isLoadingforRequestedDsp = false;
//   notifyListeners();
// }
  Future<void> getRequestedDsp(String val) async {
    isLoadingforRequestedDsp = true;
    notifyListeners();

    final GetRequestedDspRepo allRequestedDspRepo = GetRequestedDspRepo();
    await allRequestedDspRepo.post(
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            onFutureNotifyListeners(() {
              final Map<String, dynamic> map = loadedState.response?.body;
              final response = map['response'];

              if (response['success']) {
                // List<RequestedDspDatum> dspList = response.map((item) {
                //   return RequestedDspDatum.fromJson(item as Map<String, dynamic>);
                // }).toList();
                allRequestedDspModel = RequestedDspModel(
                  success: response['success'],
                  message: response['message'],
                  data: response['data'],
                  currentPage: response['currentPage'],
                  nextPage: response['nextPage'],
                  previousPage: response['previousPage'],
                  pageSize: response['pageSize'],
                );
              } else {
                allRequestedDspModel = RequestedDspModel(
                  success: false,
                  message: 'No data',
                  data: [],
                  currentPage: 0,
                  nextPage: null,
                  previousPage: null,
                  pageSize: 0,
                );
              }
              notifyListeners();
            });
          },
          onErrorState: (errorState) {
            // Handle error
            allRequestedDspModel = RequestedDspModel(
              success: false,
              message: errorState.message,
              data: [],
              currentPage: 0,
              nextPage: null,
              previousPage: null,
              pageSize: 0,
            );
            notifyListeners();
          },
          onLoadingState: (loadingState) {
            // Handle loading state
          },
        );
      },
      body: {
        "type": selectedRequestedType,
        "houseId": selectedHouse?.id,
        "schedulePeriod": selectedShiftPeriod?.schedulePeriod ?? "",
        "scheduleDate": selectedDate,
        "startTime": selectedShiftTime == 'Add Custom Shift'
            ? startTime
            : selectedShiftTime.shiftStartTime,
        "endTime": selectedShiftTime == 'Add Custom Shift'
            ? startTime
            : selectedShiftTime.shiftEndTime,
        "keyword": val,
        "classPage": "0"
      },
    );

    isLoadingforRequestedDsp = false;
    notifyListeners();
  }
}
