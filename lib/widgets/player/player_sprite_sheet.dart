import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  //Idle
  static Future<SpriteAnimation> get playerIdleLeft => SpriteAnimation.load(
        'hero/Idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get playerIdleRight => SpriteAnimation.load(
        'hero/Idle_right.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
//Run
  static Future<SpriteAnimation> get playerRunLeft => SpriteAnimation.load(
        'hero/Run_left.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get playerRunRight => SpriteAnimation.load(
        'hero/Run_right.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );

  //Atack
  static Future<SpriteAnimation> get attackRight => SpriteAnimation.load(
        'hero/Attack1_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get attackLeft => SpriteAnimation.load(
        'hero/Attack1_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.15,
          textureSize: Vector2(140, 150),
        ),
      );

  //Take hit
  static Future<SpriteAnimation> get takeHitRight => SpriteAnimation.load(
        'hero/Take_hit_right.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get takeHitLeft => SpriteAnimation.load(
        'hero/Take_hit_left.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.15,
          textureSize: Vector2(150, 150),
        ),
      );

  // static Future<SpriteAnimation> fireBallAttackRight() => SpriteAnimation.load(
  //       'decoration/fireball_right.png',
  //       SpriteAnimationData.sequenced(
  //         amount: 3,
  //         stepTime: 0.15,
  //         textureSize: Vector2(23, 23),
  //       ),
  //     );

  // static Future<SpriteAnimation> fireBallAttackLeft() => SpriteAnimation.load(
  //       'decoration/fireball_left.png',
  //       SpriteAnimationData.sequenced(
  //         amount: 3,
  //         stepTime: 0.15,
  //         textureSize: Vector2(23, 23),
  //       ),
  //     );

  // static Future<SpriteAnimation> fireBallAttackTop() => SpriteAnimation.load(
  //       'decoration/fireball_top.png',
  //       SpriteAnimationData.sequenced(
  //         amount: 3,
  //         stepTime: 0.15,
  //         textureSize: Vector2(23, 23),
  //       ),
  //     );

  // static Future<SpriteAnimation> fireBallAttackBottom() => SpriteAnimation.load(
  //       'decoration/fireball_bottom.png',
  //       SpriteAnimationData.sequenced(
  //         amount: 3,
  //         stepTime: 0.15,
  //         textureSize: Vector2(23, 23),
  //       ),
  //     );

  // static Future<SpriteAnimation> fireBallExplosion() => SpriteAnimation.load(
  //       'decoration/explosion_fire.png',
  //       SpriteAnimationData.sequenced(
  //         amount: 6,
  //         stepTime: 0.15,
  //         textureSize: Vector2(32, 32),
  //       ),
  //     );

  //Dying
  static Future<SpriteAnimation> get dyingLeft => SpriteAnimation.load(
        'hero/Death_left.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.25,
          textureSize: Vector2(150, 150),
        ),
      );
  static Future<SpriteAnimation> get dyingRight => SpriteAnimation.load(
        'hero/Death_right.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.25,
          textureSize: Vector2(150, 150),
        ),
      );
}
