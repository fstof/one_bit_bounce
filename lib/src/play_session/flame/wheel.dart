import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_mini_sprite/flame_mini_sprite.dart';
import 'package:flutter/services.dart';
import 'package:mini_sprite/mini_sprite.dart';

import '../../style/palette.dart';
import 'assets.dart';

class RollingPlayer extends BodyComponent with Tappable {
  final Vector2 position;
  final size = 1.0;

  RollingPlayer({required this.position});

  @override
  Future<void> onLoad() async {
    final library = MiniLibrary.fromDataString(libraryAsset);

    final sprites = await library.toSprites(
      pixelSize: 1,
      color: Palette.one,
    );

    add(SpriteComponent(
      sprite: sprites['player']!,
      position: Vector2.zero(),
      size: Vector2.all(2),
      anchor: Anchor.center,
    ));

    add(
      KeyboardListenerComponent(
        keyUp: {
          LogicalKeyboardKey.arrowLeft: (keysPressed) => stop(),
          LogicalKeyboardKey.arrowRight: (keysPressed) => stop(),
        },
        keyDown: {
          LogicalKeyboardKey.arrowLeft: (keysPressed) => backward(),
          LogicalKeyboardKey.arrowRight: (keysPressed) => forward(),
          LogicalKeyboardKey.space: (keysPressed) => jump(),
        },
      ),
    );

    return super.onLoad();
  }

  @override
  Body createBody() {
    renderBody = false;

    final shape = CircleShape()..radius = size;

    body = world.createBody(BodyDef(
      type: BodyType.dynamic,
      userData: this,
      position: position,
    ));
    body.createFixture(FixtureDef(
      shape,
      friction: 1.0,
      restitution: 0.5,
      density: 1.0,
    ));

    final groundBody = world.createBody(BodyDef());
    world.createJoint(FrictionJoint(
      FrictionJointDef()
        ..initialize(body, groundBody, body.worldCenter)
        ..maxTorque = 0.05,
    ));

    return body;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    body.applyLinearImpulse(Vector2.random() * 100);
    return false;
  }

  bool jump() {
    body.applyLinearImpulse(Vector2(0, -10));
    return false;
  }

  bool forward() {
    body.applyTorque(100);
    return true;
  }

  bool backward() {
    body.applyTorque(-100);
    return true;
  }

  bool stop() {
    body.applyTorque(0);
    return true;
  }
}
