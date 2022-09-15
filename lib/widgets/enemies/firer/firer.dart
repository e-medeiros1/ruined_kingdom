import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ng_bonfire/utils/basic_value.dart';
import 'package:ng_bonfire/widgets/enemies/firer/firer_sprite_sheet.dart';
// import 'dart:io' show Platform;

const tileSize = BasicValues.TILE_SIZE;

class Firer extends SimpleEnemy
    with ObjectCollision, AutomaticRandomMovement {
  bool canMove = true;
  Firer({required Vector2 position})
      : super(
          life: 300,
          position: position,
          speed: 70,
          size: Vector2(tileSize * 6, tileSize * 6),
          animation: SimpleDirectionAnimation(
            idleRight: FirerSpriteSheet.firerIdleRight,
            idleLeft: FirerSpriteSheet.firerIdleLeft,
            runRight: FirerSpriteSheet.firerRunRight,
            runLeft: FirerSpriteSheet.firerRunLeft,
          ),
        ) {
//Seta colisão
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(16, 30),
            align: Vector2(88, 100),
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
      width: 50,
      borderWidth: 1.5,
      height: 5,
      align: const Offset(90, -60),
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
            radiusVision: tileSize * 6,
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
        initVelocityTop: -2,
        config: TextStyle(
          color: Colors.orange.shade200,
          fontSize: tileSize / 2,
        ),
      );
    }
    super.receiveDamage(attacker, damage, identify);
  }

//Attack animation

  void _addBossAttackAnimation() {
    canMove = false;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = FirerSpriteSheet.attackLeft;
        break;
      case Direction.right:
        newAnimation = FirerSpriteSheet.attackRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = FirerSpriteSheet.attackRight;
        } else {
          newAnimation = FirerSpriteSheet.attackLeft;
        }
        break;

      case Direction.down:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = FirerSpriteSheet.attackRight;
        } else {
          newAnimation = FirerSpriteSheet.attackLeft;
        }
        break;

      case Direction.upLeft:
        newAnimation = FirerSpriteSheet.attackLeft;
        break;

      case Direction.upRight:
        newAnimation = FirerSpriteSheet.attackRight;
        break;

      case Direction.downLeft:
        newAnimation = FirerSpriteSheet.attackLeft;
        break;

      case Direction.downRight:
        newAnimation = FirerSpriteSheet.attackRight;
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
        newAnimation = FirerSpriteSheet.takeHitLeft;
        break;
      case Direction.right:
        newAnimation = FirerSpriteSheet.takeHitRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = FirerSpriteSheet.takeHitRight;
        } else {
          newAnimation = FirerSpriteSheet.takeHitRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = FirerSpriteSheet.takeHitRight;
        } else {
          newAnimation = FirerSpriteSheet.takeHitLeft;
        }
        break;
      case Direction.upLeft:
        newAnimation = FirerSpriteSheet.takeHitLeft;
        break;
      case Direction.upRight:
        newAnimation = FirerSpriteSheet.takeHitRight;
        break;
      case Direction.downLeft:
        newAnimation = FirerSpriteSheet.takeHitLeft;
        break;
      case Direction.downRight:
        newAnimation = FirerSpriteSheet.takeHitRight;
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

  void _execAttack() {
    simpleAttackMelee(
      withPush: false,
      damage: 15,
      size: Vector2.all(tileSize),
      interval: 200,
      execute: () {
        _addBossAttackAnimation();
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
          animation: FirerSpriteSheet.firerDeath,
          position: position,
          size: size,
          onFinish: () => removeFromParent(),
        ),
      );
    } else {
      gameRef.add(
        AnimatedObjectOnce(
          animation: FirerSpriteSheet.firerDeath,
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
