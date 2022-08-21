// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../games_services/score.dart';
import '../level_selection/levels.dart';

class WinGameScreen extends StatelessWidget {
  final _gap = SizedBox(
    height: 10,
    width: 10,
  );
  final Score score;
  final GameLevel level;

  WinGameScreen({
    super.key,
    required this.score,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final audioController = context.watch<AudioController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Center(
              child: Transform.rotate(
                angle: 0.2,
                child: Text(
                  'You won!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            _gap,
            _gap,
            _gap,
            _gap,
            Center(
              child: Text(
                'Time: ${score.formattedTime}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Spacer(),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.refresh),
                      _gap,
                      Text('Retry'),
                    ]),
                    onPressed: () {
                      audioController.playSfx(SoundType.buttonTap);
                      GoRouter.of(context).go('/play/session/${level.number}');
                    },
                  ),
                  _gap,
                  ElevatedButton(
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text('Next'),
                      _gap,
                      Icon(Icons.skip_next),
                    ]),
                    onPressed: () {
                      audioController.playSfx(SoundType.buttonTap);
                      GoRouter.of(context)
                          .go('/play/session/${level.number + 1}');
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                audioController.playSfx(SoundType.buttonTap);
                GoRouter.of(context).pop();
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
