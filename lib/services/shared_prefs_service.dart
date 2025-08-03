import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const _lastViewed = 'last_viewed_profile';

  static Future<void> setLastViewed({required String studentName}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastViewed, studentName);
  }

  static Future<String?> getLastViewed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastViewed);
  }

  static Future<void> clearLastViewed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastViewed);
  }
}
