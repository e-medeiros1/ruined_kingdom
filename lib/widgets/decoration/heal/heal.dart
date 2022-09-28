import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ruined_kingdom/screens/map_render.dart';
import 'package:ruined_kingdom/widgets/decoration/heal/heal_sprite_sheet.dart';

class Heal extends GameDecoration with Lighting {
  Heal({required Vector2 position})
      : super.withAnimation(
            animation: HealSpriteSheet.heal,
            position: position,
            size: Vector2(tileSize * 1.3, tileSize * 1.5)) {
    setupLighting(
      LightingConfig(
        radius: tileSize / 2,
        color: Colors.green.withOpacity(0.5),
        withPulse: true,
        pulseSpeed: 1.5,
        pulseVariation: 0.2,
        align: Vector2(1, 5),
        blurBorder: 20,
      ),
    );
  }
}
