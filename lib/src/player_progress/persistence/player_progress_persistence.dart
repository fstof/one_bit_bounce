import 'package:shared_preferences/shared_preferences.dart';

class PlayerProgressPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  Future<int> getHighestLevelReached() async {
    final prefs = await instanceFuture;
    return prefs.getInt('highestLevelReached') ?? 0;
  }

  Future<void> saveHighestLevelReached(int level) async {
    final prefs = await instanceFuture;
    await prefs.setInt('highestLevelReached', level);
  }
}
