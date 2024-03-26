import 'package:beacon_flutter/core/network/network_extension.dart';
import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:beacon_flutter/features/clock_in_home/data/no_meal_reason_response_model.dart';
import 'package:beacon_flutter/features/manager_dashboard/data/manager_permission_model.dart';
import 'package:beacon_flutter/features/manager_dashboard/domain/manager_permission_repo.dart';
import 'package:flutter/cupertino.dart';

class ManagePermissionProvider extends ChangeNotifier{
  final ManagerPermissionRepo _managerPermissionRepo =ManagerPermissionRepo();
bool? isManagerPermitted;

  Future<void> getManagerPermission() async {
    await _managerPermissionRepo.fetch(
      apiCallback: (networkState) {
        onApiCallback<dynamic>(
          networkState: networkState,
          onLoadedState: (loadedState) {
            onFutureNotifyListeners(() {
            final Map<String,dynamic> _map = loadedState.response?.body;
          isManagerPermitted = _map['response']["data"]["allowManagerApproval"]==1;
            });
          },
          onErrorState: (errorState) {
            getManagerPermission();
          },
          onLoadingState: (loadingState) {
          },
        );
      },
    );


  }

}