import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruined_kingdom/screens/map_render.dart';

class SecondBoard extends GameDecoration with TapGesture {
  SecondBoard({required Vector2 position})
      : super(
          position: position,
          size: Vector2(tileSize, tileSize),
        );

  @override
  void onTap() {
    TalkDialog.show(
      context,
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
