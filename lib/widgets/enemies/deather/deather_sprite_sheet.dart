import 'package:bonfire/bonfire.dart';

class DeatherSpriteSheet {
//Idle
  static Future<SpriteAnimation> get deatherIdleLeft => SpriteAnimation.load(
        'enemies/deather/Idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.15,
          textureSize: Vector2(226, 226),
        ),
      );
  static Future<SpriteAnimation> get deatherIdleRight => SpriteAnimation.load(
        'enemies/deather/Idle_right.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.15,
          textureSize: Vector2(226, 226),
        ),
      );

//Run
  static Future<SpriteAnimation> get deatherRunLeft => SpriteAnimation.load(
        'enemies/deather/Run_left.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.2,
          textureSize: Vector2(226, 226),
        ),
      );
  static Future<SpriteAnimation> get deatherRunRight => SpriteAnimation.load(
        'enemies/deather/Run_right.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.2,
          textureSize: Vector2(226, 226),
        ),
      );

//Death
  static Future<SpriteAnimation> get deatherDeathLeft => SpriteAnimation.load(
        'enemies/deather/Death_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.2,
          textureSize: Vector2(179, 179),
        ),
      );
//Death
  static Future<SpriteAnimation> get deatherDeathRight => SpriteAnimation.load(
        'enemies/deather/Death_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.2,
          textureSize: Vector2(179, 179),
        ),
      );

//Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'enemies/deather/Attack_right.png',
        SpriteAnimationData.sequenced(
          amount: 11,
          stepTime: 0.1,
          textureSize: Vector2(154, 152),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'enemies/deather/Attack_left.png',
        SpriteAnimationData.sequenced(
          amount: 11,
          stepTime: 0.1,
          textureSize: Vector2(152, 152),
        ),
      );

  //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'enemies/deather/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(301, 301),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'enemies/deather/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(301, 301),
        ),
      );
}
