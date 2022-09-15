import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ng_bonfire/utils/basic_value.dart';
import 'package:ng_bonfire/widgets/enemies/boss/boss_sprite_sheet.dart';
// import 'dart:io' show Platform;

const tileSize = BasicValues.TILE_SIZE;

class Boss extends SimpleEnemy with ObjectCollision, AutomaticRandomMovement {
  bool canMove = true;
  Boss({required Vector2 position})
      : super(
          life: 500,
          position: position,
          speed: 50,
          size: Vector2(64 * 5.5, 64 * 5.5),
          animation: SimpleDirectionAnimation(
            idleRight: BossSpriteSheet.bossIdleRight,
            idleLeft: BossSpriteSheet.bossIdleLeft,
            runRight: BossSpriteSheet.bossRunRight,
            runLeft: BossSpriteSheet.bossRunLeft,
          ),
        ) {
//Seta colisão
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(32, 45),
            align: Vector2(155, 195),
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
      width: 70,
      borderWidth: 1.5,
      height: 5,
      align: const Offset(150, -120),
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
          runRandomMovement(dt);
        },
        radiusVision: tileSize * 5,
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
          color: Colors.red.shade600,
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
        newAnimation = BossSpriteSheet.attackLeft;
        break;
      case Direction.right:
        newAnimation = BossSpriteSheet.attackRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = BossSpriteSheet.attackRight;
        } else {
          newAnimation = BossSpriteSheet.attackLeft;
        }
        break;

      case Direction.down:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = BossSpriteSheet.attackRight;
        } else {
          newAnimation = BossSpriteSheet.attackLeft;
        }
        break;

      case Direction.upLeft:
        newAnimation = BossSpriteSheet.attackLeft;
        break;

      case Direction.upRight:
        newAnimation = BossSpriteSheet.attackRight;
        break;

      case Direction.downLeft:
        newAnimation = BossSpriteSheet.attackLeft;
        break;

      case Direction.downRight:
        newAnimation = BossSpriteSheet.attackRight;
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
        newAnimation = BossSpriteSheet.takeHitLeft;
        break;
      case Direction.right:
        newAnimation = BossSpriteSheet.takeHitRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = BossSpriteSheet.takeHitRight;
        } else {
          newAnimation = BossSpriteSheet.takeHitRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = BossSpriteSheet.takeHitRight;
        } else {
          newAnimation = BossSpriteSheet.takeHitLeft;
        }
        break;
      case Direction.upLeft:
        newAnimation = BossSpriteSheet.takeHitLeft;
        break;
      case Direction.upRight:
        newAnimation = BossSpriteSheet.takeHitRight;
        break;
      case Direction.downLeft:
        newAnimation = BossSpriteSheet.takeHitLeft;
        break;
      case Direction.downRight:
        newAnimation = BossSpriteSheet.takeHitRight;
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
      damage: 50,
      size: Vector2.all(tileSize * 3),
      interval: 1500,
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
          animation: BossSpriteSheet.bossDeathLeft,
          position: position,
          size: size,
          onFinish: () => removeFromParent(),
        ),
      );
    } else {
      gameRef.add(
        AnimatedObjectOnce(
          animation: BossSpriteSheet.bossDeathRight,
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
