import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_mini_sprite/flame_mini_sprite.dart';
import 'package:mini_sprite/mini_sprite.dart';

import '../../style/palette.dart';
import 'assets.dart';

class GroundBlock extends BodyComponent {
  final Vector2 position;
  final String type;

  GroundBlock({required this.position, required this.type});

  @override
  Future<void> onLoad() async {
    final library = MiniLibrary.fromDataString(libraryAsset);

    final sprites = await library.toSprites(
      pixelSize: 1,
      color: Palette.one,
    );

    add(SpriteComponent(
      sprite: sprites[type]!,
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
      type: BodyType.static,
      userData: this,
      position: position,
    ));

    body.createFixture(FixtureDef(
      shape,
      friction: 0.1,
      density: 50.0,
    ));

    return body;
  }
}
