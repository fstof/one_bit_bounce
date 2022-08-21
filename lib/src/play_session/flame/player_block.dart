import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide Timer;
import 'package:flame_mini_sprite/flame_mini_sprite.dart';
import 'package:flutter/services.dart';
import 'package:mini_sprite/mini_sprite.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../audio/sounds.dart';
import '../../style/palette.dart';
import 'assets.dart';
import 'finish_line.dart';
import 'game.dart';
import 'ground_block.dart';
import 'tower_block.dart';
import 'tower_bottom.dart';

class PlayerBlock extends BodyComponent<OneBitGame> with ContactCallbacks {
  final Vector2 position;
  final size = 1.0;
  var _canApplyForce = false;
  final AudioController audioController;

  PlayerBlock({required this.position, required this.audioController});

  @override
  Future<void> onLoad() async {
    final library = MiniLibrary.fromDataString(libraryAsset);

    final sprites = await library.toSprites(
      pixelSize: 1,
      color: Palette.one,
    );

    add(SpriteComponent(
      sprite: sprites['blockplayer']!,
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

    final shape = PolygonShape()..setAsBox(1, 1, Vector2.zero(), 0);

    body = world.createBody(BodyDef(
      type: BodyType.dynamic,
      userData: this,
      position: position,
    ));
    body.createFixture(FixtureDef(
      shape,
      friction: 0.1,
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
  void update(double dt) {
    super.update(dt);

    if (body.position.y > 20) {
      gameRef.onLose();
    }

    if (body.contacts.length == 0) {
      _canApplyForce = false;
    } else {
      body.contacts.forEach((contact) {
        if (contact.bodyA.userData is GroundBlock) {
          _canApplyForce = false;
        } else {
          _canApplyForce = true;
        }
      });
    }
  }

  bool jump() {
    if (_canApplyForce) {
      audioController.playSfx(SoundType.jump);
      body.applyLinearImpulse(
        Vector2(0, -60),
        point: body.worldCenter + Vector2(-0.25, 0),
      );
    }
    return false;
  }

  bool forward() {
    if (_canApplyForce) {
      body.applyLinearImpulse(Vector2(10, 0));
      // body.applyForce(Vector2(100, 0));
    }
    return false;
  }

  bool backward() {
    if (_canApplyForce) {
      body.applyLinearImpulse(Vector2(-10, 0));
      // body.applyForce(Vector2(-100, 0));
    }
    return false;
  }

  bool stop() {
    body.applyForce(Vector2.zero());
    return false;
  }

  @override
  void preSolve(Object other, Contact contact, Manifold oldManifold) {
    if (other is FinishLine) {
      contact.setEnabled(false);
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is GroundBlock) {
      // _canApplyForce = false;
      gameRef.onLose();
    } else if (other is TowerBlock || other is TowerBottom) {
      // _canApplyForce = true;
    } else if (other is FinishLine) {
      // _canApplyForce = false;
      gameRef.onWin();
    }
  }
}
