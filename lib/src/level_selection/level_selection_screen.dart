// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import 'levels.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProgress = context.watch<PlayerProgress>();
    final audioController = context.read<AudioController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Transform.rotate(
                  angle: 0.1,
                  child: Text(
                    'Select level',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView(
                children: [
                  for (final level in gameLevels)
                    ListTile(
                      enabled: playerProgress.highestLevelReached >=
                          level.number - 1,
                      onTap: () {
                        audioController.playSfx(SoundType.buttonTap);
                        GoRouter.of(context)
                            .go('/play/session/${level.number}');
                      },
                      leading: Text(
                        level.number.toString(),
                      ),
                      title: Text('Level #${level.number}'),
                    )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                audioController.playSfx(SoundType.buttonTap);
                GoRouter.of(context).pop();
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
