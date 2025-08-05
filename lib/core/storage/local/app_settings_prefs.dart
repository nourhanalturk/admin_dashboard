import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/constants/constants.dart';
import '../../../config/constants/shared_prefs_constants.dart';
import 'package:tender/core/extensions/extensions.dart';

class AppSettingsPrefs {
  final SharedPreferences _sharedPreferences;

  clear() {
    _sharedPreferences.clear();
  }

  AppSettingsPrefs(
    this._sharedPreferences,
  );

  Future<void> setToken({
    required String token,
  }) async {
    await _sharedPreferences.setString(
      Constants.token,
      token,
    );
  }

  /// Get the user token
  String getToken() {
    return _sharedPreferences.getString(Constants.token).onNull();
  }

  /// Set if the user logged in is true
  Future<void> setUserLoggedIn() async {
    await _sharedPreferences.setBool(
      Constants.isLoggedIn,
      true,
    );
  }

  /// Get if the user logged
  bool getUserLoggedIn() {
    return _sharedPreferences
        .getBool(
          Constants.isLoggedIn,
        )
        .onNull();
  }

  Future<void> setLocale(String locale) async {
    await _sharedPreferences.setString(SharedPrefsConstants.locale, locale);
  }

  String getLocale() {
    return _sharedPreferences
        .getString(SharedPrefsConstants.locale)
        .pareWithDefaultLocale();
  }
}
