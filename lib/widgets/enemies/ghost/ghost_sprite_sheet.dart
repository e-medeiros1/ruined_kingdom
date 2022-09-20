import 'package:bonfire/bonfire.dart';

class GhostSpriteSheet {
//Idle
  static Future<SpriteAnimation> get ghostIdleLeft => SpriteAnimation.load(
        'enemies/ghost/Idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(167, 167),
        ),
      );
  static Future<SpriteAnimation> get ghostIdleRight =>
      SpriteAnimation.load(
        'enemies/ghost/Idle_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(167, 167),
        ),
      );

//Run
  static Future<SpriteAnimation> get ghostRunLeft => SpriteAnimation.load(
        'enemies/ghost/Run_left.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.2,
            textureSize: Vector2(167, 167),
            ),
      );
  static Future<SpriteAnimation> get ghostRunRight => SpriteAnimation.load(
        'enemies/ghost/Run_right.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.2,
            textureSize: Vector2(167, 167),
            ),
      );

//Death
  static Future<SpriteAnimation> get ghostDeathLeft => SpriteAnimation.load(
        'enemies/ghost/Death_left.png',
        SpriteAnimationData.sequenced(
          amount: 14,
          stepTime: 0.2,
          textureSize: Vector2(126, 126),
        ),
      );
//Death
  static Future<SpriteAnimation> get ghostDeathRight => SpriteAnimation.load(
        'enemies/ghost/Death_right.png',
        SpriteAnimationData.sequenced(
          amount: 14,
          stepTime: 0.2,
          textureSize: Vector2(126, 126),
        ),
      );

//Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'enemies/ghost/Attack_right.png',
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 0.1,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'enemies/ghost/Attack_left.png',
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 0.1,
          textureSize: Vector2(150, 150),
        ),
      );

  //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'enemies/ghost/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(274, 274),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'enemies/ghost/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(274, 274),
        ),
      );
}
