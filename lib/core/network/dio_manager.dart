import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioManager {
  static DioManager? _instance;

  static DioManager get instance => _instance ??= DioManager._init();

  final Dio _prodDio = Dio(BaseOptions(
    baseUrl: "baseUrl",
    connectTimeout: const Duration(seconds:15),
    receiveTimeout: const Duration(seconds:15),
    sendTimeout: const Duration(seconds:15),
  ));

  DioManager._init() {
    initDio(_prodDio);
  }

  void initDio(Dio dio) {
    dio.interceptors.add(TokenInterceptor());
    dio.interceptors.add(ErrorInterceptor());
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Dio getDio(BaseUrlType baseUrlType) {
    return _prodDio;
  }

  Future<Response<T>> get<T>(
      {required String path,
        shouldCache = false,
        BaseUrlType baseUrlType = BaseUrlType.DEFAULT}) async {
    if (shouldCache) {
      // Options _cacheOptions = buildCacheOptions(Duration(days: 3),
      //     maxStale: Duration(days: 5), forceRefresh: true);
      return await getDio(baseUrlType).get(path);
      // return await getDio(baseUrlType).get(path, options: _cacheOptions);
    } else {
      // final options = Options(headers: {"accessToken": accessToken});
      return await getDio(baseUrlType).get(path);
    }
  }

  Future<Response<T>> post<T>(
      {required String path,
        required Map<String, dynamic> jsonBody,
        BaseUrlType baseUrlType = BaseUrlType.DEFAULT}) async {
    return await getDio(baseUrlType).post(path, data: jsonBody);
  }

  Future<Response<T>> put<T>(
      {required String path,
        required Map<String, dynamic> jsonBody,
        BaseUrlType baseUrlType = BaseUrlType.DEFAULT}) async {
    return getDio(baseUrlType).patch(path, data: jsonBody);
  }

  Future<Response<T>> upload<T>(
      {required String path,
        required FormData formData,
        ProgressCallback? onSendProgress,
        BaseUrlType baseUrlType = BaseUrlType.DEFAULT}) async {
    return getDio(baseUrlType)
        .post(path, data: formData, onSendProgress: onSendProgress);
  }

  Future<Response<T>> update<T>(
      {required String path,
        required Map<String, dynamic> jsonBody,
        BaseUrlType baseUrlType = BaseUrlType.DEFAULT}) async {
    return getDio(baseUrlType).put(path, data: jsonBody);
  }

  Future<Response<T>> delete<T>(
      {required String path,
        required Map<String, dynamic> jsonBody,
        BaseUrlType baseUrlType = BaseUrlType.DEFAULT}) async {
    return await getDio(baseUrlType).delete(path, data: jsonBody);
  }
}

class TokenInterceptor extends QueuedInterceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken;
    accessToken ="";


    const Map<String, dynamic> apiHeaders = {
      "Accept": 'application/json',
      'Content-Type': 'application/json',
    };
    if (accessToken?.isNotEmpty ?? false) {
      options.headers.addAll({
        'Authorization': "Bearer $accessToken",
      });
    }
    options.headers.addAll(apiHeaders);
    // super.onRequest(options, handler);
    return handler.next(options);
  }
}

class ErrorInterceptor extends Interceptor {
  var connectivityResult;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // debugPrintStack(label: err.response.toString(), maxFrames: 50);
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      return handler.next(NoInternetConnectionException(err.requestOptions));
    }

    if ((err.response?.statusCode ?? 0) >= 500) {
      return handler.next(ServerException(
          err.requestOptions,
          // err.response?.data['message'] != null
          //     ? err.response?.data['message']
          //     :
          err.response?.statusMessage ?? '',
          err.response?.statusCode ?? 0));
    }

    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      final refreshToken ="";
         "";
      // DioManager.instance._prodDio.interceptors.requestLock.lock();
      // DioManager.instance._prodDio.interceptors.requestLock.lock();
      await Dio()
          .post(
        "${"baseUrl"}/refresh-token",
        data: ({"refresh_token": refreshToken}),
      )
          .then((value) async {
        if (value.statusCode == 200) {
          final accessToken = value.data["access_token"];
          final refreshToken = value.data["refresh_token"];
          // DioManager.instance._prodDio.interceptors.requestLock.unlock();
          // DioManager.instance._prodDio.interceptors.requestLock.unlock();



          return handler.resolve(await DioManager.instance._prodDio
              .request(err.requestOptions.path,
              data: err.requestOptions.data,
              options: Options(
                method: err.requestOptions.method,
              )));
        }
      });
    }

    if (err.response?.data != null) {
      return handler.next(ServerException(
          err.requestOptions,
          // err.response?.data['message'] != null
          //     ? err.response?.data['message']
          //     :
          err.response?.data[0] != null
              ? err.response?.data[0]['error_message']
              : err.response?.data['message'],
          err.response?.statusCode ?? 0));
    }

    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return handler.next(DeadlineExceededException(err.requestOptions));
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            return handler.next(BadRequestException(err.requestOptions));
          case 401:
            return handler
                .next(throw UnauthorizedException(err.requestOptions));
          case 404:
            return handler.next(NotFoundException(err.requestOptions));
          case 409:
            return handler.next(ConflictException(err.requestOptions));
          case 500:
            return handler
                .next(InternalServerErrorException(err.requestOptions));
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        return handler.next(InternalServerErrorException(err.requestOptions));
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class ServerException extends DioError {
  final String errorMessage;
  final int statusCode;

  ServerException(RequestOptions r, this.errorMessage, this.statusCode)
      : super(requestOptions: r);

  @override
  String toString() {
    // final Map<String, dynamic> errorResponse = errorMessage.jsonEncode();
    if (errorMessage.contains("message")) {
      return "${errorMessage}";
      // return "Status Code: $statusCode, ${errorMessage["message"]}";
    }
    return "$errorMessage";
  }
}

enum BaseUrlType { PRODUCTION, DEFAULT }
