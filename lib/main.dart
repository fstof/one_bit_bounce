import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/app_lifecycle/app_lifecycle.dart';
import 'src/audio/audio_controller.dart';
import 'src/player_progress/persistence/player_progress_persistence.dart';
import 'src/player_progress/player_progress.dart';
import 'src/routing/router.dart';
import 'src/settings/persistence/settings_persistence.dart';
import 'src/settings/settings.dart';
import 'src/style/palette.dart';
import 'src/style/snack_bar.dart';
import 'src/style/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  runApp(
    MyApp(
      settingsPersistence: SettingsPersistence(),
      playerProgressPersistence: PlayerProgressPersistence(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final PlayerProgressPersistence playerProgressPersistence;
  final SettingsPersistence settingsPersistence;

  const MyApp({
    required this.playerProgressPersistence,
    required this.settingsPersistence,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              var progress = PlayerProgress(playerProgressPersistence);
              progress.getLatestFromStore();
              return progress;
            },
          ),
          Provider<SettingsController>(
            lazy: false,
            create: (context) => SettingsController(
              persistence: settingsPersistence,
            )..loadStateFromPersistence(),
          ),
          ProxyProvider2<SettingsController, ValueNotifier<AppLifecycleState>,
              AudioController>(
            lazy: false,
            create: (context) => AudioController()..initialize(),
            update: (context, settings, lifecycleNotifier, audio) {
              if (audio == null) throw ArgumentError.notNull();
              audio.attachSettings(settings);
              audio.attachLifecycleNotifier(lifecycleNotifier);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
          ),
          Provider(
            create: (context) => Palette(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: '1-bit bounce',
            theme: themeData,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            scaffoldMessengerKey: scaffoldMessengerKey,
          );
        }),
      ),
    );
  }
}
