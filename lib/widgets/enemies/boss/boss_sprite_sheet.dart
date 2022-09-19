import 'package:bonfire/bonfire.dart';

class BossSpriteSheet {
//Idle
  static Future<SpriteAnimation> get bossIdleLeft => SpriteAnimation.load(
        'enemies/boss/Idle_left.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.15,
            textureSize: Vector2(250, 250),
            texturePosition: Vector2(0, 0)),
      );
  static Future<SpriteAnimation> get bossIdleRight => SpriteAnimation.load(
        'enemies/boss/Idle_right.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.15,
            textureSize: Vector2(250, 250),
            texturePosition: Vector2(0, 0)),
      );

//Run
  static Future<SpriteAnimation> get bossRunLeft => SpriteAnimation.load(
        'enemies/boss/Run_left.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.25,
            textureSize: Vector2(250, 250),
            texturePosition: Vector2(0, 0)),
      );
  static Future<SpriteAnimation> get bossRunRight => SpriteAnimation.load(
        'enemies/boss/Run_right.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.25,
            textureSize: Vector2(250, 250),
            texturePosition: Vector2(0, 0)),
      );

//Death
  static Future<SpriteAnimation> get bossDeathRight => SpriteAnimation.load(
        'enemies/boss/Death_right.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.30,
          textureSize: Vector2(250, 250),
        ),
      );
  static Future<SpriteAnimation> get bossDeathLeft => SpriteAnimation.load(
        'enemies/boss/Death_left.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.30,
          textureSize: Vector2(250, 250),
        ),
      );

//Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'enemies/boss/Attack2_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(250, 250),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'enemies/boss/Attack2_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(250, 250),
        ),
      );

      //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'enemies/boss/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(250, 250),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'enemies/boss/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(250, 250),
        ),
      );

}
