import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static CacheService? _instance;
  static SharedPreferences? _preferences;

  CacheService._();
  factory CacheService() => _instance ?? CacheService._();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // handle store API user token in cache
  Future<void> setToken(String token) async =>
      await _preferences?.setString(_Keys.token, token);

  bool get hasToken => _preferences?.containsKey(_Keys.token) ?? false;

  Future<void> removeToken() async => await _preferences?.remove(_Keys.token);

  String get token => _preferences?.getString(_Keys.token) ?? "no token";

  Future<void> setRefreshToken(String refreshToken) async =>
      await _preferences?.setString(_Keys.refreshToken, refreshToken);

  bool get hasRefreshToken =>
      _preferences?.containsKey(_Keys.refreshToken) ?? false;

  Future<void> removeRefreshToken() async =>
      await _preferences?.remove(_Keys.refreshToken);

  String get refreshToken =>
      _preferences?.getString(_Keys.refreshToken) ?? "no refresh token";

  // Theme
  Future<void> setTheme(bool theme) async =>
      await _preferences?.setBool(_Keys.theme, theme);

  Future<void> removeTheme() async => await _preferences?.remove(_Keys.theme);

  bool get hasTheme => _preferences?.containsKey(_Keys.theme) ?? false;

  bool get theme => _preferences?.getBool(_Keys.theme) ?? false;

  Future<void> initCacheTheme() async {
    if (hasTheme) return;
    await setTheme(false);
  }

  //language
  Future<void> setLanguage(bool language) async =>
      await _preferences?.setBool(_Keys.language, language);

  Future<void> removeLanguage() async =>
      await _preferences?.remove(_Keys.language);

  bool get hasLanguage => _preferences?.containsKey(_Keys.language) ?? false;

  bool get language => _preferences?.getBool(_Keys.language) ?? false;

  Future<void> initCacheLanguage() async {
    if (hasLanguage) return;
    await setLanguage(false);
  }

  // Television instructions (one-time)
  Future<void> setTelevisionInstructionsSeen(bool seen) async =>
      await _preferences?.setBool(_Keys.televisionInstructionsSeen, seen);

  bool get hasTelevisionInstructionsSeen =>
      _preferences?.getBool(_Keys.televisionInstructionsSeen) ?? false;

  Future<void> resetTelevisionInstructionsSeen() async =>
      await _preferences?.remove(_Keys.televisionInstructionsSeen);
}

class _Keys {
  static const String token = "token";
  static const String refreshToken = "refresh_token";
  static const String theme = "theme";
  static const String language = "language";
  static const String televisionInstructionsSeen =
      "television_instructions_seen";
}
