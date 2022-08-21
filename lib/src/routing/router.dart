import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../end_game/lose_game_screen.dart';
import '../end_game/win_game_screen.dart';
import '../games_services/score.dart';
import '../level_selection/level_selection_screen.dart';
import '../level_selection/levels.dart';
import '../main_menu/main_menu_screen.dart';
import '../play_session/play_session_screen.dart';
import '../settings/settings_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) =>
            const MainMenuScreen(key: Key('main menu')),
        routes: [
          GoRoute(
              path: 'play',
              builder: (context, state) => const LevelSelectionScreen(
                    key: Key('level selection'),
                  ),
              routes: [
                GoRoute(
                  path: 'session/:level',
                  builder: (context, state) {
                    final levelNumber = int.parse(state.params['level']!);
                    final level =
                        gameLevels.singleWhere((e) => e.number == levelNumber);
                    return PlaySessionScreen(
                      level,
                      key: const Key('play session'),
                    );
                  },
                ),
                GoRoute(
                  path: 'won/:level',
                  builder: (context, state) {
                    final map = state.extra! as Map<String, dynamic>;
                    final score = map['score'] as Score;

                    final levelNumber = int.parse(state.params['level']!);
                    final level =
                        gameLevels.singleWhere((e) => e.number == levelNumber);

                    return WinGameScreen(
                      score: score,
                      key: const Key('win game'),
                      level: level,
                    );
                  },
                ),
                GoRoute(
                  path: 'lost/:level',
                  builder: (context, state) {
                    final levelNumber = int.parse(state.params['level']!);
                    final level =
                        gameLevels.singleWhere((e) => e.number == levelNumber);

                    return LoseGameScreen(
                      key: const Key('lose game'),
                      level: level,
                    );
                  },
                ),
              ]),
          GoRoute(
            path: 'settings',
            builder: (context, state) =>
                const SettingsScreen(key: Key('settings')),
          ),
        ]),
  ],
);
