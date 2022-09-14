import 'package:bonfire/bonfire.dart';

class BossSpriteSheet {
//Idle
  static Future<SpriteAnimation> get bossIdleLeft => SpriteAnimation.load(
        'enemies/Idle_left.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.15,
            textureSize: Vector2(250, 250),
            texturePosition: Vector2(0, 0)),
      );
  static Future<SpriteAnimation> get bossIdleRight => SpriteAnimation.load(
        'enemies/Idle_right.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.15,
            textureSize: Vector2(250, 250),
            texturePosition: Vector2(0, 0)),
      );

//Run
  static Future<SpriteAnimation> get bossRunLeft => SpriteAnimation.load(
        'enemies/Run_left.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.25,
            textureSize: Vector2(250, 250),
            texturePosition: Vector2(0, 0)),
      );
  static Future<SpriteAnimation> get bossRunRight => SpriteAnimation.load(
        'enemies/Run_right.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.25,
            textureSize: Vector2(250, 250),
            texturePosition: Vector2(0, 0)),
      );

//Death
  static Future<SpriteAnimation> get bossDeathRight => SpriteAnimation.load(
        'enemies/Death_right.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.30,
          textureSize: Vector2(250, 250),
        ),
      );
  static Future<SpriteAnimation> get bossDeathLeft => SpriteAnimation.load(
        'enemies/Death_left.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.30,
          textureSize: Vector2(250, 250),
        ),
      );

//Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'enemies/Attack2_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(250, 250),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'enemies/Attack2_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(250, 250),
        ),
      );

      //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'enemies/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(250, 250),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'enemies/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(250, 250),
        ),
      );

}
