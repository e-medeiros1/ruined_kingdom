import 'package:bonfire/bonfire.dart';

class SwordSpriteSheet {
//Idle
  static Future<SpriteAnimation> get sword => SpriteAnimation.load(
        'decoration/sword.png',
        SpriteAnimationData.sequenced(
          amount: 17,
          stepTime: 0.15,
          textureSize: Vector2(121, 121),
        ),
      );
}
