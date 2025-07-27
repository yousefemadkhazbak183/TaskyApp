import 'package:shared_preferences/shared_preferences.dart';

// Singleton class

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();

  // Private constructor
  PreferencesManager._internal();

  factory PreferencesManager() {
    return _instance;
  }

  late final SharedPreferences _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  remove(String key) {
    return _preferences.remove(key);
  }
}
