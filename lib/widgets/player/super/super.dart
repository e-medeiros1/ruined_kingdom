import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruined_kingdom/screens/map_render.dart';

import 'dart:io' show Platform;
import 'dart:async' as async;

import 'package:ruined_kingdom/utils/sounds/sounds.dart';
import 'package:ruined_kingdom/widgets/player/super/super_sprite_sheet.dart';

double especialDamage = 50;
double normalDamage = 25;

class Super extends SimplePlayer with ObjectCollision, Lighting {
  double stamina = 100;
  bool lockMove = false;

  async.Timer? _timerStamina;
  bool containKey = false;
  bool showObserveEnemy = false;

  Super({required Vector2 position})
      : super(
          position: position,
          life: 300,
          size: Vector2(tileSize * 7, tileSize * 7),
          speed: Platform.isAndroid ? 130 : 150,
          animation: SimpleDirectionAnimation(
            idleRight: SuperSpriteSheet.superIdleRight,
            idleLeft: SuperSpriteSheet.superIdleLeft,
            runRight: SuperSpriteSheet.superRunRight,
            runLeft: SuperSpriteSheet.superRunLeft,
          ),
        ) {
//CollisionConfig
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(16, 35),
            align: Vector2(100, 105),
          ),
        ],
      ),
    );
    setupLighting(
      LightingConfig(
        radius: tileSize,
        color: Colors.lightBlue.shade200.withOpacity(0.1),
        align: Vector2(5, 25),
        withPulse: true,
        blurBorder: 30,
      ),
    );
  }

  @override
  void joystickAction(JoystickActionEvent event) async {
    if (isDead || lockMove) return;
    if (event.id == 0 && event.event == ActionEvent.DOWN) {
      if (stamina < 15) return;
      lockMove = true;
      _addAttackAnimation(() {
        lockMove = false;
      });
      _meleeAttack(() {
        lockMove = false;
      });
    }

    if (event.id == LogicalKeyboardKey.space.keyId &&
        event.event == ActionEvent.DOWN) {
      if (stamina < 15) return;
      lockMove = true;
      _addAttackAnimation(() {
        lockMove = false;
      });
      _meleeAttack(() {
        lockMove = false;
      });
    }

    if (event.id == LogicalKeyboardKey.keyZ.keyId &&
        event.event == ActionEvent.DOWN) {
      if (stamina < 50) return;
      lockMove = true;
      _addEspecialAttackAnimation(() {
        lockMove = false;
      });
      _especialAttack(() {
        lockMove = false;
      });
    }

    if (event.id == 1 && event.event == ActionEvent.DOWN) {
      if (stamina < 50) return;
      lockMove = true;
      _addEspecialAttackAnimation(() {
        lockMove = false;
      });
      _especialAttack(() {
        lockMove = false;
      });
    }
    super.joystickAction(event);
  }

//Receive Damage
  @override
  void receiveDamage(AttackFromEnum attacker, double damage, dynamic identify) {
    if (!isDead) {
      showDamage(
        -damage,
        config: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      );
      lockMove = true;
      idle();
      _addDamageAnimation(() {
        lockMove = false;
      });
    }
    super.receiveDamage(attacker, damage, identify);
  }

//Normal Attack
  void _meleeAttack(VoidCallback onFinish) async {
    decrementStamina(15);
    lockMove = true;
    idle();
    await Future.delayed(const Duration(milliseconds: 300));
    Sounds.normalAttack();

    simpleAttackMelee(
      damage: normalDamage,
      size: Vector2.all(tileSize),
      withPush: false,
    );
  }

//Especial Attack
  void _especialAttack(VoidCallback onFinish) async {
    decrementStamina(50);

    lockMove = true;
    idle();

    await Future.delayed(const Duration(milliseconds: 400));
    Sounds.especialAttack();

    simpleAttackMelee(
        damage: especialDamage,
        size: Vector2.all(tileSize + 20),
        withPush: true,
        sizePush: tileSize / 3);
  }

  //Stamina
  @override
  void update(double dt) {
    if (isDead) return;
    _verifyStamina();

    super.update(dt);
  }

  @override
  // ignore: unnecessary_overrides
  void render(Canvas canvas) {
    super.render(canvas);
  }

  void _verifyStamina() {
    if (_timerStamina == null) {
      _timerStamina = async.Timer(const Duration(milliseconds: 150), () {
        _timerStamina = null;
      });
    } else {
      return;
    }

    stamina += 2;
    if (stamina > 100) {
      stamina = 100;
    }
  }

  void decrementStamina(int i) {
    stamina -= i;
    if (stamina < 0) {
      stamina = 0;
    }
  }

//Range atack
  void _addEspecialAttackAnimation(VoidCallback onFinish) {
    lockMove = true;
    idle();
    Future<SpriteAnimation> newAnimation;
    switch (lastDirectionHorizontal) {
      case Direction.left:
        newAnimation = SuperSpriteSheet.attackEspecialLeft;
        break;
      case Direction.right:
        newAnimation = SuperSpriteSheet.attackEspecialRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = SuperSpriteSheet.attackEspecialLeft;
        } else {
          newAnimation = SuperSpriteSheet.attackEspecialRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = SuperSpriteSheet.attackEspecialLeft;
        } else {
          newAnimation = SuperSpriteSheet.attackEspecialRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = SuperSpriteSheet.attackEspecialLeft;
        break;
      case Direction.upRight:
        newAnimation = SuperSpriteSheet.attackEspecialRight;
        break;
      case Direction.downLeft:
        newAnimation = SuperSpriteSheet.attackEspecialLeft;
        break;
      case Direction.downRight:
        newAnimation = SuperSpriteSheet.attackEspecialRight;
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

//Attack animation
  void _addAttackAnimation(VoidCallback onFinish) {
    lockMove = true;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = SuperSpriteSheet.attackLeft;
        break;
      case Direction.right:
        newAnimation = SuperSpriteSheet.attackRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.up) {
          newAnimation = SuperSpriteSheet.attackLeft;
        } else {
          newAnimation = SuperSpriteSheet.attackRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.down) {
          newAnimation = SuperSpriteSheet.attackLeft;
        } else {
          newAnimation = SuperSpriteSheet.attackRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = SuperSpriteSheet.attackLeft;
        break;
      case Direction.upRight:
        newAnimation = SuperSpriteSheet.attackRight;
        break;
      case Direction.downLeft:
        newAnimation = SuperSpriteSheet.attackLeft;
        break;
      case Direction.downRight:
        newAnimation = SuperSpriteSheet.attackRight;
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
    lockMove = true;
    Future<SpriteAnimation> newAnimation;
    switch (lastDirection) {
      case Direction.left:
        newAnimation = SuperSpriteSheet.takeHitLeft;
        break;
      case Direction.right:
        newAnimation = SuperSpriteSheet.takeHitRight;
        break;
      case Direction.up:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SuperSpriteSheet.takeHitLeft;
        } else {
          newAnimation = SuperSpriteSheet.takeHitRight;
        }
        break;
      case Direction.down:
        if (lastDirectionHorizontal == Direction.left) {
          newAnimation = SuperSpriteSheet.takeHitLeft;
        } else {
          newAnimation = SuperSpriteSheet.takeHitRight;
        }
        break;
      case Direction.upLeft:
        newAnimation = SuperSpriteSheet.takeHitLeft;
        break;
      case Direction.upRight:
        newAnimation = SuperSpriteSheet.takeHitRight;
        break;
      case Direction.downLeft:
        newAnimation = SuperSpriteSheet.takeHitLeft;
        break;
      case Direction.downRight:
        newAnimation = SuperSpriteSheet.takeHitRight;
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
    Sounds.superDeath();
    if (gameRef.player!.lastDirectionHorizontal == Direction.left) {
      gameRef.add(
        AnimatedObjectOnce(
          animation: SuperSpriteSheet.dyingLeft,
          position: position,
          size: size,
          onFinish: () => removeFromParent(),
        ),
      );
    } else {
      gameRef.add(
        AnimatedObjectOnce(
          animation: SuperSpriteSheet.dyingRight,
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
