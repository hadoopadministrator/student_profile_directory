import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const _lastViewed = 'last_viewed_profile';

  static Future<void> setLastViewed(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastViewed, name);
  }

  static Future<String?> getLastViewed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastViewed);
  }
}
