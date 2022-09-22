import 'package:bonfire/bonfire.dart';

class BootsSpriteSheet {
//Idle
  static Future<SpriteAnimation> get boots => SpriteAnimation.load(
        'decoration/boots.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.15,
          textureSize: Vector2(640, 640),
        ),
      );
}
