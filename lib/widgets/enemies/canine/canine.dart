import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ng_bonfire/utils/basic_value.dart';
import 'package:ng_bonfire/widgets/enemies/canine/canine_sprite_sheet.dart';
// import 'dart:io' show Platform;

const tileSize = BasicValues.TILE_SIZE;

class Canine extends SimpleEnemy with ObjectCollision, AutomaticRandomMovement {
  bool canMove = true;
  Canine({required Vector2 position})
      : super(
          life: 100,
          position: position,
          speed: 90,
          size: Vector2(tileSize * 2, tileSize * 2),
          animation: SimpleDirectionAnimation(
            idleRight: CanineSpriteSheet.canineIdleRight,
            idleLeft: CanineSpriteSheet.canineIdleLeft,
            runRight: CanineSpriteSheet.canineRunRight,
            runLeft: CanineSpriteSheet.canineRunLeft,
          ),
        ) {
//Seta colisão
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(25, 20),
            align: Vector2(17, 20),
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
      width: 35,
      borderWidth: 1.5,
      height: 4,
      align: const Offset(25, -10),
      borderRadius: BorderRadius.circular(3),
      borderColor: Colors.black87,
      colorsLife: [
        Colors.red.shade700,
      ],
    );
    super.render(canvas);
  }

//Ataca ao ver
  @override
  void update(double dt) {
    if (canMove) {
      seePlayer(
        observed: (player) {
          seeAndMoveToPlayer(
            // Quando tiver próximo do player, faz:
            closePlayer: (player) {
              followComponent(
                margin: tileSize,
                player,
                dt,
                closeComponent: (player) => _execAttack(),
              );
            },
            radiusVision: tileSize * 8,
            runOnlyVisibleInScreen: true,
            margin: tileSize,
          );
        },
        notObserved: () {
          // runRandomMovement(dt,
          //     maxDistance: 2, runOnlyVisibleInCamera: false, speed: 20);
        },
        radiusVision: tileSize * 6,
      );
    }
    super.update(dt);
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    if (!isDead) {
      _addDamageAnimation();
      showDamage(
        -damage,
        initVelocityTop: -5,
        config: const TextStyle(
          color: Colors.white,
          fontSize: tileSize / 2,
        ),
      );
    }
    super.receiveDamage(attacker, damage, identify);
  }

  void _execAttack() async {
    await Future.delayed(const Duration(milliseconds: 500));
    simpleAttackMelee(
      withPush: false,
      damage: 15,
      size: Vector2.all(tileSize),
      interval: 300,
      execute: () {
        _addBossAttackAnimation();
      },
    );
  }

//Attack animation

  void _addBossAttackAnimation() {
    canMove = false;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = CanineSpriteSheet.attackLeft;
        break;
      case Direction.right:
        newAnimation = CanineSpriteSheet.attackRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = CanineSpriteSheet.attackRight;
        } else {
          newAnimation = CanineSpriteSheet.attackLeft;
        }
        break;

      case Direction.down:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = CanineSpriteSheet.attackRight;
        } else {
          newAnimation = CanineSpriteSheet.attackLeft;
        }
        break;

      case Direction.upLeft:
        newAnimation = CanineSpriteSheet.attackLeft;
        break;

      case Direction.upRight:
        newAnimation = CanineSpriteSheet.attackRight;
        break;

      case Direction.downLeft:
        newAnimation = CanineSpriteSheet.attackLeft;
        break;

      case Direction.downRight:
        newAnimation = CanineSpriteSheet.attackRight;
        break;
    }

    animation!.playOnce(
      newAnimation,
      runToTheEnd: true,
      onFinish: () {
        canMove = true;
      },
    );
  }

//Damage taken
  void _addDamageAnimation() {
    canMove = false;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = CanineSpriteSheet.takeHitLeft;
        break;
      case Direction.right:
        newAnimation = CanineSpriteSheet.takeHitRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = CanineSpriteSheet.takeHitRight;
        } else {
          newAnimation = CanineSpriteSheet.takeHitRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = CanineSpriteSheet.takeHitRight;
        } else {
          newAnimation = CanineSpriteSheet.takeHitLeft;
        }
        break;
      case Direction.upLeft:
        newAnimation = CanineSpriteSheet.takeHitLeft;
        break;
      case Direction.upRight:
        newAnimation = CanineSpriteSheet.takeHitRight;
        break;
      case Direction.downLeft:
        newAnimation = CanineSpriteSheet.takeHitLeft;
        break;
      case Direction.downRight:
        newAnimation = CanineSpriteSheet.takeHitRight;
        break;
    }
    animation!.playOnce(
      newAnimation,
      runToTheEnd: true,
      onFinish: () {
        canMove = true;
      },
    );
  }

//Death
  //Die
  @override
  void die() {
    if (gameRef.player!.lastDirectionHorizontal == Direction.left) {
      gameRef.add(
        AnimatedObjectOnce(
          animation: CanineSpriteSheet.canineDeath,
          position: position,
          size: size,
          onFinish: () => removeFromParent(),
        ),
      );
    } else {
      gameRef.add(
        AnimatedObjectOnce(
          animation: CanineSpriteSheet.canineDeath,
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
