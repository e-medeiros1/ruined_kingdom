import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ng_bonfire/widgets/decoration/potion/potion_sprite_sheet.dart';
import 'package:ng_bonfire/widgets/enemies/ghost/ghost.dart';

class Potion extends GameDecoration with Sensor, Lighting {
  Potion({required Vector2 position})
      : super.withAnimation(
            animation: PotionSpriteSheet.potion,
            position: position,
            size: Vector2(tileSize * 1.25, tileSize * 1.25)) {
    setupSensorArea(areaSensor: [
      CollisionArea.rectangle(
        size: Vector2(tileSize / 2, tileSize / 2),
        align: Vector2(12, 15)
      ),
    ]);
    setupLighting(
      LightingConfig(
        radius: tileSize / 2,
        color: Colors.purple.withOpacity(0.25),
        withPulse: true,
        pulseSpeed: 2,
        pulseVariation: 0.15,
        align: Vector2(1, 5),
        blurBorder: 15,
        useComponentAngle: true,
      ),
    );
  }

  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      gameRef.player?.addLife(100);
    } else if (component is Enemy) {
      null;
    }
    removeFromParent();
  }

  @override
  void onContactExit(GameComponent component) {}
}
