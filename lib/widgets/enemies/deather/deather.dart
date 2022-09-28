import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ruined_kingdom/screens/map_render.dart';
import 'package:ruined_kingdom/utils/sounds/sounds.dart';
import 'package:ruined_kingdom/widgets/enemies/deather/deather_sprite_sheet.dart';

class Deather extends SimpleEnemy
    with ObjectCollision, Lighting, AutomaticRandomMovement {
  bool canMove = true;
  Deather({required Vector2 position})
      : super(
          life: 300,
          position: position,
          initDirection: Direction.left,
          speed: 60,
          size: Vector2(tileSize * 7, tileSize * 7),
          animation: SimpleDirectionAnimation(
            idleRight: DeatherSpriteSheet.deatherIdleRight,
            idleLeft: DeatherSpriteSheet.deatherIdleLeft,
            runRight: DeatherSpriteSheet.deatherRunRight,
            runLeft: DeatherSpriteSheet.deatherRunLeft,
          ),
        ) {
//Seta colisão
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(40, 45),
            align: Vector2(95, 130),
          ),
        ],
      ),
    );
    setupLighting(
      LightingConfig(
          radius: tileSize * 1,
          color: Colors.blueGrey.withOpacity(0.25),
          withPulse: true,
          pulseSpeed: 2,
          pulseVariation: 0.12,
          align: Vector2(1, 85),
          blurBorder: 15,
          useComponentAngle: true),
    );
  }

//Life bar
  @override
  void render(Canvas canvas) {
    drawDefaultLifeBar(
      canvas,
      width: 55,
      borderWidth: 1.5,
      height: 5,
      align: const Offset(80, -70),
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
          runRandomMovement(dt, speed: 15, maxDistance: 50);
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
          color: Colors.blue.shade200,
          fontSize: tileSize / 2,
        ),
      );
    }
    super.receiveDamage(attacker, damage, identify);
  }

  void _execAttack() {
    simpleAttackMelee(
      withPush: false,
      damage: 40,
      size: Vector2.all(tileSize * 1.5),
      interval: 800,
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
        newAnimation = DeatherSpriteSheet.attackLeft;
        break;
      case Direction.right:
        newAnimation = DeatherSpriteSheet.attackRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = DeatherSpriteSheet.attackRight;
        } else {
          newAnimation = DeatherSpriteSheet.attackLeft;
        }
        break;

      case Direction.down:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = DeatherSpriteSheet.attackRight;
        } else {
          newAnimation = DeatherSpriteSheet.attackLeft;
        }
        break;

      case Direction.upLeft:
        newAnimation = DeatherSpriteSheet.attackLeft;
        break;

      case Direction.upRight:
        newAnimation = DeatherSpriteSheet.attackRight;
        break;

      case Direction.downLeft:
        newAnimation = DeatherSpriteSheet.attackLeft;
        break;

      case Direction.downRight:
        newAnimation = DeatherSpriteSheet.attackRight;
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
        newAnimation = DeatherSpriteSheet.takeHitLeft;
        break;
      case Direction.right:
        newAnimation = DeatherSpriteSheet.takeHitRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = DeatherSpriteSheet.takeHitRight;
        } else {
          newAnimation = DeatherSpriteSheet.takeHitRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = DeatherSpriteSheet.takeHitRight;
        } else {
          newAnimation = DeatherSpriteSheet.takeHitLeft;
        }
        break;
      case Direction.upLeft:
        newAnimation = DeatherSpriteSheet.takeHitLeft;
        break;
      case Direction.upRight:
        newAnimation = DeatherSpriteSheet.takeHitRight;
        break;
      case Direction.downLeft:
        newAnimation = DeatherSpriteSheet.takeHitLeft;
        break;
      case Direction.downRight:
        newAnimation = DeatherSpriteSheet.takeHitRight;
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
    Sounds.deatherDeath();
    if (gameRef.player!.lastDirectionHorizontal == Direction.left) {
      gameRef.add(
        AnimatedObjectOnce(
          animation: DeatherSpriteSheet.deatherDeathLeft,
          position: position,
          size: size,
          onFinish: () => removeFromParent(),
        ),
      );
    } else {
      gameRef.add(
        AnimatedObjectOnce(
          animation: DeatherSpriteSheet.deatherDeathRight,
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
