import 'package:bonfire/bonfire.dart';

class BonfireSpriteSheet {
//Idle
  static Future<SpriteAnimation> get bonfire => SpriteAnimation.load(
        'decoration/bonfire.png',
        SpriteAnimationData.sequenced(
          amount: 11,
          stepTime: 0.15,
          textureSize: Vector2(231, 231),
        ),
      );
}
