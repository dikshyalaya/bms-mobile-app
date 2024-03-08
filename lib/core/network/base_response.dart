class BeaconBaseResponse<T> {
  final T? body;
  final Exception? exception;

  BeaconBaseResponse({this.body, this.exception});

  BeaconBaseResponse.onError(Exception exception)
      : body = null,
        exception = exception;
}
