import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruined_kingdom/screens/map_render.dart';
import 'package:ruined_kingdom/widgets/player/super/super_sprite_sheet.dart';

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
              text:
                  'Maybe you are the only hope for this place.\n',
            ),
            const TextSpan(
              text: 'Use all of your resources, we left a BONFIRE behind for you!\n',
            ),
          ],
          personSayDirection: PersonSayDirection.LEFT,
          person: SizedBox(
            width: 100,
            height: 100,
            child: SuperSpriteSheet.superIdleRight.asWidget(),
          ),
        ),
      ],
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
