import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ng_bonfire/utils/basic_value.dart';
import 'package:ng_bonfire/widgets/enemies/ghost/ghost_sprite_sheet.dart';

const tileSize = BasicValues.TILE_SIZE;

class Ghost extends SimpleEnemy
    with ObjectCollision, AutomaticRandomMovement {
  bool canMove = true;
  Ghost({required Vector2 position})
      : super(
          life: 300,
          position: position,
          speed: 70,
          size: Vector2(tileSize * 7, tileSize * 7),
          animation: SimpleDirectionAnimation(
            idleRight: GhostSpriteSheet.ghostIdleRight,
            idleLeft: GhostSpriteSheet.ghostIdleLeft,
            runRight: GhostSpriteSheet.ghostRunRight,
            runLeft: GhostSpriteSheet.ghostRunLeft,
          ),
        ) {
//Seta colisão
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
             size: Vector2(30, 45),
            align: Vector2(115, 120),
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
      width: 55,
      borderWidth: 1.5,
      height: 5,
      align: const Offset(105, -50),
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
        initVelocityTop: -5,
        maxDownSize: 20,
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
        newAnimation = GhostSpriteSheet.attackLeft;
        break;
      case Direction.right:
        newAnimation = GhostSpriteSheet.attackRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = GhostSpriteSheet.attackRight;
        } else {
          newAnimation = GhostSpriteSheet.attackLeft;
        }
        break;

      case Direction.down:
        if (lastDirectionHorizontal == Direction.right) {
          newAnimation = GhostSpriteSheet.attackRight;
        } else {
          newAnimation = GhostSpriteSheet.attackLeft;
        }
        break;

      case Direction.upLeft:
        newAnimation = GhostSpriteSheet.attackLeft;
        break;

      case Direction.upRight:
        newAnimation = GhostSpriteSheet.attackRight;
        break;

      case Direction.downLeft:
        newAnimation = GhostSpriteSheet.attackLeft;
        break;

      case Direction.downRight:
        newAnimation = GhostSpriteSheet.attackRight;
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
        newAnimation = GhostSpriteSheet.takeHitLeft;
        break;
      case Direction.right:
        newAnimation = GhostSpriteSheet.takeHitRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = GhostSpriteSheet.takeHitRight;
        } else {
          newAnimation = GhostSpriteSheet.takeHitRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = GhostSpriteSheet.takeHitRight;
        } else {
          newAnimation = GhostSpriteSheet.takeHitLeft;
        }
        break;
      case Direction.upLeft:
        newAnimation = GhostSpriteSheet.takeHitLeft;
        break;
      case Direction.upRight:
        newAnimation = GhostSpriteSheet.takeHitRight;
        break;
      case Direction.downLeft:
        newAnimation = GhostSpriteSheet.takeHitLeft;
        break;
      case Direction.downRight:
        newAnimation = GhostSpriteSheet.takeHitRight;
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
          animation: GhostSpriteSheet.ghostDeathLeft,
          position: position,
          size: size,
          onFinish: () => removeFromParent(),
        ),
      );
    } else {
      gameRef.add(
        AnimatedObjectOnce(
          animation: GhostSpriteSheet.ghostDeathRight,
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
