import 'package:bonfire/bonfire.dart';

class SuperSpriteSheet {
  //Idle
  static Future<SpriteAnimation> get superIdleLeft => SpriteAnimation.load(
        'hero/super/Idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 0.15,
          textureSize: Vector2(162, 162),
        ),
      );
  static Future<SpriteAnimation> get superIdleRight => SpriteAnimation.load(
        'hero/super/Idle_right.png',
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 0.15,
          textureSize: Vector2(162, 162),
        ),
      );
//Run
  static Future<SpriteAnimation> get superRunLeft => SpriteAnimation.load(
        'hero/super/Run_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(162, 162),
        ),
      );
  static Future<SpriteAnimation> get superRunRight => SpriteAnimation.load(
        'hero/super/Run_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(162, 162),
        ),
      );

  //Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'hero/super/Attack1_right.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.12,
          textureSize: Vector2(162, 162),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'hero/super/Attack1_left.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.12,
          textureSize: Vector2(162, 162),
        ),
      );
  static Future<SpriteAnimation> get attackEspecialRight => SpriteAnimation.load(
        'hero/super/Attack3_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.13,
          textureSize: Vector2(162, 162),
        ),
      );
  static Future<SpriteAnimation> get attackEspecialLeft => SpriteAnimation.load(
        'hero/super/Attack3_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.13,
          textureSize: Vector2(162, 162),
        ),
      );

  //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'hero/super/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(162, 162),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'hero/super/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(162, 162),
        ),
      );

  //Dying
  static Future<SpriteAnimation> get dyingLeft => SpriteAnimation.load(
        'hero/super/Death.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.25,
          textureSize: Vector2(162, 162),
        ),
      );
  static Future<SpriteAnimation> get dyingRight => SpriteAnimation.load(
        'hero/super/Death_right.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.25,
          textureSize: Vector2(162, 162),
        ),
      );
}
