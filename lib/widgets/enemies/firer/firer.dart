import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ruined_kingdom/screens/map_render.dart';
import 'package:ruined_kingdom/utils/sounds/sounds.dart';
import 'package:ruined_kingdom/widgets/enemies/firer/firer_sprite_sheet.dart';

class Firer extends SimpleEnemy
    with ObjectCollision, Lighting, AutomaticRandomMovement {
  bool canMove = true;
  Firer({required Vector2 position})
      : super(
          life: 500,
          position: position,
          speed: 70,
          size: Vector2(tileSize * 7.5, tileSize * 7.5),
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
            size: Vector2(25, 45),
            align: Vector2(105, 110),
          ),
        ],
      ),
    );
    setupLighting(
      LightingConfig(
          radius: tileSize * 1.5,
          color: Colors.orange.withOpacity(0.25),
          withPulse: true,
          pulseSpeed: 2,
          pulseVariation: 0.15,
          align: Vector2(5, 30),
          blurBorder: 15,
          useComponentAngle: true),
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
          runRandomMovement(dt, speed: 20, maxDistance: 50);
        },
        radiusVision: tileSize * 8,
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

  void _execAttack() {
    simpleAttackMelee(
      withPush: false,
      damage: 30,
      size: Vector2.all(tileSize * 1.3),
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
      runToTheEnd: false,
      onFinish: (() {
        canMove = true;
      }),
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
      onFinish: (() {
        canMove = true;
      }),
    );
  }

//Death
  @override
  void die() {
    Sounds.firerDeath();
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
