import 'package:flutter/foundation.dart';

import 'persistence/settings_persistence.dart';

class SettingsController {
  final SettingsPersistence _persistence;

  ValueNotifier<bool> soundsOn = ValueNotifier(false);
  ValueNotifier<bool> musicOn = ValueNotifier(false);

  SettingsController({required SettingsPersistence persistence})
      : _persistence = persistence;

  Future<void> loadStateFromPersistence() async {
    await Future.wait([
      _persistence.getSoundsOn().then((value) => soundsOn.value = value),
      _persistence.getMusicOn().then((value) => musicOn.value = value),
    ]);
  }

  void toggleMusicOn() {
    musicOn.value = !musicOn.value;
    _persistence.saveMusicOn(musicOn.value);
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _persistence.saveSoundsOn(soundsOn.value);
  }
}
