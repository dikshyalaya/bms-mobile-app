import 'package:beacon_flutter/core/network/network_state.dart';
import 'package:flutter/cupertino.dart';

dynamic importExtensions;

typedef LoadingStateCallback<T> = Function(NetworkState<T> loadingState);
typedef ErrorStateCallback<T> = Function(NetworkState<T> errorState);
typedef LoadedStateCallback<T> = Function(NetworkState<T> loadedState);
typedef ApiCallback<T> = void Function(NetworkState<T> networkState);

typedef IndexItem<T> = Function(int index, T item);

extension ChangengeNotifierExt on ChangeNotifier {
  void onFutureNotifyListeners(void Function() onNotify) {
    onNotify();
    futureNotifyListeners();
  }

  void futureNotifyListeners() {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    Future.delayed(Duration.zero, () => notifyListeners());
  }

  void onApiCallback<T>(
      {required NetworkState<T> networkState,
      required LoadingStateCallback<T>? onLoadingState,
      required ErrorStateCallback<T>? onErrorState,
      required LoadedStateCallback<T>? onLoadedState}) {
    if (networkState.state == DataFetchState.ERROR_ENCOUNTERED) {
      onErrorState?.call(networkState);
    } else if (networkState.state == DataFetchState.IS_LOADED) {
      onLoadedState?.call(networkState);
    } else if (networkState.state == DataFetchState.IS_LOADING) {
      onLoadingState?.call(networkState);
    }
  }
}
