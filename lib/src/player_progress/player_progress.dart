import 'dart:async';

import 'package:flutter/foundation.dart';

import 'persistence/player_progress_persistence.dart';

class PlayerProgress extends ChangeNotifier {
  final PlayerProgressPersistence _store;
  int _highestLevelReached = 0;

  PlayerProgress(PlayerProgressPersistence store) : _store = store;

  int get highestLevelReached => _highestLevelReached;

  Future<void> getLatestFromStore() async {
    final level = await _store.getHighestLevelReached();
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
    } else if (level < _highestLevelReached) {
      await _store.saveHighestLevelReached(_highestLevelReached);
    }
  }

  void reset() {
    _highestLevelReached = 0;
    notifyListeners();
    _store.saveHighestLevelReached(_highestLevelReached);
  }

  void setLevelReached(int level) {
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();

      _store.saveHighestLevelReached(level);
    }
  }
}
