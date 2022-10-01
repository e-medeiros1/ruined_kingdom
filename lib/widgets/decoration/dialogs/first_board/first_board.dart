import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruined_kingdom/screens/map_render.dart';

class FirstBoard extends GameDecoration with TapGesture {
  FirstBoard({required Vector2 position})
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
                text: 'Maybe you are the only hope for this place.\n\n',
                style: TextStyle(fontFamily: 'PressStart2P-Regular')),
            const TextSpan(
                text:
                    'Use all of your resources, we left a BONFIRE behind for you!\n',
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
