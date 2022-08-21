import 'dart:collection';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart' hide Logger;
import 'package:flutter/widgets.dart';

import '../settings/settings.dart';
import 'songs.dart';
import 'sounds.dart';

class AudioController {
  late AudioCache _musicCache;
  late AudioCache _sfxCache;

  final AudioPlayer _musicPlayer;
  final AudioPlayer _sfxPlayer;

  final Queue<String> _playlist;
  final Random _random = Random();

  SettingsController? _settings;
  ValueNotifier<AppLifecycleState>? _lifecycleNotifier;

  AudioController()
      : _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
        _sfxPlayer = AudioPlayer(
          playerId: 'sfxPlayer',
          mode: PlayerMode.LOW_LATENCY,
        ),
        _playlist = Queue.of(songs) {
    // _playlist = Queue.of(songs..shuffle()) {
    _musicCache = AudioCache(
      fixedPlayer: _musicPlayer,
      prefix: 'assets/music/',
    );
    _sfxCache = AudioCache(
      fixedPlayer: _sfxPlayer,
      prefix: 'assets/sfx/',
    );

    _musicPlayer.onPlayerCompletion.listen(_changeSong);
  }

  void attachLifecycleNotifier(
      ValueNotifier<AppLifecycleState> lifecycleNotifier) {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);

    lifecycleNotifier.addListener(_handleAppLifecycle);
    _lifecycleNotifier = lifecycleNotifier;
  }

  void attachSettings(SettingsController settingsController) {
    if (_settings == settingsController) return;

    final oldSettings = _settings;
    if (oldSettings != null) {
      oldSettings.musicOn.removeListener(_musicOnHandler);
      oldSettings.soundsOn.removeListener(_soundsOnHandler);
    }

    _settings = settingsController;

    settingsController.musicOn.addListener(_musicOnHandler);
    settingsController.soundsOn.addListener(_soundsOnHandler);

    if (!settingsController.musicOn.value) {
      _startMusic();
    }
  }

  void dispose() {
    _lifecycleNotifier?.removeListener(_handleAppLifecycle);
    _stopAllSound();
    _musicPlayer.dispose();
    _sfxPlayer.dispose();
  }

  Future<void> initialize() async {
    await _sfxCache
        .loadAll(SoundType.values.expand(soundNamesForType).toList());
  }

  void playSfx(SoundType type) {
    final soundsOn = _settings?.soundsOn.value ?? false;
    if (!soundsOn) return;

    final options = soundNamesForType(type);
    final filename = options[_random.nextInt(options.length)];
    _sfxCache.play(filename);
    _sfxCache.fixedPlayer = _sfxPlayer;
  }

  void _changeSong(_) {
    _playlist.addLast(_playlist.removeFirst());
    _musicCache.play(_playlist.first);
  }

  void _handleAppLifecycle() {
    switch (_lifecycleNotifier!.value) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _stopAllSound();
        break;
      case AppLifecycleState.resumed:
        if (_settings!.musicOn.value) {
          _resumeMusic();
        }
        break;
      case AppLifecycleState.inactive:
        break;
    }
  }

  void _musicOnHandler() {
    if (!_settings!.musicOn.value) {
      _resumeMusic();
    } else {
      _stopMusic();
    }
  }

  Future<void> _resumeMusic() async {
    switch (_musicPlayer.state) {
      case PlayerState.PAUSED:
        try {
          await _musicPlayer.resume();
        } catch (e) {
          // Sometimes, resuming fails with an "Unexpected" error.
          await _musicCache.play(_playlist.first);
        }
        break;
      case PlayerState.STOPPED:
        await _musicCache.play(_playlist.first);
        break;
      case PlayerState.PLAYING:
        break;
      case PlayerState.COMPLETED:
        await _musicCache.play(_playlist.first);
        break;
    }
  }

  void _soundsOnHandler() {
    if (_sfxPlayer.state == PlayerState.PLAYING) {
      _sfxPlayer.stop();
    }
  }

  void _startMusic() {
    _musicCache.play(_playlist.first);
  }

  void _stopAllSound() {
    if (_musicPlayer.state == PlayerState.PLAYING) {
      _musicPlayer.pause();
    }
    _sfxPlayer.stop();
  }

  void _stopMusic() {
    if (_musicPlayer.state == PlayerState.PLAYING) {
      _musicPlayer.pause();
    }
  }
}
