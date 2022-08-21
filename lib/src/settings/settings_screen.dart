import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import 'settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final audioController = context.watch<AudioController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Transform.rotate(
              angle: -0.1,
              child: Text(
                'Settings',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            _gap,
            ValueListenableBuilder<bool>(
              valueListenable: settings.soundsOn,
              builder: (context, soundsOn, child) => _SettingsLine(
                'Sound FX',
                Icon(
                  soundsOn ? Icons.graphic_eq : Icons.volume_off,
                  color: Palette.one,
                ),
                onSelected: () {
                  audioController.playSfx(SoundType.buttonTap);
                  settings.toggleSoundsOn();
                },
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: settings.musicOn,
              builder: (context, musicOn, child) => _SettingsLine(
                'Music',
                Icon(
                  !musicOn ? Icons.music_note : Icons.music_off,
                  color: Palette.one,
                ),
                onSelected: () {
                  audioController.playSfx(SoundType.buttonTap);
                  settings.toggleMusicOn();
                },
              ),
            ),
            _SettingsLine(
              'Reset progress',
              Icon(Icons.delete, color: Palette.one),
              onSelected: () {
                audioController.playSfx(SoundType.buttonTap);
                context.read<PlayerProgress>().reset();

                final messenger = ScaffoldMessenger.of(context);
                messenger.showSnackBar(
                  const SnackBar(
                      content: Text('Player progress has been reset.')),
                );
              },
            ),
            Spacer(),
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

class _SettingsLine extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback? onSelected;
  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      onTap: onSelected,
      trailing: icon,
    );
  }
}
