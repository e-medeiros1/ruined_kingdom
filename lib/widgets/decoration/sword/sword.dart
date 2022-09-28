import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ruined_kingdom/screens/map_render.dart';
import 'package:ruined_kingdom/widgets/decoration/sword/sword_sprite_sheet.dart';
import 'package:ruined_kingdom/widgets/player/super/super.dart';

class Sword extends GameDecoration with Sensor, Lighting {
  Sword({required Vector2 position})
      : super.withAnimation(
            animation: SwordSpriteSheet.sword,
            position: position,
            size: Vector2(tileSize * 1.5, tileSize * 1.5)) {
    setupSensorArea(areaSensor: [
      CollisionArea.rectangle(
        size: Vector2(tileSize, tileSize + 10),
        align: Vector2(2, 6),
      ),
    ]);
    setupLighting(
      LightingConfig(
        radius: tileSize / 1.4,
        color: Colors.blue.withOpacity(0.3),
        withPulse: true,
        pulseSpeed: 1.5,
        pulseVariation: 0.2,
        align: Vector2(1, 5),
        blurBorder: 25,
      ),
    );
  }

  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      especialDamage = 75;
      normalDamage = 50;
    } else if (component is Enemy) {
      null;
    }
    removeFromParent();
  }

  @override
  void onContactExit(GameComponent component) {}
}
