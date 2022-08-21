import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_mini_sprite/flame_mini_sprite.dart';
import 'package:mini_sprite/mini_sprite.dart';

import '../../style/palette.dart';
import 'assets.dart';

class FinishLine extends BodyComponent {
  final Vector2 position;

  FinishLine({required this.position});

  @override
  Future<void> onLoad() async {
    final library = MiniLibrary.fromDataString(libraryAsset);

    final sprites = await library.toSprites(
      pixelSize: 1,
      color: Palette.one,
    );

    add(SpriteComponent(
      sprite: sprites['finish']!,
      position: Vector2.zero(),
      size: Vector2.all(2),
      anchor: Anchor.center,
    ));

    return super.onLoad();
  }

  @override
  Body createBody() {
    renderBody = false;
    final shape = PolygonShape()..setAsBox(1, 1, Vector2.zero(), 0);

    body = world.createBody(BodyDef(
      type: BodyType.dynamic,
      userData: this,
      position: position,
    ));

    body.createFixture(FixtureDef(
      shape,
      // isSensor: true,
      friction: 1.0,
      density: 0.1,
    ));

    return body;
  }
}
