import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_bonfire/screens/map_render.dart';
import 'package:ng_bonfire/widgets/player/super/super_sprite_sheet.dart';

class Super extends SimplePlayer with ObjectCollision {
  bool lockMove = false;
  Super({required Vector2 position})
      : super(
          position: position,
          speed: 180,
          size: Vector2(tileSize * 6, tileSize * 6),
          life: 200,
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
            size: Vector2(16, 27),
            align: Vector2(90, 92),
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
      align: const Offset(75, -50),
      borderRadius: BorderRadius.circular(3),
    );
    super.render(canvas);
  }

  @override
  void joystickAction(JoystickActionEvent event) async {
    if (isDead || lockMove) return;
    if (event.id == 0 && event.event == ActionEvent.DOWN) {
      _addAttackAnimation();
      _meleeAttack();
    }

    if (event.id == LogicalKeyboardKey.space.keyId &&
        event.event == ActionEvent.DOWN) {
      _addAttackAnimation();
      _meleeAttack();
    }

    if (event.id == LogicalKeyboardKey.keyZ.keyId &&
        event.event == ActionEvent.DOWN) {
      _addRangeAttackAnimation();
      _especialAttack();
    }

    if (event.id == 1 && event.event == ActionEvent.DOWN) {
      _addRangeAttackAnimation();
      _especialAttack();
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
  _meleeAttack() async {
    await Future.delayed(const Duration(milliseconds: 500));
    lockMove = true;
    simpleAttackMelee(
      damage: 25,
      size: Vector2.all(tileSize),
      withPush: false,
    );
  }

//Especial Attack
  _especialAttack() async {
    await Future.delayed(const Duration(milliseconds: 500));
    lockMove = true;
    simpleAttackMelee(
        damage: 50,
        size: Vector2.all(tileSize),
        withPush: true,
        sizePush: tileSize / 3);
  }

//Range atack
  void _addRangeAttackAnimation() {
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
  void _addAttackAnimation() {
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
