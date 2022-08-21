import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_bit_bounce/src/style/palette.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../games_services/score.dart';
import '../level_selection/levels.dart';
import '../player_progress/player_progress.dart';
import '../settings/settings.dart';
import '../style/confetti.dart';
import 'flame/game.dart';

class PlaySessionScreen extends StatefulWidget {
  final GameLevel level;

  const PlaySessionScreen(this.level, {super.key});

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  static const _preCelebrationDuration = Duration(milliseconds: 500);
  static const _celebrationDuration = Duration(milliseconds: 2000);
  static const _deathDuration = Duration(milliseconds: 1000);

  bool _gameOver = false;
  bool _duringCelebration = false;
  late DateTime _startOfPlay;

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return IgnorePointer(
      ignoring: _duringCelebration,
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GameWidget(
                      game: OneBitGame(
                        level: widget.level.number,
                        onWin: () => _win(),
                        onLose: () => _lose(),
                        audioController: audioController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     audioController.playSfx(SoundType.buttonTap);
            //     GoRouter.of(context).push('/settings');
            //   },
            //   icon: Icon(Icons.settings),
            //   color: Palette.one,
            // ),
            SizedBox.expand(
              child: Visibility(
                visible: _duringCelebration,
                child: IgnorePointer(
                  child: Confetti(
                    isStopped: !_duringCelebration,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _startOfPlay = DateTime.now();
  }

  Future<void> _win() async {
    if (_gameOver) return;
    _gameOver = true;
    final score = Score(
      widget.level.number,
      DateTime.now().difference(_startOfPlay),
    );

    final playerProgress = context.read<PlayerProgress>();
    playerProgress.setLevelReached(widget.level.number);

    // Let the player see the game just after winning for a bit.
    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;

    setState(() {
      _duringCelebration = true;
    });

    final audioController = context.read<AudioController>();
    audioController.playSfx(SoundType.win);

    /// Give the player some time to see the celebration animation.
    await Future<void>.delayed(_celebrationDuration);
    if (!mounted) return;

    GoRouter.of(context).go(
      '/play/won/${widget.level.number}',
      extra: {'score': score},
    );
  }

  Future<void> _lose() async {
    if (_gameOver) return;
    _gameOver = true;
    final audioController = context.read<AudioController>();
    audioController.playSfx(SoundType.loose);

    await Future<void>.delayed(_deathDuration);
    if (!mounted) return;

    GoRouter.of(context).go('/play/lost/${widget.level.number}');
  }
}
