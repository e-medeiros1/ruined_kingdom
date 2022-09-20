import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ng_bonfire/utils/basic_value.dart';
import 'package:ng_bonfire/widgets/enemies/firer/firer_sprite_sheet.dart';

const tileSize = BasicValues.TILE_SIZE;

class Firer extends SimpleEnemy
    with ObjectCollision, AutomaticRandomMovement {
  bool canMove = true;
  Firer({required Vector2 position})
      : super(
          life: 600,
          position: position,
          speed: 70,
          size: Vector2(tileSize * 10, tileSize * 10),
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
             size: Vector2(32, 55),
            align: Vector2(145, 150),
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
      width: 60,
      borderWidth: 1.5,
      height: 5,
      align: const Offset(120, -80),
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

  
  void _execAttack() async {
    await Future.delayed(const Duration(milliseconds: 300));
    simpleAttackMelee(
      withPush: false,
      damage: 30,
      size: Vector2.all(tileSize),
      interval: 500,
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


//Death
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
