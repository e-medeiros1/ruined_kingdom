import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ng_bonfire/widgets/decoration/boots/boots_sprite_sheet.dart';
import 'package:ng_bonfire/widgets/enemies/ghost/ghost.dart';

class Boots extends GameDecoration with Sensor, Lighting {
  Boots({required Vector2 position})
      : super.withAnimation(
            animation: BootsSpriteSheet.boots,
            position: position,
            size: Vector2(tileSize / 1.5, tileSize / 1.5)) {
    setupSensorArea(areaSensor: [
      CollisionArea.rectangle(
        size: Vector2(tileSize, tileSize),
        align: Vector2(-5, -5),
      ),
    ]);
    setupLighting(
      LightingConfig(
        radius: tileSize / 1.4,
        color: Colors.brown.withOpacity(0.3),
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
      gameRef.player?.speed = 200;
    } else if (component is Enemy) {
      null;
    }
    removeFromParent();
  }

  @override
  void onContactExit(GameComponent component) {}
}
