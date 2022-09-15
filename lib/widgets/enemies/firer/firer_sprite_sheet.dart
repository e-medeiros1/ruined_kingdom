import 'package:bonfire/bonfire.dart';

class FirerSpriteSheet {
//Idle
  static Future<SpriteAnimation> get firerIdleLeft => SpriteAnimation.load(
        'enemies/firer/Idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get firerIdleRight =>
      SpriteAnimation.load(
        'enemies/firer/Idle_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );

//Run
  static Future<SpriteAnimation> get firerRunLeft => SpriteAnimation.load(
        'enemies/firer/Run_left.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.25,
            textureSize: Vector2(150, 150),
            ),
      );
  static Future<SpriteAnimation> get firerRunRight => SpriteAnimation.load(
        'enemies/firer/Run_right.png',
        SpriteAnimationData.sequenced(
            amount: 8,
            stepTime: 0.25,
            textureSize: Vector2(150, 150),
            ),
      );

//Death
  static Future<SpriteAnimation> get firerDeath => SpriteAnimation.load(
        'enemies/firer/Death.png',
        SpriteAnimationData.sequenced(
          amount: 5,
          stepTime: 0.25,
          textureSize: Vector2(150, 150),
        ),
      );

//Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'enemies/firer/Attack_right.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'enemies/firer/Attack_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.1,
          textureSize: Vector2(150, 150),
        ),
      );

  //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'enemies/firer/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'enemies/firer/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(150, 150),
        ),
      );
}
