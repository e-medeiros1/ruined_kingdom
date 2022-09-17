import 'package:bonfire/bonfire.dart';

class HuntressSpriteSheet {
  //Idle
  static Future<SpriteAnimation> get huntressIdleLeft => SpriteAnimation.load(
        'hero/huntress/Idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get huntressIdleRight => SpriteAnimation.load(
        'hero/huntress/Idle_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
//Run
  static Future<SpriteAnimation> get huntressRunLeft => SpriteAnimation.load(
        'hero/huntress/Run_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.13,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get huntressRunRight => SpriteAnimation.load(
        'hero/huntress/Run_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.13,
          textureSize: Vector2(150, 150),
        ),
      );

  //Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'hero/huntress/Attack1_right.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'hero/huntress/Attack1_left.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.1,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get attackRangeRight => SpriteAnimation.load(
        'hero/huntress/Attack3_right.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.1,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get attackRangeLeft => SpriteAnimation.load(
        'hero/huntress/Attack3_left.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.1,
          textureSize: Vector2(150, 150),
        ),
      );

       static Future<SpriteAnimation> spearAttackRight() => SpriteAnimation.load(
        'hero/huntress/Spear_right.png',
        SpriteAnimationData.sequenced(
          amount:4,
          stepTime: 0.12,
          textureSize: Vector2(60, 60),
        ),
      );

  static Future<SpriteAnimation> spearAttackLeft() => SpriteAnimation.load(
        'hero/huntress/Spear_left2.png',
        SpriteAnimationData.sequenced(
          amount:4,
          stepTime: 0.1,
          textureSize: Vector2(60, 30),
        ),
      );

  static Future<SpriteAnimation> spearAttackTop() => SpriteAnimation.load(
        'hero/huntress/Spear_right.png',
        SpriteAnimationData.sequenced(
          amount:4,
          stepTime: 0.1,
          textureSize: Vector2(60, 60),
        ),
      );

  static Future<SpriteAnimation> spearAttackBottom() => SpriteAnimation.load(
        'hero/huntress/Spear_left.png',
        SpriteAnimationData.sequenced(
          amount:4,
          stepTime: 0.1,
          textureSize: Vector2(60, 60),
        ),
      );

  //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'hero/huntress/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'hero/huntress/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );

  //Dying
  static Future<SpriteAnimation> get dyingLeft => SpriteAnimation.load(
        'hero/huntress/Death_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.25,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get dyingRight => SpriteAnimation.load(
        'hero/huntress/Death_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.25,
          textureSize: Vector2(150, 150),
        ),
      );
}
