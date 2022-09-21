import 'package:bonfire/bonfire.dart';

class PotionSpriteSheet {
//Idle
  static Future<SpriteAnimation> get potion => SpriteAnimation.load(
        'decoration/potion.png',
        SpriteAnimationData.sequenced(
          amount: 8,
          stepTime: 0.3,
          textureSize: Vector2(204, 204),
        ),
      );
}
