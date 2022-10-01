import 'package:bonfire/bonfire.dart';

class HealSpriteSheet {
//Idle
   static Future<SpriteAnimation> get heal => SpriteAnimation.load(
        'decoration/heal.png',
        SpriteAnimationData.sequenced(
          amount: 10,
          stepTime: 0.30,
          textureSize: Vector2(129, 129),
        ),
      );

}
