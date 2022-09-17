import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  //Idle
  static Future<SpriteAnimation> get playerIdleLeft => SpriteAnimation.load(
        'hero/warrior/Idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get playerIdleRight => SpriteAnimation.load(
        'hero/warrior/Idle_right.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
//Run
  static Future<SpriteAnimation> get playerRunLeft => SpriteAnimation.load(
        'hero/warrior/Run_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.13,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get playerRunRight => SpriteAnimation.load(
        'hero/warrior/Run_right.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.13,
          textureSize: Vector2(150, 150),
        ),
      );

  //Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'hero/warrior/Attack1_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'hero/warrior/Attack1_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(140, 150),
        ),
      );

  //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'hero/warrior/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'hero/warrior/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );

  //Dying
  static Future<SpriteAnimation> get dyingLeft => SpriteAnimation.load(
        'hero/warrior/Death_left.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.25,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get dyingRight => SpriteAnimation.load(
        'hero/warrior/Death_right.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.25,
          textureSize: Vector2(150, 150),
        ),
      );
}
