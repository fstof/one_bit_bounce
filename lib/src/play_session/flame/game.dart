import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:mini_sprite/mini_sprite.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import 'assets.dart';
import 'finish_line.dart';
import 'ground_block.dart';
import 'player_block.dart';
import 'tower_block.dart';
import 'tower_bottom.dart';

class OneBitGame extends Forge2DGame
    with HasDraggables, HasTappables, HasKeyboardHandlerComponents {
  int level;
  void Function() onWin;
  void Function() onLose;
  AudioController audioController;

  OneBitGame({
    required this.level,
    required this.onWin,
    required this.onLose,
    required this.audioController,
  }) : super(zoom: 20, gravity: Vector2(0, 30));

  @override
  Future<void>? onLoad() async {
    // debugMode = true;

    final map = MiniMap.fromDataString(maps['map$level']!);

    PlayerBlock? player;

    // await add(TowerBottom(position: Vector2(size.x / 2, size.y / 3)));

    for (final entity in map.objects.entries) {
      final pos = Vector2(
        (entity.key.x + 1) * 2,
        entity.key.y * 2,
      );
      if (entity.value['sprite'] == 'groundblock' ||
          entity.value['sprite'] == 'leftcap' ||
          entity.value['sprite'] == 'rightcap') {
        add(GroundBlock(position: pos, type: entity.value['sprite']));
      } else if (entity.value['sprite'] == 'towerbottom') {
        await add(TowerBottom(position: pos));
      } else if (entity.value['sprite'] == 'towerblock') {
        await add(TowerBlock(position: pos));
      } else if (entity.value['sprite'] == 'finish') {
        await add(FinishLine(position: pos));
      } else if (entity.value['sprite'] == 'blockplayer') {
        await add(player =
            PlayerBlock(position: pos, audioController: audioController));
      }
    }

    if (player != null) {
      camera.followBodyComponent(player, relativeOffset: Anchor(0.3, 0.7));
    }
    return super.onLoad();
  }
}
