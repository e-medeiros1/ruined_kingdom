import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruined_kingdom/screens/map_render.dart';
import 'package:ruined_kingdom/utils/sounds/sounds.dart';
import 'package:ruined_kingdom/widgets/enemies/boss/boss_sprite_sheet.dart';
import 'package:ruined_kingdom/widgets/player/super/super_sprite_sheet.dart';

class Boss extends SimpleEnemy
    with ObjectCollision, Lighting, AutomaticRandomMovement {
  bool canMove = true;
  bool firstSeePlayer = false;
  Boss({required Vector2 position})
      : super(
          life: 600,
          position: position,
          initDirection: Direction.left,
          speed: 85,
          size: Vector2(tileSize * 9, tileSize * 9),
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
            size: Vector2(35, 65),
            align: Vector2(125, 130),
          ),
        ],
      ),
    );
    setupLighting(
      LightingConfig(
          radius: tileSize * 2,
          color: Colors.blue.withOpacity(0.25),
          withPulse: true,
          pulseSpeed: 2,
          pulseVariation: 0.1,
          align: Vector2(5, 35),
          blurBorder: 15,
          useComponentAngle: true),
    );
  }

//Life bar
  @override
  void render(Canvas canvas) {
    drawDefaultLifeBar(
      canvas,
      width: 65,
      borderWidth: 1.5,
      height: 5,
      align: const Offset(100, -35),
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
          firstSeePlayer = true;
          gameRef.camera.moveToTargetAnimated(
            this,
            zoom: 2,
            finish: () {
              _bossConversation();
            },
          );
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
          runRandomMovement(dt, speed: 20, maxDistance: 40);
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
      onFinish: (() {
        canMove = true;
      }),
    );
  }

//Death
  @override
  void die() {
    Sounds.bossDeath();
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

  //Dialogs

  void _bossConversation() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [const TextSpan(text: 'YOU WILL NOT SURVIVE HAHAHA')],
          person: SizedBox(
            width: 100,
            height: 100,
            child: BossSpriteSheet.bossIdleRight.asWidget(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [const TextSpan(text: 'We will see! This is my revenge!')],
          personSayDirection: PersonSayDirection.LEFT,
          person: SizedBox(
            width: 100,
            height: 100,
            child: SuperSpriteSheet.superIdleRight.asWidget(),
          ),
        ),
      ],
      onFinish: () {
        Future.delayed(const Duration(milliseconds: 500), () {
          gameRef.camera.moveToPlayerAnimated();
          Sounds.playBackgroundBoosSound();
        });
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
