import 'package:bonfire/bonfire.dart';

class BossSpriteSheet {
//Idle
  static Future<SpriteAnimation> get bossIdleLeft => SpriteAnimation.load(
        'enemies/boss/Idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 0.15,
          textureSize: Vector2(158, 158),
        ),
      );
  static Future<SpriteAnimation> get bossIdleRight => SpriteAnimation.load(
        'enemies/boss/Idle_right.png',
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 0.15,
          textureSize: Vector2(158, 158),
        ),
      );

//Run
  static Future<SpriteAnimation> get bossRunLeft => SpriteAnimation.load(
        'enemies/boss/Run_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.2,
          textureSize: Vector2(176, 176),
        ),
      );
  static Future<SpriteAnimation> get bossRunRight => SpriteAnimation.load(
        'enemies/boss/Run_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.2,
          textureSize: Vector2(176, 176),
        ),
      );

//Death
  static Future<SpriteAnimation> get bossDeathLeft => SpriteAnimation.load(
        'enemies/boss/Death_left.png',
        SpriteAnimationData.sequenced(
          amount: 16,
          stepTime: 0.2,
          textureSize: Vector2(124, 124),
        ),
      );
//Death
  static Future<SpriteAnimation> get bossDeathRight => SpriteAnimation.load(
        'enemies/boss/Death_right.png',
        SpriteAnimationData.sequenced(
          amount: 16,
          stepTime: 0.2,
          textureSize: Vector2(109, 109),
        ),
      );

//Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'enemies/boss/Attack_right.png',
        SpriteAnimationData.sequenced(
          amount: 9,
          stepTime: 0.1,
          textureSize: Vector2(167, 167),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'enemies/boss/Attack_left.png',
        SpriteAnimationData.sequenced(
          amount: 9,
          stepTime: 0.1,
          textureSize: Vector2(165, 165),
        ),
      );

  //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'enemies/boss/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(288, 288),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'enemies/boss/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(288, 288),
        ),
      );
}
