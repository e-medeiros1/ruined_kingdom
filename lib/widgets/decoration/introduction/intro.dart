import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruined_kingdom/screens/map_render.dart';

class Intro extends GameDecoration with Sensor {
  Intro({required Vector2 position})
      : super(position: position, size: Vector2.all(32)) {
    setupSensorArea(areaSensor: [
      CollisionArea.rectangle(
        size: Vector2(tileSize, tileSize + 10),
        align: Vector2(2, 6),
      ),
    ]);
  }

  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      _superConversation();
    } else if (component is Enemy) {
      null;
    }
      removeFromParent();
  }

  @override
  void onContactExit(GameComponent component) {}

//Dialog
  void _superConversation() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            const TextSpan(
                text:
                    'Oh Jesus, what happened to this place??? I used to play arround here... With my people...',
                style: TextStyle(fontFamily: 'PressStart2P-Regular'))
          ],
        ),
        Say(
          text: [
            const TextSpan(
                text: 'AAAAAAH! I will kill all these monsters!',
                style: TextStyle(fontFamily: 'PressStart2P-Regular'))
          ],
        ),
      ],
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
