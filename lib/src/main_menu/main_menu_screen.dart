import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../settings/settings.dart';
import '../style/palette.dart';

class MainMenuScreen extends StatelessWidget {
  static const _gap = SizedBox(height: 10);

  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Transform.rotate(
                angle: -0.2,
                child: Text(
                  '1-bit bounce',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              audioController.playSfx(SoundType.buttonTap);
              GoRouter.of(context).go('/play');
            },
            child: const Text('Play'),
          ),
          _gap,
          ElevatedButton(
            onPressed: () {
              audioController.playSfx(SoundType.buttonTap);
              GoRouter.of(context).go('/settings');
            },
            child: const Text('Settings'),
          ),
          _gap,
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: ValueListenableBuilder<bool>(
              valueListenable: settingsController.musicOn,
              builder: (context, muted, child) {
                return IconButton(
                  onPressed: () => settingsController.toggleMusicOn(),
                  icon: Icon(
                    muted ? Icons.volume_off : Icons.volume_up,
                    color: Palette.one,
                  ),
                );
              },
            ),
          ),
          _gap,
        ],
      ),
    );
  }
}
