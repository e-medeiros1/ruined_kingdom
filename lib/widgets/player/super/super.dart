import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_bonfire/screens/map_render.dart';
import 'package:ng_bonfire/widgets/player/super/super_sprite_sheet.dart';

class Super extends SimplePlayer with ObjectCollision, Lighting {
  bool lockMove = false;
  Super({required Vector2 position})
      : super(
          position: position,
          life: 300,
          size: Vector2(tileSize * 7, tileSize * 7),
          speed: 180,
          animation: SimpleDirectionAnimation(
            idleRight: SuperSpriteSheet.superIdleRight,
            idleLeft: SuperSpriteSheet.superIdleLeft,
            runRight: SuperSpriteSheet.superRunRight,
            runLeft: SuperSpriteSheet.superRunLeft,
          ),
        ) {
//CollisionConfig
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(16, 35),
            align: Vector2(100, 105),
          ),
        ],
      ),
    );
    setupLighting(
      LightingConfig(
        radius: tileSize,
        color: Colors.lightBlue.shade200.withOpacity(0.1),
        align: Vector2(5, 25),
        withPulse: true,
        blurBorder: 30,
      ),
    );
  }

//Life bar
  @override
  void render(Canvas canvas) {
    drawDefaultLifeBar(
      canvas,
      width: 45,
      borderWidth: 1,
      height: 4,
      align: const Offset(90, -55),
      borderRadius: BorderRadius.circular(3),
    );
    super.render(canvas);
  }

  @override
  void joystickAction(JoystickActionEvent event) async {
    if (isDead || lockMove) return;
    if (event.id == 0 && event.event == ActionEvent.DOWN) {
      _addAttackAnimation(() {
        lockMove = false;
      });
      _meleeAttack(() {
        lockMove = true;
      });
    }

    if (event.id == LogicalKeyboardKey.space.keyId &&
        event.event == ActionEvent.DOWN) {
      _addAttackAnimation(() {
        lockMove = false;
      });
      _meleeAttack(() {
        lockMove = true;
      });
    }

    if (event.id == LogicalKeyboardKey.keyX.keyId &&
        event.event == ActionEvent.DOWN) {
      _addEspecialAttackAnimation(() {
        lockMove = false;
      });
      _especialAttack(() {
        lockMove = true;
      });
    }

    if (event.id == 1 && event.event == ActionEvent.DOWN) {
      _addEspecialAttackAnimation(() {
        lockMove = false;
      });
      _especialAttack(() {
        lockMove = true;
      });
    }
    super.joystickAction(event);
  }

//Receive Damage
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

//Normal Attack
  _meleeAttack(VoidCallback onFinish) async {
    lockMove = true;
    idle();
    await Future.delayed(const Duration(milliseconds: 300));
    simpleAttackMelee(
      damage: 25,
      size: Vector2.all(tileSize),
      withPush: false,
    );
  }

//Especial Attack
  _especialAttack(VoidCallback onFinish) async {
    lockMove = true;
    idle();
    await Future.delayed(const Duration(milliseconds: 500));
    simpleAttackMelee(
        damage: 50,
        size: Vector2.all(tileSize + 20),
        withPush: true,
        sizePush: tileSize / 3);
  }

//Range atack
  void _addEspecialAttackAnimation(VoidCallback onFinish) {
    Future<SpriteAnimation> newAnimation;
    switch (lastDirectionHorizontal) {
      case Direction.left:
        newAnimation = SuperSpriteSheet.attackEspecialLeft;
        break;
      case Direction.right:
        newAnimation = SuperSpriteSheet.attackEspecialRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = SuperSpriteSheet.attackEspecialLeft;
        } else {
          newAnimation = SuperSpriteSheet.attackEspecialRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = SuperSpriteSheet.attackEspecialLeft;
        } else {
          newAnimation = SuperSpriteSheet.attackEspecialRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = SuperSpriteSheet.attackEspecialLeft;
        break;
      case Direction.upRight:
        newAnimation = SuperSpriteSheet.attackEspecialRight;
        break;
      case Direction.downLeft:
        newAnimation = SuperSpriteSheet.attackEspecialLeft;
        break;
      case Direction.downRight:
        newAnimation = SuperSpriteSheet.attackEspecialRight;
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

//Attack animation
  void _addAttackAnimation(VoidCallback onFinish) {
    lockMove = true;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = SuperSpriteSheet.attackLeft;
        break;
      case Direction.right:
        newAnimation = SuperSpriteSheet.attackRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = SuperSpriteSheet.attackLeft;
        } else {
          newAnimation = SuperSpriteSheet.attackRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = SuperSpriteSheet.attackLeft;
        } else {
          newAnimation = SuperSpriteSheet.attackRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = SuperSpriteSheet.attackLeft;
        break;
      case Direction.upRight:
        newAnimation = SuperSpriteSheet.attackRight;
        break;
      case Direction.downLeft:
        newAnimation = SuperSpriteSheet.attackLeft;
        break;
      case Direction.downRight:
        newAnimation = SuperSpriteSheet.attackRight;
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
        newAnimation = SuperSpriteSheet.takeHitLeft;
        break;
      case Direction.right:
        newAnimation = SuperSpriteSheet.takeHitRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SuperSpriteSheet.takeHitLeft;
        } else {
          newAnimation = SuperSpriteSheet.takeHitRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SuperSpriteSheet.takeHitLeft;
        } else {
          newAnimation = SuperSpriteSheet.takeHitRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = SuperSpriteSheet.takeHitLeft;
        break;
      case Direction.upRight:
        newAnimation = SuperSpriteSheet.takeHitRight;
        break;
      case Direction.downLeft:
        newAnimation = SuperSpriteSheet.takeHitLeft;
        break;
      case Direction.downRight:
        newAnimation = SuperSpriteSheet.takeHitRight;
        break;
    }
    animation!.playOnce(
      newAnimation,
      runToTheEnd: true,
      onFinish: () {
        lockMove = false;
      },
    );
  }

  //Die
  @override
  void die() async {
    if (gameRef.player!.lastDirectionHorizontal == Direction.left) {
      gameRef.add(
        AnimatedObjectOnce(
          animation: SuperSpriteSheet.dyingLeft,
          position: position,
          size: size,
          onFinish: () => removeFromParent(),
        ),
      );
    } else {
      gameRef.add(
        AnimatedObjectOnce(
          animation: SuperSpriteSheet.dyingRight,
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
