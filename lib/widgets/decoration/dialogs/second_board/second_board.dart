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
                  'A major battle is approaching\n',
            ),
            const TextSpan(
              text: 'There may be only one way out...\n',
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
