// ignore_for_file: constant_identifier_names

enum DataFetchState {
  IS_IDEAL,
  IS_LOADING,
  IS_LOADED,
  ERROR_ENCOUNTERED,
  NO_DATA,
  NOT_LOGIN
}

class NetworkState<T> {
  final DataFetchState state;
  final BMSResponse<T>? response;

  T? get value => response?.body;

  String get message => response?.exception?.message ?? "Something went wrong";

  NetworkState({required this.state, required this.response});

  NetworkState.loading([this.response]) : state = DataFetchState.IS_LOADING;

  NetworkState.loaded(BMSResponse<T> this.response)
      : state = DataFetchState.IS_LOADED;

  NetworkState.error(BMSResponse<T> this.response)
      : state = DataFetchState.ERROR_ENCOUNTERED;

  NetworkState.ideal()
      : response = null,
        state = DataFetchState.IS_IDEAL;

  NetworkState.notLogin()
      : response = null,
        state = DataFetchState.NOT_LOGIN;

  NetworkState.noData(BMSResponse<T> this.response)
      : state = DataFetchState.NO_DATA;

  NetworkState.clone(NetworkState networkState)
      : response = networkState.response as BMSResponse<T>?,
        state = networkState.state;
}

class BMSResponse<T> {
  T? body;
  BMSException? exception;

  BMSResponse({this.exception, this.body});

  BMSResponse.error({required this.exception}) : body = null;

  BMSResponse.response({required this.body}) : exception = null;
}

class BMSException implements Exception {
  String? message;

  BMSException([this.message = ""]);
}
