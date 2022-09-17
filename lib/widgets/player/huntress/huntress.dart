import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_bonfire/screens/map_render.dart';
import 'package:ng_bonfire/widgets/player/huntress/huntress_sprite_sheet.dart';

class Huntress extends SimplePlayer with ObjectCollision {
  bool lockMove = false;
  Huntress({required Vector2 position})
      : super(
          position: position,
          speed: 180,
          size: Vector2(tileSize * 6.5, tileSize * 6.5),
          life: 200,
          animation: SimpleDirectionAnimation(
            idleRight: HuntressSpriteSheet.huntressIdleRight,
            idleLeft: HuntressSpriteSheet.huntressIdleLeft,
            runRight: HuntressSpriteSheet.huntressRunRight,
            runLeft: HuntressSpriteSheet.huntressRunLeft,
          ),
        ) {
//CollisionConfig
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(16, 27),
            align: Vector2(90, 62),
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
      align: const Offset(75, -30),
      borderRadius: BorderRadius.circular(3),
    );
    super.render(canvas);
  }

  // @override
  // void joystickAction(JoystickActionEvent event) {
  //   if (isDead || lockMove) return;
  //   if ((event.id == LogicalKeyboardKey.space.keyId ||
  //           event.id == 0 ||
  //           event.id == 1) &&
  //       event.event == ActionEvent.DOWN) {
  //     _addAttackAnimation();
  //     simpleAttackMelee(
  //       damage: 25,
  //       size: Vector2.all(tileSize),
  //       withPush: false,
  //     );
  //   }
  //   super.joystickAction(event);
  // }

  @override
  void joystickAction(JoystickActionEvent event) {
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
      _rangeAttack();
    }

    if (event.id == 1 && event.event == ActionEvent.DOWN) {
      _addRangeAttackAnimation();
      _rangeAttack();
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

  _meleeAttack() {
    simpleAttackMelee(
      damage: 25,
      size: Vector2.all(tileSize),
      withPush: false,
    );
  }

  _rangeAttack() async {
    await Future.delayed(const Duration(milliseconds: 500));
    simpleAttackRange(
      animationRight: HuntressSpriteSheet.spearAttackRight(),
      animationLeft: HuntressSpriteSheet.spearAttackRight(),
      animationUp: HuntressSpriteSheet.spearAttackRight(),
      animationDown: HuntressSpriteSheet.spearAttackRight(),
      // animationDestroy: HuntressSpriteSheet.fireBallExplosion(),
      size: Vector2(tileSize * 3, tileSize * 3),
      damage: 50,
      speed: 150,
      enableDiagonal: false,
      onDestroy: () {
        // Sounds.explosion();
      },
      collision: CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
              size: Vector2(tileSize / 2, tileSize / 4),
              align: Vector2(73, 13)),
        ],
      ),
      // lightingConfig: LightingConfig(
      //   radius: tileSize * 0.9,
      //   blurBorder: tileSize / 2,
      //   color: Colors.green.withOpacity(0.4),
      // ),
    );
  }

  void _addRangeAttackAnimation() {
    // if (stamina < 10) {
    //   return;
    // }

    // Sounds.attackRange();

    // decrementStamina(10);
    lockMove = true;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirectionHorizontal) {
      case Direction.left:
        newAnimation = HuntressSpriteSheet.attackRangeLeft;
        break;
      case Direction.right:
        newAnimation = HuntressSpriteSheet.attackRangeRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = HuntressSpriteSheet.attackRangeLeft;
        } else {
          newAnimation = HuntressSpriteSheet.attackRangeRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = HuntressSpriteSheet.attackRangeLeft;
        } else {
          newAnimation = HuntressSpriteSheet.attackRangeRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = HuntressSpriteSheet.attackRangeLeft;
        break;
      case Direction.upRight:
        newAnimation = HuntressSpriteSheet.attackRangeRight;
        break;
      case Direction.downLeft:
        newAnimation = HuntressSpriteSheet.attackRangeLeft;
        break;
      case Direction.downRight:
        newAnimation = HuntressSpriteSheet.attackRangeRight;
        break;
    }
    animation!.playOnce(
      newAnimation,
      runToTheEnd: false,
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
        newAnimation = HuntressSpriteSheet.attackLeft;
        break;
      case Direction.right:
        newAnimation = HuntressSpriteSheet.attackRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = HuntressSpriteSheet.attackLeft;
        } else {
          newAnimation = HuntressSpriteSheet.attackRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = HuntressSpriteSheet.attackLeft;
        } else {
          newAnimation = HuntressSpriteSheet.attackRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = HuntressSpriteSheet.attackLeft;
        break;
      case Direction.upRight:
        newAnimation = HuntressSpriteSheet.attackRight;
        break;
      case Direction.downLeft:
        newAnimation = HuntressSpriteSheet.attackLeft;
        break;
      case Direction.downRight:
        newAnimation = HuntressSpriteSheet.attackRight;
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
        newAnimation = HuntressSpriteSheet.takeHitLeft;
        break;
      case Direction.right:
        newAnimation = HuntressSpriteSheet.takeHitRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = HuntressSpriteSheet.takeHitLeft;
        } else {
          newAnimation = HuntressSpriteSheet.takeHitRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = HuntressSpriteSheet.takeHitLeft;
        } else {
          newAnimation = HuntressSpriteSheet.takeHitRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = HuntressSpriteSheet.takeHitLeft;
        break;
      case Direction.upRight:
        newAnimation = HuntressSpriteSheet.takeHitRight;
        break;
      case Direction.downLeft:
        newAnimation = HuntressSpriteSheet.takeHitLeft;
        break;
      case Direction.downRight:
        newAnimation = HuntressSpriteSheet.takeHitRight;
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
          animation: HuntressSpriteSheet.dyingLeft,
          position: position,
          size: size,
          onFinish: () => removeFromParent(),
        ),
      );
    } else {
      gameRef.add(
        AnimatedObjectOnce(
          animation: HuntressSpriteSheet.dyingLeft,
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
