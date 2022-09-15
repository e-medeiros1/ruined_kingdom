import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_bonfire/screens/map_render.dart';
import 'package:ng_bonfire/widgets/player/player_sprite_sheet.dart';

class GamePlayer extends SimplePlayer with ObjectCollision {
  bool lockMove = false;
  GamePlayer({required Vector2 position})
      : super(
          position: position,
          speed: 180,
          size: Vector2(tileSize * 6, tileSize * 6),
          life: 200,
          animation: SimpleDirectionAnimation(
            idleRight: PlayerSpriteSheet.playerIdleRight,
            idleLeft: PlayerSpriteSheet.playerIdleLeft,
            runRight: PlayerSpriteSheet.playerRunRight,
            runLeft: PlayerSpriteSheet.playerRunLeft,
          ),
        ) {
//CollisionConfig
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(16, 27),
            align: Vector2(89, 95),
          ),
        ],
      ),
    );
  }

//Life bar
  @override
  void render(Canvas canvas) {
    drawDefaultLifeBar(
      canvas,
      width: 39,
      borderWidth: 1,
      height: 4,
      align: const Offset(69, -58),
      borderRadius: BorderRadius.circular(3),
    );
    super.render(canvas);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (isDead || lockMove) return;
    if ((event.id == LogicalKeyboardKey.space.keyId ||
            event.id == 0 ||
            event.id == 1) &&
        event.event == ActionEvent.DOWN) {
      _addAttackAnimation();
      simpleAttackMelee(
        damage: 25,
        size: Vector2.all(tileSize),
        withPush: false,
      );
    }
    super.joystickAction(event);
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, dynamic identify) {
    if (!isDead) {
      lockMove = true;
      idle();
      _addDamageAnimation(() {
        lockMove = false;
      });
    }
    super.receiveDamage(attacker, damage, identify);
  }

//Attack animation
  void _addAttackAnimation() {
    lockMove = true;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = PlayerSpriteSheet.attackLeft;
        break;
      case Direction.right:
        newAnimation = PlayerSpriteSheet.attackRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = PlayerSpriteSheet.attackLeft;
        } else {
          newAnimation = PlayerSpriteSheet.attackRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = PlayerSpriteSheet.attackLeft;
        } else {
          newAnimation = PlayerSpriteSheet.attackRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = PlayerSpriteSheet.attackLeft;
        break;
      case Direction.upRight:
        newAnimation = PlayerSpriteSheet.attackRight;
        break;
      case Direction.downLeft:
        newAnimation = PlayerSpriteSheet.attackLeft;
        break;
      case Direction.downRight:
        newAnimation = PlayerSpriteSheet.attackRight;
        break;
    }
    animation!.playOnce(
      newAnimation,
      runToTheEnd: true,
      onFinish: (() {
        lockMove = false;
      }),
    );
  }

//DamageTaken
  void _addDamageAnimation(VoidCallback onFinish) {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = PlayerSpriteSheet.takeHitLeft;
        break;
      case Direction.right:
        newAnimation = PlayerSpriteSheet.takeHitRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = PlayerSpriteSheet.takeHitLeft;
        } else {
          newAnimation = PlayerSpriteSheet.takeHitRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = PlayerSpriteSheet.takeHitLeft;
        } else {
          newAnimation = PlayerSpriteSheet.takeHitRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = PlayerSpriteSheet.takeHitLeft;
        break;
      case Direction.upRight:
        newAnimation = PlayerSpriteSheet.takeHitRight;
        break;
      case Direction.downLeft:
        newAnimation = PlayerSpriteSheet.takeHitLeft;
        break;
      case Direction.downRight:
        newAnimation = PlayerSpriteSheet.takeHitRight;
        break;
    }
    animation!.playOnce(newAnimation, runToTheEnd: true, onFinish: () {
      lockMove = false;
    });
  }

  //Die
  @override
  void die() async {
    if (gameRef.player!.lastDirectionHorizontal == Direction.left) {
      gameRef.add(
        AnimatedObjectOnce(
          animation: PlayerSpriteSheet.dyingLeft,
          position: position,
          size: size,
          onFinish: () => removeFromParent(),
        ),
      );
    } else {
      gameRef.add(
        AnimatedObjectOnce(
          animation: PlayerSpriteSheet.dyingLeft,
          position: position,
          size: size,
          onFinish: () => removeFromParent(),
        ),
      );
    }

    removeFromParent();
    super.die();
  }
}
