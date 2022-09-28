import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ruined_kingdom/screens/map_render.dart';
import 'package:ruined_kingdom/utils/sounds/sounds.dart';
import 'package:ruined_kingdom/widgets/enemies/canine/canine_sprite_sheet.dart';

class Canine extends SimpleEnemy
    with ObjectCollision, Lighting, AutomaticRandomMovement {
  bool canMove = true;
  Canine({required Vector2 position})
      : super(
          life: 100,
          position: position,
          speed: 100,
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
    setupLighting(
      LightingConfig(
          radius: tileSize * .7,
          color: Colors.black.withOpacity(0.45),
          withPulse: true,
          pulseSpeed: 2,
          pulseVariation: 0.12,
          align: Vector2(5, 10),
          blurBorder: 15,
          useComponentAngle: true),
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
      align: const Offset(23, -8),
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
          runRandomMovement(dt, speed: 15, maxDistance: 30);
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
        config: TextStyle(
          color: Colors.white,
          fontSize: tileSize / 2,
        ),
      );
    }
    super.receiveDamage(attacker, damage, identify);
  }

  void _execAttack() {
    simpleAttackMelee(
      withPush: false,
      damage: 20,
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
      onFinish: (() {
        canMove = true;
      }),
    );
  }

//Death
  //Die
  @override
  void die() {
    Sounds.canineDeath();
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
