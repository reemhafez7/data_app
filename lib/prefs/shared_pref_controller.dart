import 'package:data_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { loggedIn, id, name, email, language }

class SharedPrefController {
  //Design Pattern: Singleton

  SharedPrefController._();

  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save(User user) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    await _sharedPreferences.setInt(PrefKeys.id.name, user.id);
    await _sharedPreferences.setString(PrefKeys.name.name, user.name);
    await _sharedPreferences.setString(PrefKeys.email.name, user.email);
  }

  Future<bool> setLanguage(String language) async {
    return _sharedPreferences.setString(PrefKeys.language.name, language);
  }

  // bool get loggedIn => _sharedPreferences.getBool(PrefKeys.loggedIn.name) ?? false;

  Type? getValueFor<Type>(String key) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as Type;
    }
    return null;
  }

  Future<bool> removeValueFor(String key) async {
    if (_sharedPreferences.containsKey(key)) {
      return await _sharedPreferences.remove(key);
    }
    return false;
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
