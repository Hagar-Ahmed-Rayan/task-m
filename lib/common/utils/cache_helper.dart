import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences ? sharedPrefs ;

  static init() async
  {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async
  {
    return await sharedPrefs!.setBool(key, value);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPrefs!.get(key);
  }

  static  dynamic saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPrefs!.setString(key, value);
    if (value is int) return await sharedPrefs!.setInt(key, value);
    if (value is bool) return await sharedPrefs!.setBool(key, value);

    return await sharedPrefs!.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async
  {
    return await sharedPrefs!.remove(key);
  }
  static bool ? getBoolean({
    required String key,
  })
  {
    return sharedPrefs?.getBool(key);
  }
}
