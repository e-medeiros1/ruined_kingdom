import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruined_kingdom/screens/map_render.dart';

class SecondBoard extends GameDecoration with Sensor {
  SecondBoard({required Vector2 position})
      : super(position: position, size: Vector2.all(tileSize * 2)) {
    setupSensorArea(areaSensor: [
      CollisionArea.rectangle(
        size: Vector2(tileSize * 3, tileSize * 3),
        align: Vector2(-30, -30),
      ),
    ]);
  }
  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      _boardTalk();
      removeFromParent();
    } else if (component is Enemy) {
      null;
    }
  }

  void _boardTalk() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            const TextSpan(
                text: 'A major battle is approaching\n\n',
                style: TextStyle(fontFamily: 'PressStart2P-Regular')),
            const TextSpan(
                text: 'There may be only one way out...\n',
                style: TextStyle(fontFamily: 'PressStart2P-Regular')),
          ],
        ),
      ],
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
