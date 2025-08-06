import 'package:dio/dio.dart';
import '../../config/constants/constants.dart';
import '../../config/constants/env_constants.dart';
import '../../config/di/di.dart';
import '../service/env_service.dart';
import '../storage/local/app_settings_prefs.dart';

class DioFactory {
  final AppSettingsPrefs _appPreferences = instance<AppSettingsPrefs>();

  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      Constants.authorization: getAuthorization(_appPreferences.getToken()),
      //Constants.acceptLanguage: _appPreferences.getLocale(),
      Constants.accept: Constants.applicationJson,
      Constants.contentType: Constants.applicationJson,
    };

    dio.options = BaseOptions(
      baseUrl: EnvService.getString(
        key: EnvConstants.apiUrl,
      ),
      headers: headers,
      receiveTimeout: const Duration(
        seconds: Constants.sendTimeOutDuration,
      ),
      sendTimeout: const Duration(
        seconds: Constants.receiveTimeOutDuration,
      ),
    );

    InterceptorsWrapper authInterceptor = InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        options.headers[Constants.authorization] = getAuthorization(
          _appPreferences.getToken(),
        );
        return handler.next(options);
      },
    );
    dio.interceptors.add(
      authInterceptor,
    );

    // if (!kReleaseMode) {
    //   dio.interceptors.add(
    //     PrettyDioLogger(
    //       requestBody: true,
    //       requestHeader: true,
    //       responseBody: true,
    //       responseHeader: true,
    //     ),
    //   );
    // }
    return dio;
  }

  String getAuthorization(String token) {
    return '${Constants.bearer} $token';
  }
}
