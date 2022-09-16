import 'package:bonfire/bonfire.dart';

class CanineSpriteSheet {
//Idle
  static Future<SpriteAnimation> get canineIdleLeft => SpriteAnimation.load(
        'enemies/canine/Idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(48, 48),
        ),
      );
  static Future<SpriteAnimation> get canineIdleRight =>
      SpriteAnimation.load(
        'enemies/canine/Idle_right.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(48, 48),
        ),
      );

//Run
  static Future<SpriteAnimation> get canineRunLeft => SpriteAnimation.load(
        'enemies/canine/Run_left.png',
        SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.25,
            textureSize: Vector2(48, 48),
            ),
      );
  static Future<SpriteAnimation> get canineRunRight => SpriteAnimation.load(
        'enemies/canine/Run_right.png',
        SpriteAnimationData.sequenced(
            amount: 4,
            stepTime: 0.25,
            textureSize: Vector2(48, 48),
            ),
      );

//Death
  static Future<SpriteAnimation> get canineDeath => SpriteAnimation.load(
        'enemies/canine/Death.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.25,
          textureSize: Vector2(48, 48),
        ),
      );

//Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'enemies/canine/Attack_right.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(48, 48),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'enemies/canine/Attack_left.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(48, 48),
        ),
      );

  //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'enemies/canine/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(48, 48),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'enemies/canine/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(48, 48),
        ),
      );
}
