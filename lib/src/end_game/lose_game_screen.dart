// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_bit_bounce/src/audio/sounds.dart';
import 'package:one_bit_bounce/src/level_selection/levels.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../style/palette.dart';

class LoseGameScreen extends StatelessWidget {
  final _gap = SizedBox(height: 10, width: 10);
  final GameLevel level;

  LoseGameScreen({
    super.key,
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
                angle: -0.1,
                child: Text(
                  'You lose!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            _gap,
            _gap,
            Center(
              child: Text(
                'Have another go!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
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
